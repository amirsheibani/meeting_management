import 'dart:math';

import 'invitees_model.dart';

class MeetingModel {
  MeetingModel({
      this.id, 
      this.parentId, 
      this.customerId, 
      this.code, 
      this.title, 
      this.description, 
      this.lead, 
      this.startDate, 
      this.endDate, 
      this.approximateDuration, 
      this.locationId, 
      this.hostId, 
      this.managerId, 
      this.agenda, 
      this.agendaAttachemntId, 
      this.aproval, 
      this.aprovalAttachemntId, 
      this.typeId,
      this.priority, 
      this.onlineMeetingSoftware, 
      this.onlineUrl, 
      this.publicUserName, 
      this.publicPassword, 
      this.status, 
      this.creationDate, 
      this.creatorPersonId,
    this.invitees,
    this.assets,});

  MeetingModel.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parentId'];
    customerId = json['customerId'];
    code = json['code'];
    title = json['title'];
    description = json['description'];
    lead = json['lead'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approximateDuration = json['approximateDuration'];
    locationId = json['locationId'];
    hostId = json['hostId'];
    managerId = json['managerId'];
    agenda = json['agenda'];
    agendaAttachemntId = json['agendaAttachemntId'];
    aproval = json['aproval'];
    aprovalAttachemntId = json['aprovalAttachemntId'];
    typeId = json['typeId'];
    priority = json['priority'];
    onlineMeetingSoftware = json['onlineMeetingSoftware'];
    onlineUrl = json['onlineUrl'];
    publicUserName = json['publicUserName'];
    publicPassword = json['publicPassword'];
    status = json['status'];
    creationDate = json['creationDate'];
    creatorPersonId = json['creatorPersonId'];
    if (json['invitees'] != null) {
      invitees = [];
      json['invitees'].forEach((v) {
        invitees?.add(InviteesModel.fromJson(v));
      });
    }
    assets = json['assets'] != null ? json['assets'].cast<int>() : [];
  }
  int? id;
  dynamic parentId;
  int? customerId;
  String? code;
  String? title;
  String? description;
  dynamic lead;
  String? startDate;
  dynamic endDate;
  int? approximateDuration;
  dynamic locationId;
  dynamic hostId;
  dynamic managerId;
  dynamic agenda;
  dynamic agendaAttachemntId;
  dynamic aproval;
  dynamic aprovalAttachemntId;
  int? typeId;
  int? priority;
  dynamic onlineMeetingSoftware;
  String? onlineUrl;
  String? publicUserName;
  dynamic publicPassword;
  int? status;
  String? creationDate;
  int? creatorPersonId;
  List<InviteesModel>? invitees;
  List<int>? assets;


  Map<String, dynamic> toJsonForAdd() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['code'] = code;
    map['description'] = description;
    map['typeId'] = typeId;
    map['priority'] = priority;
    map['startDate'] = startDate;
    map['approximateDuration'] = approximateDuration;
    map['endDate'] = endDate;
    map['locationId'] = locationId;
    map['hostId'] = hostId;
    map['managerId'] = managerId;
    map['MeetingAgenda'] = agenda;
    map['MeetingAproval'] =  aproval;
    map['onlineMeetingSoftwareId'] = onlineMeetingSoftware;
    map['onlineUrl'] = onlineUrl;
    map['publicUserName'] = publicUserName;
    if (invitees != null) {
      map['invitees'] = invitees?.map((v) => v.toJson()).toList();
    }
    map['assets'] = assets;
    return map;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parentId'] = parentId;
    map['customerId'] = customerId;
    map['code'] = code;
    map['title'] = title;
    map['description'] = description;
    map['lead'] = lead;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['approximateDuration'] = approximateDuration;
    map['locationId'] = locationId;
    map['hostId'] = hostId;
    map['managerId'] = managerId;
    map['agenda'] = agenda;
    map['agendaAttachemntId'] = agendaAttachemntId;
    map['aproval'] = aproval;
    map['aprovalAttachemntId'] = aprovalAttachemntId;
    map['typeId'] = typeId;
    map['priority'] = priority;
    map['onlineMeetingSoftware'] = onlineMeetingSoftware;
    map['onlineUrl'] = onlineUrl;
    map['publicUserName'] = publicUserName;
    map['publicPassword'] = publicPassword;
    map['status'] = status;
    map['creationDate'] = creationDate;
    map['creatorPersonId'] = creatorPersonId;
    if (invitees != null) {
      map['invitees'] = invitees?.map((v) => v.toJson()).toList();
    }
    map['assets'] = assets;
    return map;
  }

}