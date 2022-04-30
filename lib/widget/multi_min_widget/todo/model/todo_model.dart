class TodoModel {
  TodoModel({
      this.id, 
      this.title, 
      this.description,
      this.creationDate,
      this.priority, 
      this.type,
      this.rank,
      this.done,
  });

  TodoModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    creationDate = json['creationDate'];
    priority = json['priority'];
    type = json['type'];
    rank = json['rank'];
    done = json['done'];
  }
  int? id;
  String? title;
  String? description;
  String? creationDate;
  int? priority;
  int? type;
  bool? done;

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
    map['done'] = done ?? false;
    return map;
  }

}