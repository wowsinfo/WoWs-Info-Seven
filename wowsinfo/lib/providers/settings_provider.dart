import 'package:flutter/material.dart';
import 'package:wowsinfo/localisation/localisation.dart';
import 'package:wowsinfo/repositories/user_repository.dart';
import 'package:wowsinfo/widgets/page/app_settings_page.dart';

class SettingsProvider with ChangeNotifier {
  final BuildContext _context;
  final UserRepository _userRepository = UserRepository.instance;

  SettingsProvider(this._context) {
    _server = _userRepository.gameServer;

    // build the server list
    final localised = Localisation.of(_context);
    servers = [
      DropdownValue(value: 0, title: localised.server_russia),
      DropdownValue(value: 1, title: localised.server_europe),
      DropdownValue(value: 2, title: localised.server_north_america),
      DropdownValue(value: 3, title: localised.server_asia),
    ];
  }

  late int _server;
  int get serverValue => _server;

  late final List<DropdownValue<int>> servers;

  final colours = AppThemeColour.colourList;

  void updateServer(int index) {
    _server = index;
    _userRepository.gameServer = _server;
    notifyListeners();
  }
}
