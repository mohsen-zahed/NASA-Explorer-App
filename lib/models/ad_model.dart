class AdModel {
  late String adImageUrl;
  late String adTitle;
  late String adMessage;
  late String adDescription;
  late String adUrl;
  late int adId;
  late String postedBy;

  AdModel.init({
    required this.adImageUrl,
    required this.adTitle,
    required this.adMessage,
    required this.adDescription,
    required this.adUrl,
    required this.adId,
    required this.postedBy,
  });

  String getAdImageUrl() => adImageUrl;
  String getAdTitle() => adTitle;
  String getAdMessage() => adMessage;
  String getAdDescription() => adDescription;
  String getAdUrl() => adUrl;
  int getAdId() => adId;
  String getPostedBy() => postedBy;
}
