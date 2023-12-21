class PlanetModel {
  int id;
  String planetName;
  String planetSubTitle;
  String planetIntro;
  String planetHistory;
  String planetClimate;

  PlanetModel.create(this.id, this.planetName, this.planetSubTitle,
      this.planetIntro, this.planetHistory, this.planetClimate);

  int getId() => id;
  String getPlanetName() => planetName;
  String getPlanetSubTitle() => planetSubTitle;
  String getPlanetIntro() => planetIntro;
  String getPlanetHistory() => planetHistory;
  String getPlanetClimate() => planetClimate;
}
