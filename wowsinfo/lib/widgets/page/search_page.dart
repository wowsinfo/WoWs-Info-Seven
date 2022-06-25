import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/providers/search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  late final _provider = SearchProvider(_searchController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
          ),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider.value(
          value: _provider,
          builder: (context, provider) => Column(
            children: [
              renderClan(),
              renderPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Text renderTitle(String title, int count) {
    return Text(
      '$title ($count)',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget renderClan() {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              Localisation.of(context).menu_search_clan,
              provider.numOfClans,
            ),
          ),
          renderList(provider.clans),
        ],
      ),
    );
  }

  Widget renderPlayer() {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              Localisation.of(context).menu_search_player,
              provider.numOfPlayers,
            ),
          ),
          renderList(provider.players),
        ],
      ),
    );
  }

  Widget renderList(List<SearchResult> result) {
    return Column(
      children: [
        for (final item in result)
          ListTile(
            title: Text(item.displayName),
            trailing: Text(item.id),
            onTap: () {},
          ),
      ],
    );
  }
}
