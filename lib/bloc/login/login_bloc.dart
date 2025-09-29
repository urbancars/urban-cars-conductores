import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import '../../data/repositories/login_repository.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial());

  Future<void> login(String documento) async {
    emit(LoginLoading());
    try {
      final driver = await repository.login(documento);
      emit(LoginSuccess(driver));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}