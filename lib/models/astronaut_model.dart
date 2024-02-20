class AstronautModel {
  late int id;
  late String anstronautName;
  late String dateOfBirth;
  late String placeOfBirth;
  late String astronautBiography;
  late List<String> astronautMissions;
  late String astronautImage;

  AstronautModel.create({
    required this.id,
    required this.anstronautName,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.astronautBiography,
    required String astronautMissions,
    required this.astronautImage,
  }) {
    final separatorPattern = RegExp(r'[,|-| ]');
    this.astronautMissions = astronautMissions.split(separatorPattern);
  }

  int getId() => id;
  String getAstronautName() => anstronautName;
  String getDateOfBirth() => dateOfBirth;
  String getPlaceOfBirth() => placeOfBirth;
  String getAstronautBiography() => astronautBiography;
  List<String> getAstronautMissions() => astronautMissions;
  String getAstronautImage() => astronautImage;
}
