import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'login_repo.dart'; // Import your LoginRepository

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(LoginRepository loginRepository)
      : _loginRepository = loginRepository,
        super(LoginInitial()) {
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoginWithEmailAndPassword(
      LoginWithEmailAndPassword event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _loginRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _loginRepository.signInWithGoogle();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<LoginState> emit) async {
    await _loginRepository.signOut();
    emit(LoginInitial());
  }
}
