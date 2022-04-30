class OrganizationUnit {
  OrganizationUnit({
      this.id, 
      this.parentId, 
      this.code, 
      this.namePersian, 
      this.nameEnglish, 
      this.descriptionPersian, 
      this.descriptionEnglish, 
      this.childCount, 
      this.personCount,});

  OrganizationUnit.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parentId'];
    code = json['code'];
    namePersian = json['namePersian'];
    nameEnglish = json['nameEnglish'];
    descriptionPersian = json['descriptionPersian'];
    descriptionEnglish = json['descriptionEnglish'];
    childCount = json['childCount'];
    personCount = json['personCount'];
  }
  int? id;
  dynamic parentId;
  dynamic code;
  String? namePersian;
  String? nameEnglish;
  dynamic descriptionPersian;
  dynamic descriptionEnglish;
  int? childCount;
  int? personCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parentId'] = parentId;
    map['code'] = code;
    map['namePersian'] = namePersian;
    map['nameEnglish'] = nameEnglish;
    map['descriptionPersian'] = descriptionPersian;
    map['descriptionEnglish'] = descriptionEnglish;
    map['childCount'] = childCount;
    map['personCount'] = personCount;
    return map;
  }

  Map<String, dynamic> toUpdateJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['namePersian'] = namePersian;
    map['nameEnglish'] = nameEnglish;
    map['descriptionPersian'] = descriptionPersian;
    map['descriptionEnglish'] = descriptionEnglish;
    return map;
  }

  Map<String, dynamic> toNewJson() {
    final map = <String, dynamic>{};
    map['parentId'] = parentId ?? 0;
    map['code'] = code ?? '';
    map['namePersian'] = namePersian ?? '';
    map['nameEnglish'] = nameEnglish ?? '';
    map['descriptionPersian'] = descriptionPersian ?? '';
    map['descriptionEnglish'] = descriptionEnglish ?? '';
    return map;
  }

}