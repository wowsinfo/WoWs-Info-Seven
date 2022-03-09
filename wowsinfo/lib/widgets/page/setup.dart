import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  double? serverHeight = 0;
  double logoOpacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        logoOpacity = 1;
      });

      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          serverHeight = null;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: logoOpacity,
              duration: const Duration(milliseconds: 500),
              child: _appLogoWithText(),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: SizedBox(
                height: serverHeight,
                child: Column(
                  children: [
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _appLogoWithText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (serverHeight == 0) {
            serverHeight = null;
          } else {
            serverHeight = 0;
          }
        });
      },
      child: Column(
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
      ),
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
