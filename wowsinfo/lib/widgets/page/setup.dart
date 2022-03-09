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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _appLogoWithText(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please select your server',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            _buildServerButton('Russia'),
            _buildServerButton('Europe'),
            _buildServerButton('North America'),
            _buildServerButton('Asia'),
          ],
        ),
      ),
    );
  }

  Widget _appLogoWithText() {
    return Column(
      children: [
        Container(
          height: 128,
          width: 128,
          color: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'WoWs Info',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildServerButton(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: 148,
        height: 32,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ElevatedButton(
            child: Text(title),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
