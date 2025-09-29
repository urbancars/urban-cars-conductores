import 'package:equatable/equatable.dart';

class Driver {
  final String id;
  final String name;
  final String documento;

  Driver({required this.id, required this.name, required this.documento});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['conductor_id'].toString(),
      name: json['conductor'] ?? '',
      documento: json['documento'] ?? '',
    );
  }
}

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Driver driver;
  LoginSuccess(this.driver);

  @override
  List<Object?> get props => [driver];
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}