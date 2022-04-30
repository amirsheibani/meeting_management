class LocationModel {
  LocationModel({
      this.id, 
      this.name, 
      this.code, 
      this.cordinatorId, 
      this.description, 
      this.address, 
      this.latitude, 
      this.longitude,});

  LocationModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    cordinatorId = json['cordinatorId'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  int? id;
  String? name;
  String? code;
  String? cordinatorId;
  String? description;
  String? address;
  int? latitude;
  int? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['cordinatorId'] = cordinatorId;
    map['description'] = description;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}