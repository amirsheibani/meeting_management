class MeetingHistory {
  MeetingHistory({
      this.id, 
      this.meetingId, 
      this.performerPerson, 
      this.date, 
      this.status, 
      this.description,});

  MeetingHistory.fromJson(dynamic json) {
    id = json['id'];
    meetingId = json['meetingId'];
    performerPerson = json['performerPerson'];
    date = json['date'];
    status = json['status'];
    description = json['description'];
  }
  int? id;
  int? meetingId;
  int? performerPerson;
  String? date;
  int? status;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['meetingId'] = meetingId;
    map['performerPerson'] = performerPerson;
    map['date'] = date;
    map['status'] = status;
    map['description'] = description;
    return map;
  }

}