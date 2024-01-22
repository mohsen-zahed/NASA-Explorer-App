class NasaMissionModel {
  int id;
  String missionName;
  String missionSubtitle;
  String missionImageUrl;
  String missionExplanation;
  String postedBy;
  String postedDate;

  NasaMissionModel.create({
    required this.id,
    required this.missionName,
    required this.missionSubtitle,
    required this.missionImageUrl,
    required this.missionExplanation,
    required this.postedBy,
    required this.postedDate,
  });

  int getId() => id;
  String getMissionName() => missionName;
  String getMissionSubtitle() => missionSubtitle;
  String getMissionImageUrl() => missionImageUrl;
  String getMissionExplanation() => missionExplanation;
  String getPostedBy() => postedBy;
  String getPostedDate() => postedDate;
}
