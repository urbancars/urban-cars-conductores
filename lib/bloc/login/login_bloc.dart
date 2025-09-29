import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final driver = await loginRepository.login(event.documento);
      emit(LoginSuccess(driver));
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      emit(LoginFailure(msg));
    }
  }
}
