class ImageModel {
  late int id;
  late String url;
  late String imageDescription;
  late String date;
  late String authorImage;
  late String authorName;
  late int likesCount;
  late bool isLiked;
  late String postedBy;

  ImageModel.init({
    required this.id,
    required this.url,
    required this.imageDescription,
    required this.date,
    required this.authorName,
    required this.likesCount,
    required this.isLiked,
    required this.authorImage,
    required this.postedBy,
  });

  int getId() => id;
  String getUrl() => url;
  String getImageDescription() => imageDescription;
  String getDate() => date;
  String getAuthorImage() => authorImage;
  String getAuthorName() => authorName;
  int getLikesCount() => likesCount;
  bool getIsLiked() => isLiked;
  String getPostedBy() => postedBy;
}
