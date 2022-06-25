import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
          ),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            renderClan(),
            renderPlayer(),
          ],
        ),
      ),
    );
  }

  Widget renderClan() {
    return Column(
      children: [
        Text(
          Localisation.of(context).menu_search_clan,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget renderPlayer() {
    return Column(
      children: [
        Text(
          Localisation.of(context).menu_search_player,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
