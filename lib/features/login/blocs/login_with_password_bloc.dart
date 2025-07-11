import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_response.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';

class LoginWithPasswordBloc extends Cubit<UiState<LoginResponse>> {
  final LoginRepository _loginRepository;

  LoginWithPasswordBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(Default());

  loginWithPassword({
    required String phoneNo,
    required String password,
    required int branchId,
    int? reLoginId,
    int? hostId,
  }) {
    emit(Progress());
    _loginRepository
        .loginWithPassword(
            hostId: hostId,
            phoneNo: phoneNo,
            password: password,
            branchId: branchId,
            reLoginId: reLoginId ?? 0)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(LoginResponse loginResponse) async {
    await Future.wait(
      [
        SharedPrefs.setString(
          apiAuthenticationToken,
          loginResponse.data?.userReference ?? '',
        ),
        if (loginResponse.data?.clientInfo?.clientId != null)
          SharedPrefs.setInt(
            keyClientId,
            loginResponse.data?.clientInfo?.clientId ?? 0,
          ),
        // SharedPrefs.setString(
        //   keyBucketName,
        //   loginResponse.data?.clientInfo?.bucketName ?? '',
        // ),
        SharedPrefs.setString(
          keyClientLogo,
          loginResponse.data?.clientInfo?.logo ?? '',
        ),
        // SharedPrefs.setString(
        //   keyMasterBucket,
        //   loginResponse.data?.masterBucket ?? '',
        // ),
      ],
    );
    emit(Success(loginResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
