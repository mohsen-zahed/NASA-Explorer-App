class NasaMissionModel {
  int id;
  String missionName;
  String missionSubtitle;
  String missionImageUrl;
  String missionExplanation;

  NasaMissionModel.create(
    this.id,
    this.missionName,
    this.missionSubtitle,
    this.missionImageUrl,
    this.missionExplanation,
  );

  int getId() => id;
  String getMissionName() => missionName;
  String getMissionSubtitle() => missionSubtitle;
  String getMissionImageUrl() => missionImageUrl;
  String getMissionExplanation() => missionExplanation;
}
