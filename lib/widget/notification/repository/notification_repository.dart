
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meeting_management/widget/notification/model/notification_data.dart';

const cartBox = 'notificationBox';
class NotificationRepository{
  Future insert(NotificationDataModel notificationDataModel) async {
    try{
      Box<NotificationDataModel> notificationBox = await Hive.openBox<NotificationDataModel>(cartBox);
      List<NotificationDataModel> result = notificationBox.values.toList();
      if(result.where((element) => element.title == notificationDataModel.title).toList().isEmpty){
        notificationDataModel.id = await notificationBox.add(notificationDataModel);
        await notificationBox.put(notificationDataModel.id!,notificationDataModel);
      }
      return;
    }catch (e){
      rethrow;
    }
  }
  Future update(NotificationDataModel notificationDataModel) async {
    try{
      Box<NotificationDataModel> notificationBox = await Hive.openBox<NotificationDataModel>(cartBox);
      await notificationBox.put(notificationDataModel.id!, notificationDataModel);
      return;
    }catch (e){
      rethrow;
    }
  }
  Future remove(NotificationDataModel notificationDataModel) async {
    try{
      Box<NotificationDataModel> notificationBox = await Hive.openBox<NotificationDataModel>(cartBox);
      notificationBox.delete(notificationDataModel.id!);
      return;
    }catch (e){
      rethrow;
    }
  }
  Future removeLast() async {
    try{
      Box<NotificationDataModel> notificationBox = await Hive.openBox<NotificationDataModel>(cartBox);
      notificationBox.deleteAt(notificationBox.values.length - 1);
      return;
    }catch (e){
      rethrow;
    }
  }
  Future<List<NotificationDataModel>> getAll() async {
    try{
      Box<NotificationDataModel> notificationBox = await Hive.openBox<NotificationDataModel>(cartBox);
      List<NotificationDataModel> result = notificationBox.values.toList();
      return result;
    }catch (e){
      rethrow;
    }
  }
}