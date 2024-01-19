class PlanetModel {
  int id;
  String planetName;
  String planetImageUrl;
  String planetSubTitle;
  String planetIntro;
  String planetHistory;
  String planetClimate;
  String planetWallpaper;

  PlanetModel.create(
    this.id,
    this.planetName,
    this.planetImageUrl,
    this.planetSubTitle,
    this.planetIntro,
    this.planetHistory,
    this.planetClimate,
    this.planetWallpaper,
  );

  int getId() => id;
  String getPlanetName() => planetName;
  String getPlanetWallpaper() => planetWallpaper;
  String getPlanetImageUrl() => planetImageUrl;
  String getPlanetSubTitle() => planetSubTitle;
  String getPlanetIntro() => planetIntro;
  String getPlanetHistory() => planetHistory;
  String getPlanetClimate() => planetClimate;
}
