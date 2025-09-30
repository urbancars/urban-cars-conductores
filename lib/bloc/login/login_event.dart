import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String documento;

  const LoginSubmitted({required this.documento});

  @override
  List<Object?> get props => [documento];
}

class Logout extends LoginEvent {}
