import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/dashboard/data/repos/user_repository.dart';

class UserDetailsBloc extends Cubit<UiState<UserDetailsResponse>> {
  final UserRepository _userRepository;

  UserDetailsBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(Default());

  Future userDetails() {
    emit(Progress());
    return _userRepository.userDetails().then(_onSuccess).handleError(_onError);
  }

  _onSuccess(UserDetailsResponse userDetailsResponse) async {
    emit(Success(userDetailsResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
