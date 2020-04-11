/// This is the `WikiEncyclopedia` class
class WikiEncyclopedia {
  Map<String, String> language;
  ShipModule shipModule;
  ShipTypeImage shipTypeImage;
  Map<String, String> shipNation;
  ShipType shipType;
  String gameVersion;

  WikiEncyclopedia.fromJson(Map<String, dynamic> json) {
    this.language = json['languages'];
    this.shipModule = json['ship_modules'];
    this.shipTypeImage = json['ship_type_images'];
    this.shipNation = json['ship_nations'];
    this.shipType = json['ship_types'];
    this.gameVersion = json['game_version'];
  }

  Map<String, dynamic> toJson() {
    return {
      'languages': this.language,
      'ship_modules': this.shipModule,
      'ship_type_images': this.shipTypeImage,
      'ship_nations': this.shipNation,
      'ship_types': this.shipType,
      'game_version': this.gameVersion,
    };
  }
}

/// This is the `ShipModule` class
class ShipModule {
  String engine;
  String flightControl;
  String suo;
  String hull;
  String artillery;
  String torpedoe;
  String torpedoBomber;
  String diveBomber;
  String fighter;

  ShipModule.fromJson(Map<String, dynamic> json) {
    this.engine = json['Engine'];
    this.flightControl = json['FlightControl'];
    this.suo = json['Suo'];
    this.hull = json['Hull'];
    this.artillery = json['Artillery'];
    this.torpedoe = json['Torpedoes'];
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
      'Torpedoes': this.torpedoe,
      'TorpedoBomber': this.torpedoBomber,
      'DiveBomber': this.diveBomber,
      'Fighter': this.fighter,
    };
  }
}

/// This is the `ShipTypeImage` class
class ShipTypeImage {
  Cruiser cruiser;
  AirCarrier airCarrier;
  Battleship battleship;
  Destroyer destroyer;
  Submarine submarine;

  ShipTypeImage.fromJson(Map<String, dynamic> json) {
    this.cruiser = json['Cruiser'];
    this.airCarrier = json['AirCarrier'];
    this.battleship = json['Battleship'];
    this.destroyer = json['Destroyer'];
    this.submarine = json['Submarine'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Cruiser': this.cruiser,
      'AirCarrier': this.airCarrier,
      'Battleship': this.battleship,
      'Destroyer': this.destroyer,
      'Submarine': this.submarine,
    };
  }
}

/// This is the `Cruiser` class
class Cruiser {
  String imagePremium;
  String image;

  Cruiser.fromJson(Map<String, dynamic> json) {
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

/// This is the `AirCarrier` class
class AirCarrier {
  String imagePremium;
  String image;

  AirCarrier.fromJson(Map<String, dynamic> json) {
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

/// This is the `Battleship` class
class Battleship {
  String imagePremium;
  String image;

  Battleship.fromJson(Map<String, dynamic> json) {
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

/// This is the `Destroyer` class
class Destroyer {
  String imagePremium;
  String image;

  Destroyer.fromJson(Map<String, dynamic> json) {
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

/// This is the `Submarine` class
class Submarine {
  String imagePremium;
  String image;

  Submarine.fromJson(Map<String, dynamic> json) {
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

/// This is the `ShipType` class
class ShipType {
  String destroyer;
  String airCarrier;
  String battleship;
  String cruiser;
  String submarine;

  ShipType.fromJson(Map<String, dynamic> json) {
    this.destroyer = json['Destroyer'];
    this.airCarrier = json['AirCarrier'];
    this.battleship = json['Battleship'];
    this.cruiser = json['Cruiser'];
    this.submarine = json['Submarine'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Destroyer': this.destroyer,
      'AirCarrier': this.airCarrier,
      'Battleship': this.battleship,
      'Cruiser': this.cruiser,
      'Submarine': this.submarine,
    };
  }
}
