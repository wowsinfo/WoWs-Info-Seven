import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
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
      body: Column(
        children: [
          renderSearchBar(),
          Expanded(
            child: SingleChildScrollView(
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
          ),
        ],
      ),
    );
  }

  /// A rounded search bar with a back button
  Widget renderSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(100),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) => _provider.search(value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
          ],
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              Localisation.of(context).menu_search_clan,
              provider.numOfClans,
            ),
          ),
          renderGrid(provider.clans),
        ],
      ),
    );
  }

  Widget renderPlayer() {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              Localisation.of(context).menu_search_player,
              provider.numOfPlayers,
            ),
          ),
          renderGrid(provider.players),
        ],
      ),
    );
  }

  Widget renderGrid(List<SearchResult> result) {
    final count = Utils(context).getItemCount(6, 1, 300);
    final width = MediaQuery.of(context).size.width;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: result
          .map((e) => SizedBox(
                width: width / count,
                child: ListTile(
                  title: Text(e.displayName),
                  trailing: Text(e.id),
                  onTap: () {},
                ),
              ))
          .toList(growable: false),
    );
  }
}
