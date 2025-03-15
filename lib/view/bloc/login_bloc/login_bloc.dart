import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DataVerseRepository repo;
  LoginBloc({required this.repo}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutEvent>(_onLogout);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await repo.addLoginUser(credentials: {
        "username": event.username,
        "password": event.password,
      });
     
      if (response.status == "success" && response.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.token!);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: "Invalid credentials"));
      }
    } catch (e) {
      emit(LoginFailure(message: "Login failed: ${e.toString()}"));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    emit(LoginSuccess());
  }
}
