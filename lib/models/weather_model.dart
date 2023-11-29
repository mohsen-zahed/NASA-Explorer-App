class WeatherModel {
  final String cityName;
  final double temprature;
  final String mainCondition;

  WeatherModel({
    required this.cityName,
    required this.temprature,
    required this.mainCondition,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temprature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
