import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/screen/authenticate/model/authenticate_data.dart';
import 'package:meeting_management/screen/authenticate/repository/authenticate_repository.dart';

import 'authenticate_event.dart';
import 'authenticate_state.dart';


class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final AuthenticateApiRepository authenticateApiRepository;

  AuthenticateBloc(this.authenticateApiRepository) : super(const AuthenticateInitial()) {
    on<LogInEvent>((event, emit) async {
      try {
        String? _fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: 'BI2UqDNIc0L6-PzelBo3z2TejgzRZprKaj2I3asRXo-oZxJoj2F6KQDdbPBCc6-ZcaAUmeDrJQZVUi25LJZQG6w');
        AuthenticateData authenticateData = await authenticateApiRepository.login(username: event.props[0],password: event.props[1],fcmToken: _fcmToken);
        emit(AuthenticateSuccess(authenticateData));
      } catch (exception) {
        emit(AuthenticateFailed(exception));
      }
    });

    on<LogOffEvent>((event, emit) async {
      try {
        await authenticateApiRepository.logOff();
        emit(const LogOffSuccess());
      } catch (exception) {
        emit(AuthenticateFailed(exception));
      }
    });
  }
}
