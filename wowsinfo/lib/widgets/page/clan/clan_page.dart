import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/wargaming/clan_information.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/providers/clan/clan_provider.dart';
import 'package:wowsinfo/widgets/shared/text_with_caption.dart';

class ClanPage extends StatefulWidget {
  const ClanPage({
    Key? key,
    required this.clan,
  }) : super(key: key);

  final ClanResult clan;

  @override
  State<ClanPage> createState() => _ClanPageState();
}

class _ClanPageState extends State<ClanPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClanProvider(widget.clan),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.clan.clanId.toString()),
        ),
        body: Consumer<ClanProvider>(
          builder: (context, provider, child) => renderBody(provider),
        ),
      ),
    );
  }

  Widget renderBody(ClanProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              provider.tag,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Text(
              provider.tagDescription,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 32,
              children: [
                TextWithCaption(
                  title: Localisation.of(context).clan_created_date,
                  value: provider.createdDate,
                ),
                TextWithCaption(
                  title: Localisation.of(context).clan_creator_name,
                  value: provider.creatorName,
                ),
                TextWithCaption(
                  title: Localisation.of(context).clan_leader_name,
                  value: provider.leaderName,
                ),
              ],
            ),
            renderClanDescription(provider.description),
            Text(
              '${Localisation.of(context).clan_member_title} (${provider.memberCount})',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            renderMembers(context, provider.members),
          ],
        ),
      );
    }
  }

  Widget renderClanDescription(String? description) {
    if (description == null) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      );
    }
  }

  Widget renderMembers(BuildContext context, Iterable<ClanMember>? members) {
    if (members == null) {
      return const SizedBox.shrink();
    }

    final count = Utils(context).getItemCount(6, 1, 300);
    final width = MediaQuery.of(context).size.width;
    // final provider = Provider.of<ClanProvider>(context, listen: false);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: members
          .map((e) => SizedBox(
                width: width / count,
                child: ListTile(
                  title: Text(e.accountName ?? '-'),
                  subtitle: Text(e.role ?? '-'),
                  trailing: Text(e.joinedAt?.dateString ?? '-'),
                  onTap: () {},
                ),
              ))
          .toList(growable: false),
    );
  }
}
