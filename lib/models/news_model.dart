class NewsModel {
  late String image;
  late String text;
  late String userName;
  late String profileImage;
  late int postedDateYear;
  late int postedDateMonth;
  late int postedDateDay;
  late int likesNumber;
  late bool isLiked;

  NewsModel.init();

  NewsModel.createPost({
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

  NewsModel.fromJson(List<Map<String, dynamic>> json) {}

  String getImages() => image;
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
