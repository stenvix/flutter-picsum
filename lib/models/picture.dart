class Picture{
  final String format;
  final int width;
  final int height;
  final String filename;
  final int id;
  final String author;
  final String authorUrl;
  final String postUrl;
  String imageUrl;

  Picture({this.format, this.width, this.height, this.filename, this.id, this.author, this.authorUrl, this.postUrl});

  factory Picture.fromJson(Map<String, dynamic> json){
    return Picture(
      format: json["format"],
      width: json["width"],
      height: json["height"],
      filename: json["filename"],
      id: json["id"],
      author: json["author"],
      authorUrl: json["author_url"],
      postUrl: json["post_url"]
    );
  }
}