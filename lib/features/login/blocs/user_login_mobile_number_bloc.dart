import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_branch_response.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';

class UserLoginMobileNumberBloc extends Cubit<UiState<LoginBranchResponse>> {
  final LoginRepository _loginRepository;

  UserLoginMobileNumberBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(Default());

  void loginMobileNumber({
    required String phoneNo,
  }) {
    emit(Progress());
    _loginRepository
        .loginMobileNumber(
          phoneNo: phoneNo,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(LoginBranchResponse loginBranchResponse) async {
    emit(Success(loginBranchResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
