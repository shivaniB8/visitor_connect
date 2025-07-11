import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/dashboard/data/repos/user_repository.dart';

class DeleteAccountBloc extends Cubit<UiState<SuccessResponse>> {
  final UserRepository _userRepository;

  DeleteAccountBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(Default());

  Future deleteAccount() {
    emit(Progress());
    return _userRepository
        .deleteAccount()
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(SuccessResponse successResponse) async {
    emit(Success(successResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
