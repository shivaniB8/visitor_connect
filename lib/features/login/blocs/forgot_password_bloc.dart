import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';

class ForgotPasswordBloc extends Cubit<UiState<SuccessResponse>> {
  final LoginRepository _loginRepository;

  ForgotPasswordBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(Default());

  void forgotPassword({
    required String phoneNo,
  }) {
    emit(Progress());
    _loginRepository
        .forgotPassword(
          phoneNo: phoneNo,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(SuccessResponse successResponse) {
    emit(Success(successResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
