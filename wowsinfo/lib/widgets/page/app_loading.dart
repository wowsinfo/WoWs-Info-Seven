import 'package:flutter/material.dart';
import 'package:wowsinfo/repositories/game_repository.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  @override
  void initState() {
    super.initState();
    GameRepository.instance.initialise().then((value) {
      // go to home screen here
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
