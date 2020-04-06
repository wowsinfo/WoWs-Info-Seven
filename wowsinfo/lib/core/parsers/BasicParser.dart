/// This is the base of all parsers, it fetches data and parse it to objects
abstract class BasicParser {
  String link;

  BasicParser(this.link);
  
  /// Parse json to object
  Object parse(String json);
}
