class Member {
  Member({
      this.id, 
      this.type, 
      this.code, 
      this.title, 
      this.firstName, 
      this.lastName, 
      this.position, 
      this.description, 
      this.email, 
      this.role, 
      this.sexType, 
      this.mobileNumber, 
      this.imageId,});

  Member.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    position = json['position'];
    description = json['description'];
    email = json['email'];
    role = json['role'];
    sexType = json['sexType'];
    mobileNumber = json['mobileNumber'];
    imageId = json['imageId'];
  }
  int? id;
  int? type;
  String? code;
  dynamic title;
  String? firstName;
  String? lastName;
  dynamic position;
  String? description;
  String? email;
  int? role;
  bool? sexType;
  String? mobileNumber;
  dynamic imageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['code'] = code;
    map['title'] = title;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['position'] = position;
    map['description'] = description;
    map['email'] = email;
    map['role'] = role;
    map['sexType'] = sexType;
    map['mobileNumber'] = mobileNumber;
    map['imageId'] = imageId;
    return map;
  }

}