import 'dart:convert';

class CoverModel {
  final int id;
  final int height;
  final int width;
  final String imageId;
  final String url;

  CoverModel(this.id, this.height, this.width, this.imageId, this.url);

  // ignore: non_constant_identifier_names
  CoverModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        height = json["height"],
        width = json["width"],
        imageId = json["image_id"],
        url = json["url"];
}
