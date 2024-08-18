class FlavorConfig {
  String? appTitle;
  String? buildType;
  Map<String, dynamic>? baseApiDetails;

  FlavorConfig({
    this.appTitle,
    this.buildType,
    this.baseApiDetails
  });

  FlavorConfig.fromJson(Map<String, dynamic> json) {
    appTitle = json['appTitle'];
    buildType = json['buildType'];
    baseApiDetails = json['baseApiDetails'];
  }

  Map<String, dynamic> toJson() => {
    'appTitle': appTitle,
    'buildType': buildType,
    'baseApiDetails':baseApiDetails
  };
}