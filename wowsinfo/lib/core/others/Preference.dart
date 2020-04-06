/// It manages all user preferences including those that are used in app provider
/// This is the `Preference` class
class Preference {
  bool firstLaunch;

  Preference.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      // Set up all default values
      this.firstLaunch = true;
    } else {
      this.firstLaunch = json["firstLaunch"];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "firstLaunch": this.firstLaunch,
    };
  }
}
