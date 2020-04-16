import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart' as Wiki;
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipModule.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/parsers/API/WikiShipInfoParser.dart';
import 'package:wowsinfo/ui/pages/wiki/WikiWarshipSimilarPage.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipAverageStats.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipParameter.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// WikiWarShipInfoPage class
class WikiWarShipInfoPage extends StatefulWidget {
  final Wiki.Warship ship;
  WikiWarShipInfoPage({Key key, @required this.ship}) : super(key: key);

  @override
  _WikiWarShipInfoPageState createState() => _WikiWarShipInfoPageState();
}

class _WikiWarShipInfoPageState extends State<WikiWarShipInfoPage> with SingleTickerProviderStateMixin {
  final pref = Preference.shared;
  AppLocalization lang;
  bool loading = true;
  bool error = false;
  WikiShipInfo info;
  /// Modules can be changed by users
  WikiShipModule modules;

  ScrollController controller;
  AnimationController slideController;
  Animation<Offset> offset;
  Iterable<Wiki.Warship> similarShips;
  bool showSimilar = true;

  @override
  void initState() {
    super.initState();
    // Setup scroll controller to hide bottom app bar
    this.controller = ScrollController();
    controller.addListener(() {
      final direction = controller.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (showSimilar) {
          slideController.forward();
          setState(() {
            showSimilar = false;
          });
        }
      } else if (direction == ScrollDirection.forward) {
        if (!showSimilar) {
          slideController.reverse();
          setState(() {
            showSimilar = true;
          });
        }
      }
    });

