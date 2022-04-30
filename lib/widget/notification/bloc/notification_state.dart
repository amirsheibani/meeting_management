part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class AddNotificationState extends NotificationState{
  const AddNotificationState();

  @override
  List<Object?> get props => [];
}
class UpdateNotificationState extends NotificationState{
  const UpdateNotificationState();

  @override
  List<Object?> get props => [];
}
class RemoveNotificationState extends NotificationState{
  const RemoveNotificationState();

  @override
  List<Object?> get props => [];
}
class RetrieveNotificationState extends NotificationState{
  final List<NotificationDataModel> notificationItems;
  const RetrieveNotificationState(this.notificationItems);

  @override
  List<List<NotificationDataModel>> get props => [notificationItems];
}

class NotificationErrorState extends NotificationState {
  final dynamic error;
  const NotificationErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}