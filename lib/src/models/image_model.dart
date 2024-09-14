class ImageModel {
  int id;
  String title;
  String url;

  ImageModel(this.id, this.title, this.url);
  ImageModel.fromJson(Map<String, dynamic> parsedJSON)
      : id = parsedJSON["id"],
        title = parsedJSON["title"],
        url = "https://picsum.photos/600/300?random=${DateTime.now().millisecondsSinceEpoch}";
}
