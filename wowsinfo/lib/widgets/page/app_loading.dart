import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/page/wiki/achievement_page.dart';
import 'package:wowsinfo/widgets/page/wiki/consumable_page.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  @override
  void initState() {
    super.initState();
    App.instance.inject(context);
    GameRepository.instance.initialise().then((value) {
      // TODO: go to home screen here
      Navigator.of(context).push(
        App.platformPageRoute(builder: (_) => ConsumablePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  value: 0.9,
                  minHeight: 8,
                ),
              ),
              const Text('Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
