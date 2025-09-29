import 'package:equatable/equatable.dart';
import '../../data/models/driver.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final Driver driver;
  const LoginSuccess(this.driver);

  @override
  List<Object?> get props => [driver];
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}