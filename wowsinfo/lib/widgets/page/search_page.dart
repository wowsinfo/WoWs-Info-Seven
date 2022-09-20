import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/extensions/list.dart';
import 'package:wowsinfo/foundation/helpers/utils.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/models/wargaming/search_result.dart';
import 'package:wowsinfo/providers/search_provider.dart';
import 'package:wowsinfo/widgets/animation/debut_effect.dart';
import 'package:wowsinfo/widgets/shared/icon_ink_well.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final provider = SearchProvider(searchController);
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: provider,
        builder: (context, child) => Column(
          children: [
            renderSearchBar(
              context,
              searchController,
              provider.search,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    renderClan(context),
                    renderPlayer(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A rounded search bar with a back button
  Widget renderSearchBar(
    BuildContext context,
    TextEditingController? controller,
    void Function(String)? onSubmitted,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(100),
        child: Row(
          children: [
            IconInkWell(
              icon: Icons.arrow_back,
              onTap: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: false,
                controller: controller,
                onSubmitted: onSubmitted,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, value, child) => AnimatedOpacity(
                opacity: value.canClear ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: IconInkWell(
                  icon: Icons.close,
                  onTap: () => value.resetAll(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text renderTitle(BuildContext context, String title, int count) {
    return Text(
      '$title ($count)',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget renderClan(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              context,
              Localisation.of(context).menu_search_clan,
              provider.numOfClans,
            ),
          ),
          renderWrap(context, provider.clans),
        ],
      ),
    );
  }

  Widget renderPlayer(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: renderTitle(
              context,
              Localisation.of(context).menu_search_player,
              provider.numOfPlayers,
            ),
          ),
          renderWrap(context, provider.players),
        ],
      ),
    );
  }

  Widget renderWrap(BuildContext context, List<SearchResult> result) {
    final count = Utils(context).getItemCount(6, 1, 300);
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<SearchProvider>(context, listen: false);
    final itemSize = result.length.toDouble();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: result.enumerate().map((item) {
        final index = item.key;
        final value = item.value;
        return DebutEffect(
          keepAlive: false,
          intervalStart: index / itemSize,
          child: SizedBox(
            width: width / count,
            child: ListTile(
              title: Text(value.displayName),
              trailing: Text(value.id),
              onTap: () => provider.onResultSelected(context, value),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
