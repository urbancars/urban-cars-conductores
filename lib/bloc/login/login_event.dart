abstract class LoginEvent {}

class LoadSavedDocument extends LoginEvent {}

class SubmitLogin extends LoginEvent {
  final String documento;
  SubmitLogin(this.documento);
}