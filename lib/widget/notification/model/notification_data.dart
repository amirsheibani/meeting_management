import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'notification_data.g.dart';

@HiveType(typeId: 0)
class NotificationDataModel extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? subTitle;
  @HiveField(3)
  bool? status;
  // Function? onTap;
  // Function? dismissTap;

  NotificationDataModel({this.id, Widget? icon, this.title, this.subTitle, Widget? dismissIcon,this.status
    // this.onTap, this.dismissTap
  })
      : assert(status != null);
  NotificationDataModel.fromJson(dynamic json){
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    status = json['status'];
  }
  Map toJson() => {
        'id': id,
        'title': title,
        'subTitle': subTitle,
        'status': status,
      };
}
