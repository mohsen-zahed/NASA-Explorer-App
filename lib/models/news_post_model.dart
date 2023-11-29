class NewsPostModel {
  late List<String> _image;
  late String _text;
  late String _userName;
  late String _profileImage;
  late int _postedDateYear;
  late int _postedDateMonth;
  late int _postedDateDay;
  late int _likesNumber;
  late bool _isLiked;

  NewsPostModel.init();

  NewsPostModel.createPost({
    required List<String> image,
    required String text,
    required String userName,
    required String profileImage,
    required int postedDateYear,
    required int postedDateMonth,
    required int postedDateDay,
    required int likesNumber,
    required bool isLiked,
  }) {
    _image = image;
    _text = text;
    _userName = userName;
    _profileImage = profileImage;
    _postedDateYear = postedDateYear;
    _postedDateMonth = postedDateMonth;
    _postedDateDay = postedDateDay;
    _likesNumber = likesNumber;
    _isLiked = isLiked;
  }

  List<String> getImages() => _image;
  void setImages(List<String> image) => _image = image;
  String getText() => _text;
  void setText(String text) => _text = text;
  String getUserName() => _userName;
  String getProfileImage() => _profileImage;
  int getPostedDateYear() => _postedDateYear;
  int getPostedDateMonth() => _postedDateMonth;
  int getPostedDateDay() => _postedDateDay;
  int getLikesNumber() => _likesNumber;
  bool getIsLiked() => _isLiked;
  void setIsLiked(bool isLiked) => _isLiked = isLiked;
}
