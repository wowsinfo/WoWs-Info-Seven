import 'package:flutter/material.dart';

/// SearchPage class
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
  String input;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.search, size: 32),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration.collapsed(
                  hintText: 'Search players or clans',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                ),
                cursorColor: Colors.white70,
                autocorrect: false,
                autofocus: true,
                onChanged: (t) {
                  setState(() {
                    this.input = t;
                  });
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ],
        )
      ),
      body: Container(),
    );
  }
}
