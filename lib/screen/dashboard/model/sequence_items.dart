class SequenceItems{
  String? name;
  String? id;
  dynamic widget;

  SequenceItems({this.name, this.id, this.widget});

  SequenceItems.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    widget = json['widget'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['widget'] = widget;
    return map;
  }
}