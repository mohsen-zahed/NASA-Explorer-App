class PostModel {
  late int id;
  late String author;
  late String authorImage;
  late String date;
  late String explanation;
  late String title;
  late String url;
  late int likesCount;
  late bool isLiked;

  PostModel();
  PostModel.init({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.date,
    required this.explanation,
    required this.title,
    required this.url,
    required this.likesCount,
    required this.isLiked,
  });

  // factory NewsModel.fromJson(Map<String, dynamic> json) {
  //   return NewsModel.init(
  //     author: json['copyright'] ?? 'Unknown',
  //     date: json['date'] ?? '2002-1-17',
  //     explanation: json['explanation'] ?? '...',
  //     title: json['title'] ?? 'a title from NASA',
  //     url: json['url'] ?? demoImagePlaceHolder,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['apod_site'] = apodSite;
  //   data['date'] = date;
  //   data['explanation'] = explanation;
  //   data['title'] = title;
  //   data['url'] = url;
  //   return data;
  // }

  int getId() => id;
  String getAuthor() => author;
  String getAuthorImage() => authorImage;
  String getDate() => date;
  String getExplanation() => explanation;
  String getTitle() => title;
  String getUrl() => url;
  int getLikesCount() => likesCount;
  bool getIsLiked() => isLiked;
}
