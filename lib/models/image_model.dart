import 'package:nasa_explorer_app_project/constants/variables.dart';

class ImageModel {
  String? hdurl;
  String? url;

  ImageModel();
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hdurl'] = hdurl;
    data['url'] = url;
    return data;
  }

  String getHdurl() => hdurl ?? demoImagePlaceHolder;
  String getUrl() => url ?? demoImagePlaceHolder;
}
