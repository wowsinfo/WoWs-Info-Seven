/// All four servers
enum Server {
  RU,
  EU,
  NA,
  ASIA
}

/// This wraps around `Sever` and provides useful functions
class GameServer {
  /// The domain wargaming uses
  final _domain = ['ru', 'eu', 'com', 'asia'];
  /// The domain wows-numbers.com uses
  final _numberDomain = ['ru.', '', 'na.', 'asia.'];

  Server _server;
  Server get server => _server;
  int get index => Server.values.indexOf(_server);
  void updateServer(Server server) => this._server = server;

  GameServer(this._server);
  GameServer.fromIndex(int index) {
    // this index shouldn't be null because we will set it up first but just in case
    if (index == null) this._server = Server.ASIA;
    else this._server = Server.values[index];
  }
  
  /// This only returns the domain
  String toDomain() => _domain[_server.index];
  /// wows-numbers.com by default is eu
  String toWoWsNumbers() => 'https://${_numberDomain[_server.index]}wows-numbers.com';
}
