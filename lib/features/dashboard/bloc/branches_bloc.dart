import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/dashboard/data/repos/user_repository.dart';

class BranchesBloc extends Cubit<UiState<KeyValueListResponse>> {
  final UserRepository _userRepository;

  BranchesBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(Default());

  Future getBranches() {
    emit(Progress());
    return _userRepository.getBranches().then(_onSuccess).handleError(_onError);
  }

  _onSuccess(KeyValueListResponse keyValueListResponse) async {
    emit(Success(keyValueListResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
