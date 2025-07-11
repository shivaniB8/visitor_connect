import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';
import '../shared_prefs.dart';

enum AuthenticationState {
  authenticated,
  changing,
  unauthenticated,
}

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final LoginRepository _loginRepository;

  AuthenticationBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(AuthenticationState.unauthenticated);

  void init() {
    if (_loginRepository.isUserLoggedIn()) {
      emit(AuthenticationState.authenticated);
    }
  }

  Future<void> logout() async {
    emit(AuthenticationState.changing);
    await SharedPrefs.clearUserData();
    emit(AuthenticationState.unauthenticated);
  }

  void loginSuccess() {
    emit(AuthenticationState.authenticated);
  }
}
