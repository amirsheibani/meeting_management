import 'package:equatable/equatable.dart';

 abstract class AuthenticateEvent extends Equatable{
  const AuthenticateEvent();
}

class LogInEvent extends AuthenticateEvent{
   final String username;
   final String password;

  const LogInEvent(this.username, this.password);

  @override
  List<String> get props => [username,password];

}

class LogOffEvent extends AuthenticateEvent{
  const LogOffEvent();

  @override
  List<Object?> get props => [];

}