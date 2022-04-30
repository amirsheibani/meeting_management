class OnlineMeetingSoftware {
  OnlineMeetingSoftware({
      this.id, 
      this.parentId, 
      this.applicationId, 
      this.applicationInternalId, 
      this.titlePersian, 
      this.descriptionPersian, 
      this.titleEnglish, 
      this.descriptionEnglish, 
      this.childLoaded, 
      this.code, 
      this.builtin,});

  OnlineMeetingSoftware.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parentId'];
    applicationId = json['applicationId'];
    applicationInternalId = json['applicationInternalId'];
    titlePersian = json['titlePersian'];
    descriptionPersian = json['descriptionPersian'];
    titleEnglish = json['titleEnglish'];
    descriptionEnglish = json['descriptionEnglish'];
    childLoaded = json['childLoaded'];
    code = json['code'];
    builtin = json['builtin'];
  }
  int? id;
  int? parentId;
  dynamic applicationId;
  int? applicationInternalId;
  String? titlePersian;
  String? descriptionPersian;
  dynamic titleEnglish;
  dynamic descriptionEnglish;
  bool? childLoaded;
  String? code;
  bool? builtin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parentId'] = parentId;
    map['applicationId'] = applicationId;
    map['applicationInternalId'] = applicationInternalId;
    map['titlePersian'] = titlePersian;
    map['descriptionPersian'] = descriptionPersian;
    map['titleEnglish'] = titleEnglish;
    map['descriptionEnglish'] = descriptionEnglish;
    map['childLoaded'] = childLoaded;
    map['code'] = code;
    map['builtin'] = builtin;
    return map;
  }

}