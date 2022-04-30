class PeopleGroupModel {
  PeopleGroupModel({
      this.id, 
      this.customerId, 
      this.typeId, 
      this.creatorPersonId, 
      this.name, 
      this.code, 
      this.description, 
      this.creationDate,});

  PeopleGroupModel.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customerId'];
    typeId = json['typeId'];
    creatorPersonId = json['creatorPersonId'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    creationDate = json['creationDate'];
  }
  int? id;
  int? customerId;
  int? typeId;
  int? creatorPersonId;
  String? name;
  String? code;
  String? description;
  String? creationDate;

  Map<String, dynamic> toAddJson() {
    final map = <String, dynamic>{};
    map['typeId'] = typeId;
    map['name'] = name;
    map['code'] = code;
    map['description'] = description;
    return map;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['customerId'] = customerId;
    map['typeId'] = typeId;
    // map['creatorPersonId'] = creatorPersonId;
    map['name'] = name;
    map['code'] = code;
    map['description'] = description;
    // map['creationDate'] = creationDate;
    return map;
  }

}