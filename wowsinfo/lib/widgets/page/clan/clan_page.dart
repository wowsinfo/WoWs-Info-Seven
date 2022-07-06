import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/providers/clan/clan_provider.dart';

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
          children: [
            Text(
              provider.tag,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      );
    }
  }
}
