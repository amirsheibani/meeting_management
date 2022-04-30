class PeopleModel {
  PeopleModel({
    this.id,
      this.firstName, 
      this.lastName, 
      this.unitId, 
      this.code, 
      this.description, 
      this.email, 
      this.phone, 
      this.cellPhone, 
      this.address,});

  PeopleModel.fromJson(dynamic json) {
    id =json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    unitId = json['unitId'];
    code = json['code'];
    description = json['description'];
    email = json['email'];
    phone = json['phone'];
    cellPhone = json['cellPhone'];
    address = json['address'];
  }
  int? id;
  String? firstName;
  String? lastName;
  int? unitId;
  String? code;
  String? description;
  String? email;
  String? phone;
  String? cellPhone;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['unitId'] = unitId;
    map['code'] = code;
    map['description'] = description;
    map['email'] = email;
    map['phone'] = phone;
    map['cellPhone'] = cellPhone;
    map['address'] = address;
    return map;
  }

}