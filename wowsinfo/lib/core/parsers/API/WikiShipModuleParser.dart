import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipModule.dart';

import 'APIParser.dart';

class WikiShipModuleParser extends APIParser {
  String _id;
  ShipModule _module;

  Map<String, String> get _apiMap => {
    _module.engine: 'engine_id',
    _module.torpedoBomber: 'torpedo_bomber_id',
    _module.fighter: 'fighter_id',
    _module.hull: 'hull_id',
    _module.artillery: 'artillery_id',
    _module.torpedo: 'torpedoes_id',
    _module.suo: 'fire_control_id',
    _module.flightControl: 'fire_control_id',
    _module.diveBomber: 'dive_bomber_id',
  };

  WikiShipModuleParser(CachedData cached, GameServer server, int shipId, Map<String, int> modules) : super(server) {
    this._module = cached.shipModule;
    this._id = shipId.toString();
    this.link += '/wows/encyclopedia/shipprofile/';
    addAPIKey();
    this.link += '&ship_id=$_id';
    this.link += '&' + modules.entries.map((e) {
      final key = e.key;
      final currModule = e.value;
      return '${_apiMap[key]}=$currModule';
    }).join('&');
  }

  @override
  WikiShipModule parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiShipModule(json[0]['data'][_id]);
    return first;
  }
}
