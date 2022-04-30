import 'package:equatable/equatable.dart';
import 'package:meeting_management/screen/authenticate/model/authenticate_data.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();
}

class AuthenticateInitial extends AuthenticateState {
  const AuthenticateInitial();

  @override
  List<Object?> get props => [];
}

class AuthenticateSuccess extends AuthenticateState {
  const AuthenticateSuccess(this.authenticateData);

  final AuthenticateData authenticateData;

  @override
  List<AuthenticateData?> get props => [authenticateData];
}

class LogOffSuccess extends AuthenticateState {
  const LogOffSuccess();

  @override
  List<Object?> get props => [];
}

class AuthenticateFailed extends AuthenticateState {
  final dynamic error;

  const AuthenticateFailed(this.error);

  @override
  List<dynamic?> get props => [error];
}
