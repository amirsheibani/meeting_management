part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}
class RetrieveNotificationEvent extends NotificationEvent{
  const RetrieveNotificationEvent();

  @override
  List<Object?> get props => [];
}
class AddNotificationEvent extends NotificationEvent{
  final NotificationDataModel notificationDataModel;
  const AddNotificationEvent(this.notificationDataModel);

  @override
  List<NotificationDataModel?> get props => [notificationDataModel];
}
class RemoveNotificationPopEvent extends NotificationEvent{
  final NotificationDataModel notificationDataModel;
  const RemoveNotificationPopEvent(this.notificationDataModel);

  @override
  List<NotificationDataModel?> get props => [notificationDataModel];
}
class UpdateNotificationEvent extends NotificationEvent{
  final NotificationDataModel notificationDataModel;
  const UpdateNotificationEvent(this.notificationDataModel);

  @override
  List<NotificationDataModel?> get props => [notificationDataModel];
}