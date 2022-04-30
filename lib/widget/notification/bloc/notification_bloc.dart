
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/widget/notification/model/notification_data.dart';
import 'package:meeting_management/widget/notification/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  NotificationBloc(this._notificationRepository) : super(NotificationInitial()) {
    on<RetrieveNotificationEvent>((event, emit) async {
      try {
        final List<NotificationDataModel> _result = await _notificationRepository.getAll();
        emit(RetrieveNotificationState(_result));
      }catch (exception) {
        emit(NotificationErrorState(exception));
      }
    });
    on<AddNotificationEvent>((event, emit) async {
      try {
        await _notificationRepository.insert(event.props[0]!);
        emit(const AddNotificationState());
      }catch (exception) {
        emit(NotificationErrorState(exception));
      }
    });
    on<RemoveNotificationPopEvent>((event, emit) async {
      try {
        await _notificationRepository.remove(event.props[0]!);
        emit(const RemoveNotificationState());
      }catch (exception) {
        emit(NotificationErrorState(exception));
      }
    });
    on<UpdateNotificationEvent>((event, emit) async {
      try {
        await _notificationRepository.update(event.props[0]!);
        emit(const UpdateNotificationState());
      }catch (exception) {
        emit(NotificationErrorState(exception));
      }
    });
  }
}