    // Setup slide controller
    this.slideController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    this.offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0)).animate(slideController);

    // Find similar ships
    this.similarShips = CachedData.shared.warship.values.where((s) {
      return widget.ship.isSimilar(s);
    });

    // Load data
    final parser = WikiShipInfoParser(pref.gameServer, widget.ship.shipId);
    parser.download().then((value) {
      this.info = parser.parse(value);
      this.modules = info.defaultProfile;
      setState(() {
        loading = false;
        // The value must not be null
        error = this.info == null;
      });
    }).catchError((e) => setState(() => error = true));
  }

  @override
  Widget build(BuildContext context) {
    // Setup localization
    lang = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ship.shipIdAndIdStr)
      ),
      body: SafeArea(child: buildBody()),
      bottomNavigationBar: AnimatedSwitcher(
        transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
        duration: Duration(milliseconds: 300),
        child: showSimilar ? BottomAppBar(
          child: SizedBox(
            height: 130,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(4),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: similarShips.map((e) {
                          if (e.shipId == widget.ship.shipId) return SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: WikiWarshipCell(ship: e, showDetail: true),
                          );
                        }).toList(growable: false),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => WikiWarshipSimilarPage(ships: similarShips)));
                  }, child: Text('Text ship compare')),
                ),
              ],
            ),
          ),
        ) : SizedBox.shrink(),
      ),
    );
  }

  /// Build title with style, `headline6`
  Widget buildTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(title, style: Theme.of(context).textTheme.headline6),
  );

  Text buildWeaponName(String name) => Text(
    name, textAlign: TextAlign.center, 
    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
  );

  Widget buildBody() {
    if (error) return SizedBox.shrink();
    return buildInfo();
  }

  Wrap wrapWidget(double width, List<Widget> widget) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: widget.map((e) => SizedBox(
        width: width,
        child: e,
      )).toList(growable: false),
    );
  }

  Widget buildInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      controller: controller,
      child: Center(
        child: Column(
          children: [
            Hero(
              tag: widget.ship.shipId,
              child: Image(image: NetworkImage(widget.ship.smallImage)),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.linearToEaseOut,
              transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
              child: buildContent()
            ),
          ],
        ),
      ),
    );
  }

  /// Build ship info, everything
  Widget buildContent() {
    if (loading) return Center(child: const PlatformLoadingIndiactor());

    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        buildTitle(widget.ship.tierName),
        Text(widget.ship.nationShipType),
        buildShipPrice(),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ShipAverageStats(shipId: info.shipId),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(info.description, style: textTheme.bodyText1, textAlign: TextAlign.center),
        ),
        buildParameter(),
        SizedBox(height: 8),
        Utils.of(context).isTablet() 
        ? renderTablet()
        : renderMobile(), 
      ],
    );
  }

  Widget renderMobile() {
    return Column(
      children: [
        buildSurvivability(),
        buildArtillery(),
        buildSecondary(),
        buildTorpedo(),
        buildAA(),
      ],
    );
  }

  Widget renderTablet() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: [
              buildSurvivability(),
              buildAA(),
            ],
          )
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              buildArtillery(),
              buildSecondary(),
              buildTorpedo(),
            ],
          )
        ),
      ],
    );
  }

  /// A gold colour is used if it is priced by gold
  Widget buildShipPrice() {
    if (info.priceGold > 0) return Text(info.priceGold.toString(), style: TextStyle(color: Colors.orange));
    return Text(info.priceCredit.toString(), style: TextStyle(color: Colors.blueGrey));
  }

  /// Build ship parameter
  Widget buildParameter() {
    return Column(
      children: modules.getParameter(context).map((e) => 
        ShipParameter(paramater: e)).toList(growable: false),
    );
  }

  Widget buildSurvivability() {
    final armour = modules.armour;
    if (armour == null) return SizedBox.shrink();
    return Column(
      children: <Widget>[
        buildTitle('Sur'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWithCaption(
              title: 'a',
              value: armour.health.toString(),
            ),
            TextWithCaption(
              title: 'a',
              value: armour.armourString,
            ),
            TextWithCaption(
              title: 'a',
              value: armour.protectionString,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget buildArtillery() {
    final main = modules.artillery;
    if (main == null) return SizedBox.shrink();
    return Column(
      children: [
        buildTitle('Main (${main.rangeString})'),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: [
            TextWithCaption(
              title: 'a',
              value: main.reloadTime.toStringAsFixed(1),
            ),
            TextWithCaption(
              title: 'a',
              value: main.configurationString,
            ),
            TextWithCaption(
              title: 'a',
              value: main.dispersionString,
            ),
            TextWithCaption(
              title: 'a',
              value: main.rotationString,
            ),
            TextWithCaption(
              title: 'sigma',
              value: main.rotationString,
            ),
          ],
        ),
        Column(
          children: main.shellReversed.map((e) => Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                buildWeaponName(e.shellNameWithType),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextWithCaption(
                      title: 'a',
                      value: e.fireChance.toString(),
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.damageString,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.speed,
                    ),
                  ],
                ),
              ],
            ),
          )).toList(growable: false),
        ),
        Divider(),
      ],
    );
  }

  Widget buildSecondary() {
    final secondary = modules.atba;
    if (secondary == null) return SizedBox.shrink();
    return Column(
      children: [
        buildTitle('Secondary (${secondary.rangeString})'),
        Column(
          children: secondary.slots.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                buildWeaponName(e.nameWithShellType),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    TextWithCaption(
                      title: 'a',
                      value: e.reloadTime,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.speedString,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.fireChance,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.damageString,
                    ),
                  ],
                ),
              ],
            ),
          )).toList(growable: false),
        ),
        Divider(),
      ],
    );
  }

  Widget buildTorpedo() {
    final torp = modules.torpedoe;
    if (torp == null) return SizedBox.shrink();
    return Column(
      children: [
        buildTitle('Torp (${torp.range})'),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: buildWeaponName(torp.torpedoName),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWithCaption(
              title: 'a',
              value: torp.reloadString,
            ),
            TextWithCaption(
              title: 'a',
              value: torp.damageString,
            ),
            TextWithCaption(
              title: 'a',
              value: torp.configuration,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWithCaption(
              title: 'a',
              value: torp.detection,
            ),
            TextWithCaption(
              title: 'a',
              value: torp.torpSpeed,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget buildAA() {
    final aa = modules.antiAircraft;
    if (aa == null) return SizedBox.shrink();
    return Column(
      children: [
        buildTitle('AA'),
        Column(
          children: aa.slots.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                buildWeaponName(e.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextWithCaption(
                      title: 'a',
                      value: e.configuration,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.rangeString,
                    ),
                    TextWithCaption(
                      title: 'a',
                      value: e.damageString,
                    ),
                  ],
                ),
              ],
            ),
          )).toList(growable: false),
        ),
        Divider(),
      ],
    );
  }
}
