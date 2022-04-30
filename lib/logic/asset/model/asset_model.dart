class AssetModel {
  AssetModel({
      this.id, 
      this.customerId, 
      this.ownerId, 
      this.name, 
      this.code, 
      this.description,});

  AssetModel.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customerId'];
    ownerId = json['ownerId'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
  }
  int? id;
  int? customerId;
  int? ownerId;
  String? name;
  String? code;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customerId'] = customerId;
    map['ownerId'] = ownerId;
    map['name'] = name;
    map['code'] = code;
    map['description'] = description;
    return map;
  }

}