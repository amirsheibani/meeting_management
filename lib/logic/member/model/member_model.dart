
import 'member.dart';

class MemberModel{
  MemberModel({
      this.id, 
      this.groupId, 
      this.personId, 
      this.partyPersonId, 
      this.member, 
      this.position, 
      this.description,});

  MemberModel.fromJson(dynamic json) {
    id = json['id'];
    groupId = json['groupId'];
    personId = json['personId'];
    partyPersonId = json['partyPersonId'];
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    position = json['position'];
    description = json['description'];
  }
  int? id;
  int? groupId;
  dynamic personId;
  int? partyPersonId;
  Member? member;
  String? position;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['groupId'] = groupId;
    map['personId'] = personId;
    map['partyPersonId'] = partyPersonId;
    if (member != null) {
      map['member'] = member?.toJson();
    }
    map['position'] = position;
    map['description'] = description;
    return map;
  }

}