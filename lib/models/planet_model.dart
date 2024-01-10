class PlanetModel {
  int id;
  String planetName;
  String planetImageUrl;
  String planetSubTitle;
  String planetIntro;
  String planetHistory;
  String planetClimate;

  PlanetModel.create(
      this.id,
      this.planetName,
      this.planetImageUrl,
      this.planetSubTitle,
      this.planetIntro,
      this.planetHistory,
      this.planetClimate);

  int getId() => id;
  String getPlanetName() => planetName;
  String getPlanetImageUrl() => planetImageUrl;
  String getPlanetSubTitle() => planetSubTitle;
  String getPlanetIntro() => planetIntro;
  String getPlanetHistory() => planetHistory;
  String getPlanetClimate() => planetClimate;
}
