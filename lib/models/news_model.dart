class NewsModel {
  late String image;
  late String description;
  late String postedBy;

  NewsModel.init();

  NewsModel.createPost({
    required this.image,
    required this.description,
    required this.postedBy,
  });

  String getImage() => image;
  String getDescription() => description;
  void setDescription(String description) => description = description;
  String getPostedBy() => postedBy;
}
