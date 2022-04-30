class ImageModel {
  ImageModel({
    this.filename,
    this.contenttype,
    this.stringContent,
    this.isRemove,
  });

  ImageModel.fromJson(dynamic json) {
    filename = json['filename'];
    contenttype = json['contenttype'];
    stringContent = json['StringContent'];
  }
  String? filename;
  String? contenttype;
  String? stringContent;
  bool? isRemove;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filename'] = filename;
    map['contenttype'] = 'image/$contenttype';
    map['StringContent'] = stringContent;
    return map;
  }
}