class NoteModel {
  NoteModel({
      this.id, 
      this.title, 
      this.description,
      this.creationDate,
      this.priority, 
      this.type,
      this.rank,});

  NoteModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    creationDate = json['creationDate'];
    priority = json['priority'];
    type = json['type'];
    rank = json['rank'];
  }
  int? id;
  String? title;
  String? description;
  String? creationDate;
  int? priority;
  int? type;

  dynamic rank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['creationDate'] = creationDate!.replaceAll(' ', 'T');
    map['priority'] = priority ?? 0;
    map['type'] = type ?? 0;
    map['rank'] = rank ?? 0;
    return map;
  }

}