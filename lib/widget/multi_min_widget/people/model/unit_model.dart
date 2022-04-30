class UnitModel {
  UnitModel({
      this.id, 
      this.customerId, 
      this.code, 
      this.name, 
      this.description, 
      this.creationDate, 
      this.email, 
      this.phone, 
      this.address, 
      this.personCount,});

  UnitModel.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customerId'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    creationDate = json['creationDate'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    personCount = json['personCount'];
  }
  int? id;
  String? customerId;
  String? code;
  String? name;
  String? description;
  String? creationDate;
  String? email;
  String? phone;
  String? address;
  int? personCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customerId'] = customerId;
    map['code'] = code;
    map['name'] = name;
    map['description'] = description;
    map['creationDate'] = creationDate;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['personCount'] = personCount;
    return map;
  }

}