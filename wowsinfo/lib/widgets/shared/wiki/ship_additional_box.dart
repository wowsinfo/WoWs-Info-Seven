import 'package:flutter/material.dart';
import 'package:wowsinfo/extensions/number.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/gamedata/ship_additional.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';

class ShipAdditionalBox extends StatelessWidget {
  const ShipAdditionalBox({
    Key? key,
    required this.shipAdditional,
  }) : super(key: key);

  final ShipAdditional shipAdditional;

  @override
  Widget build(BuildContext context) {
    final battles = shipAdditional.battles;
    final localised = Localisation.of(context);
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      spacing: 16,
      children: [
        TextWithCaption(
          title: localised.warship_avg_damage,
          value: shipAdditional.damage.toDecimalString(),
        ),
        TextWithCaption(
          title: localised.warship_avg_winrate,
          value: shipAdditional.winrate.asPercentString(),
        ),
        TextWithCaption(
          title: localised.warship_avg_frag,
          value: shipAdditional.frags.toDecimalString(),
        ),
        if (battles != null)
          TextWithCaption(
            title: Localisation.instance.battles,
            value: battles.toDecimalString(),
          ),
      ],
    );
  }
}
