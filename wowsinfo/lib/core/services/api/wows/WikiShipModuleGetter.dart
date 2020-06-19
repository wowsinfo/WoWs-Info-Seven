import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'package:wowsinfo/core/providers/CachedData.dart';
import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/WoWsApiService.dart';

class WikiShipModuleGetter extends WoWsApiService {
  final String _id;
  final ShipModule _shipModule;
  final Map<String, int> _modules;

  Map<String, String> _getApiMap() => {
    _shipModule.engine: 'engine_id',
    _shipModule.torpedoBomber: 'torpedo_bomber_id',
    _shipModule.fighter: 'fighter_id',
    _shipModule.hull: 'hull_id',
    _shipModule.artillery: 'artillery_id',
    _shipModule.torpedo: 'torpedoes_id',
    _shipModule.suo: 'fire_control_id',
    _shipModule.flightControl: 'fire_control_id',
    _shipModule.diveBomber: 'dive_bomber_id',
  };

  WikiShipModuleGetter(GameServer server, this._id, this._shipModule, this._modules) : super(server);
  
  @override
  String getDomainFields() => 'wows/encyclopedia/shipprofile/';

  @override
  String getExtraFields() => '&ship_id=$_id&' + _modules.entries.map((e) {
      final key = e.key;
      final currModule = e.value;
      return '${_getApiMap()[key]}=$currModule';
    }).join('&');
}
