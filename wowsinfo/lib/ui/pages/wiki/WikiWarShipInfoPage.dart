import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart' as Wiki;
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipModule.dart';
import 'package:wowsinfo/core/parsers/API/WikiShipInfoParser.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';

/// WikiWarShipInfoPage class
class WikiWarShipInfoPage extends StatefulWidget {
  final Wiki.Warship ship;
  WikiWarShipInfoPage({Key key, @required this.ship}) : super(key: key);

  @override
  _WikiWarShipInfoPageState createState() => _WikiWarShipInfoPageState();
}

class _WikiWarShipInfoPageState extends State<WikiWarShipInfoPage> {
  final pref = Preference.shared;
  bool loading = true;
  bool error = false;
  WikiShipInfo info;
  /// Modules can be changed by users
  WikiShipModule modules;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ship.shipIdAndIdStr)
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (error) return SizedBox.shrink();
    if (loading) return buildLoading();
    return buildInfo();
  }

  Center buildLoading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Hero(
              tag: widget.ship.shipId,
              child: Image(
                image: NetworkImage(widget.ship.smallImage), 
              ),
            ),
            const PlatformLoadingIndiactor(),
          ],
        ),
      ),
    );
  }

  /// Build ship info, everything
  Widget buildInfo() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Image(image: NetworkImage(widget.ship.smallImage)),
              Text(widget.ship.tierName, style: textTheme.headline6),
              Text(widget.ship.nationShipType),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(info.description, style: textTheme.bodyText1, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build ship parameter
  Widget buildParameter() {
    
  }
}
