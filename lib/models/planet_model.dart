class PlanetModel {
  int id;
  String planetName;
  String planetImageUrl;
  String planetSubTitle;
  String planetIntro;
  String planetHistory;
  String planetClimate;
  String planetWallpaper;
  String postedBy;

  PlanetModel.create({
    required this.id,
    required this.planetName,
    required this.planetImageUrl,
    required this.planetSubTitle,
    required this.planetIntro,
    required this.planetHistory,
    required this.planetClimate,
    required this.planetWallpaper,
    required this.postedBy,
  });

  int getId() => id;
  String getPlanetName() => planetName;
  String getPlanetWallpaper() => planetWallpaper;
  String getPlanetImageUrl() => planetImageUrl;
  String getPlanetSubTitle() => planetSubTitle;
  String getPlanetIntro() => planetIntro;
  String getPlanetHistory() => planetHistory;
  String getPlanetClimate() => planetClimate;
  String getPostedBy() => postedBy;
}
