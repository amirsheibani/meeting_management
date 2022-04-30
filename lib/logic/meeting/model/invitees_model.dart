import 'member.dart';

class InviteesModel {
  InviteesModel({
      this.id, 
      this.meetingId, 
      this.personId, 
      this.partyPersonId, 
      this.member, 
      this.attendanceResult, 
      this.announceType, 
      this.announceDate, 
      this.delayAttendanceMinute, 
      this.privateUserName, 
      this.privatePassword, 
      this.description,});

  InviteesModel.fromJson(dynamic json) {
    id = json['id'];
    meetingId = json['meetingId'];
    personId = json['personId'];
    partyPersonId = json['partyPersonId'];
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    attendanceResult = json['attendanceResult'];
    announceType = json['announceType'];
    announceDate = json['announceDate'];
    delayAttendanceMinute = json['delayAttendanceMinute'];
    privateUserName = json['privateUserName'];
    privatePassword = json['privatePassword'];
    description = json['description'];
  }
  int? id;
  int? meetingId;
  int? personId;
  dynamic partyPersonId;
  Member? member;
  int? attendanceResult;
  int? announceType;
  String? announceDate;
  dynamic delayAttendanceMinute;
  dynamic privateUserName;
  dynamic privatePassword;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['id'] = id;
    // map['meetingId'] = meetingId;
    map['personId'] = personId;
    map['partyPersonId'] = partyPersonId;
    // if (member != null) {
    //   map['member'] = member?.toJson();
    // }
    // map['attendanceResult'] = attendanceResult;
    // map['announceType'] = announceType;
    // map['announceDate'] = announceDate;
    // map['delayAttendanceMinute'] = delayAttendanceMinute;
    // map['privateUserName'] = privateUserName;
    // map['privatePassword'] = privatePassword;
    // map['description'] = description;
    return map;
  }

}