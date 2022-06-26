import 'package:flutter/material.dart';
import 'package:wowsinfo/foundation/app.dart';
import 'package:wowsinfo/repositories/game_repository.dart';
import 'package:wowsinfo/widgets/page/wiki/upgrade_page.dart';
import 'package:wowsinfo/widgets/shared/max_width_box.dart';

class AppLoadingPage extends StatefulWidget {
  const AppLoadingPage({Key? key}) : super(key: key);

  @override
  State<AppLoadingPage> createState() => _AppLoadingPageState();
}

class _AppLoadingPageState extends State<AppLoadingPage> {
  @override
  void initState() {
    super.initState();
    App.instance.inject(context);
    GameRepository.instance.initialise().then((value) {
      // TODO: go to home screen here
      Navigator.of(context).push(
        App.platformPageRoute(builder: (_) => UpgradePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaxWidthBox(
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
