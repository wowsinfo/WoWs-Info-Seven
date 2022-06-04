import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/widgets/page/app_loading.dart';
import 'package:wowsinfo/widgets/page/debug_page.dart';
import 'package:wowsinfo/widgets/page/setup.dart';

class WoWsInfoApp extends StatelessWidget {
  const WoWsInfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupListeners(context);
    return MaterialApp(
      title: 'WoWs Info',
      localizationsDelegates: Localisation.localizationsDelegates,
      supportedLocales: Localisation.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const GlobalShortcuts(
        child: DebugPage(),
      ),
    );
  }

  /// Setup top level listeners to monitor system changes
  /// like language, brightness and more.
  void setupListeners(BuildContext context) {
    final logger = Logger('WoWsInfoApp');
    final window = WidgetsBinding.instance.window;
    window.onLocaleChanged = () {
      logger.info('Locale changed to ${window.locale}');
    };
    window.onPlatformBrightnessChanged = () {
      logger.info(
        'Platform brightness changed to ${window.platformBrightness}',
      );
    };
  }
}

class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    Logger('LoggingActionDispatcher').fine(
      'Action invoked: $action($intent) from $context',
    );
    super.invokeAction(action, intent, context);

    return null;
  }
}

class GlobalShortcuts extends StatelessWidget {
  const GlobalShortcuts({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const GoBackIntent(),
      },
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: {
          GoBackIntent: GoBackAction(context),
        },
        child: child,
      ),
    );
  }
}

class GoBackIntent extends Intent {
  const GoBackIntent();
}

class GoBackAction extends Action<GoBackIntent> {
  GoBackAction(this.context);

  final BuildContext context;
  final _logger = Logger('GoBackAction');

  @override
  Object? invoke(GoBackIntent intent) {
    _logger.info('Go back');
    Navigator.pop(context);
    return null;
  }
}
