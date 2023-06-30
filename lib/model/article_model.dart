class ArticleModel {
  String body;
  String date;
  String image;
  String title;

  ArticleModel({
    required this.body,
    required this.date,
    required this.image,
    required this.title,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      body: json["body"],
      date: json["date"],
      image: json["image"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "body": body,
        "date": date,
        "image": image,
        "title": title,
      };
}
