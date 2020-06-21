import '../Cacheable.dart';

/// This is the `WikiEncyclopedia` class
class WikiEncyclopedia extends Cacheable {
  Map<String, String> language;
  ShipModule shipModule;
  Map<String, ShipTypeImage> shipTypeImage;
  Map<String, String> shipNation;
  Map<String, String> shipType;
  String gameVersion;

  WikiEncyclopedia.fromJson(Map<String, dynamic> json) : super(json) {
    this.language = (json['languages'] as Map).cast<String, String>();
    if (json['ship_modules'] != null)
      this.shipModule = ShipModule.fromJson(json['ship_modules']);
    this.shipTypeImage = (json['ship_type_images'] as Map)
        .map((a, b) => MapEntry(a, ShipTypeImage.fromJson(b)));
    this.shipNation = (json['ship_nations'] as Map).cast<String, String>();
    this.shipType = (json['ship_types'] as Map).cast<String, String>();
    this.gameVersion = json['game_version'];
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': this.language,
      'ship_modules': this.shipModule,
      'ship_type_images': this.shipTypeImage.cast<String, dynamic>(),
      'ship_nations': this.shipNation,
      'ship_types': this.shipType,
      'game_version': this.gameVersion,
    };
  }

  @override
  bool isValid() =>
      language.isNotEmpty && shipNation.isNotEmpty && shipType.isNotEmpty;
}

/// This is the `ShipModule` class
class ShipModule {
  String engine;
  String flightControl;
  String suo;
  String hull;
  String artillery;
  String torpedo;
  String torpedoBomber;
  String diveBomber;
  String fighter;

  ShipModule.fromJson(Map<String, dynamic> json) {
    this.engine = json['Engine'];
    this.flightControl = json['FlightControl'];
    this.suo = json['Suo'];
    this.hull = json['Hull'];
    this.artillery = json['Artillery'];
    this.torpedo = json['Torpedoes'];
    this.torpedoBomber = json['TorpedoBomber'];
    this.diveBomber = json['DiveBomber'];
    this.fighter = json['Fighter'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Engine': this.engine,
      'FlightControl': this.flightControl,
      'Suo': this.suo,
      'Hull': this.hull,
      'Artillery': this.artillery,
      'Torpedoes': this.torpedo,
      'TorpedoBomber': this.torpedoBomber,
      'DiveBomber': this.diveBomber,
      'Fighter': this.fighter,
    };
  }
}

/// This is the `ShipTypeImage` class
class ShipTypeImage {
  String imagePremium;
  String image;

  ShipTypeImage.fromJson(Map<String, dynamic> json) {
    this.imagePremium = json['image_premium'];
    this.image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image_premium': this.imagePremium,
      'image': this.image,
    };
  }
}
