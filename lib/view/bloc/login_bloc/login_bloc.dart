import 'package:bloc/bloc.dart';
import 'package:leenas_mushrooms/services/api_services.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  LoginBloc({required this.apiService}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
        emit(LoginLoading());
    try {
      final response = await apiService.loginUser({
        "username": event.username,
        "password": event.password,
      });

      if (response.message == "Login successful") {
        final token = response.token;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token.toString());
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(message: "Invalid credentials."));
      }
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
