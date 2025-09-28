abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String documento;
  final String? driverName;
  final String driverId;
  LoginSuccess(this.documento, {this.driverName, required this.driverId});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}