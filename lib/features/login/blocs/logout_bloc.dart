import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';

class LogoutBloc extends Cubit<UiState<SuccessResponse>> {
  final LoginRepository _loginRepository;

  LogoutBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(Default());

  void logout() {
    emit(Progress());
    _loginRepository.logout().then(_onSuccess).handleError(_onError);
  }

  _onSuccess(SuccessResponse successResponse) async {
    emit(Success(successResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
