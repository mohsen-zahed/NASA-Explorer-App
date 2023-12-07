class NewsPostModel {
  late List<String> image;
  late String text;
  late String userName;
  late String profileImage;
  late int postedDateYear;
  late int postedDateMonth;
  late int postedDateDay;
  late int likesNumber;
  late bool isLiked;

  NewsPostModel.init();

  NewsPostModel.createPost({
    required this.image,
    required this.text,
    required this.userName,
    required this.profileImage,
    required this.postedDateYear,
    required this.postedDateMonth,
    required this.postedDateDay,
    required this.likesNumber,
    required this.isLiked,
  });

  NewsPostModel.fromJson(List<Map<String, dynamic>> json) {}

  List<String> getImages() => image;
  void setImages(List<String> image) => image = image;
  String getText() => text;
  void setText(String text) => text = text;
  String getUserName() => userName;
  String getProfileImage() => profileImage;
  int getPostedDateYear() => postedDateYear;
  int getPostedDateMonth() => postedDateMonth;
  int getPostedDateDay() => postedDateDay;
  int getLikesNumber() => likesNumber;
  bool getIsLiked() => isLiked;
  void setIsLiked(bool isLiked) => isLiked = isLiked;
}
