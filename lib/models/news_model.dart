class NewsModel {
  late String image;
  late String description;

  NewsModel.init();

  NewsModel.createPost({
    required this.image,
    required this.description,
  });

  String getImage() => image;
  String getDescription() => description;
  void setDescription(String description) => description = description;
}
