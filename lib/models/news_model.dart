import 'package:nasa_explorer_app_project/constants/variables.dart';

class NewsModel {
  String? copyRight;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;

  NewsModel();
  NewsModel.init({
    required this.copyRight,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.serviceVersion,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel.init(
      copyRight: json['copyright'] ?? '',
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      hdurl: json['hdurl'] ?? demoImagePlaceHolder,
      serviceVersion: json['service_version'] ?? '',
      mediaType: json['media_type'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? demoImagePlaceHolder,
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['apod_site'] = apodSite;
  //   data['copyRight'] = copyRight;
  //   data['date'] = date;
  //   data['explanation'] = explanation;
  //   data['hdurl'] = hdurl;
  //   data['image_thumbnail'] = serviceVersion;
  //   data['media_type'] = mediaType;
  //   data['title'] = title;
  //   data['url'] = url;
  //   return data;
  // }

  String getCopyRight() => copyRight ?? 'Unknown';
  String getDate() => date ?? '2002-1-17';
  String getexplanation() => explanation ?? '...';
  String getHdurl() => hdurl ?? demoImagePlaceHolder;
  String getserviceVersion() => serviceVersion ?? '';
  String getMediaType() => mediaType ?? '';
  String getTitle() => title ?? '';
  String getUrl() => url ?? demoImagePlaceHolder;
}
