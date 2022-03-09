import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 128,
        centerTitle: true,
        title: Text('\n\nWelcome to WoWs Info!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Please select your server',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('Russia'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('Europe'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('North America'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('Asia'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
