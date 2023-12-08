import 'package:nasa_explorer_app_project/constants/variables.dart';

class ImageModel {
  String hdurl;
  String url;
  ImageModel.init({
    required this.hdurl,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel.init(
      hdurl: json['hdurl'] ?? demoImagePlaceHolder,
      url: json['url'] ?? demoImagePlaceHolder,
    );
  }

  String getHdurl() => hdurl;
  String getUrl() => url;
}
