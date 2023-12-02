class ImageModel {
  String? apodSite;
  String? copyRight;
  String? date;
  String? description;
  String? hdurl;
  String? imageThumbnail;
  String? mediaType;
  String? title;
  String? url;

  ImageModel();
  ImageModel.init({
    required this.apodSite,
    required this.copyRight,
    required this.date,
    required this.description,
    required this.hdurl,
    required this.imageThumbnail,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel.init(
      apodSite: json['apod_site'] ?? '',
      copyRight: json['copyRight'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      hdurl: json['hdurl'] ??
          'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain',
      imageThumbnail: json['image_thumbnail'] ?? '',
      mediaType: json['media_type'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? 'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['apod_site'] = apodSite;
    data['copyRight'] = copyRight;
    data['data'] = date;
    data['description'] = description;
    data['hdurl'] = hdurl;
    data['image_thumbnail'] = imageThumbnail;
    data['media_type'] = mediaType;
    data['title'] = title;
    data['url'] = url;
    return data;
  }

  String getHdurl() =>
      hdurl ??
      'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
  String getUrl() =>
      url ??
      'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
}
