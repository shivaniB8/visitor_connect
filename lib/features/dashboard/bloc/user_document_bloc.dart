import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/dashboard/data/repos/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class UserDocumentBloc extends Cubit<UiState<SuccessResponse>> {
  final UserRepository _userRepository;

  UserDocumentBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(Default());

  Future userDocuments({
    XFile? aadharFront,
    XFile? aadharBack,
  }) {
    emit(Progress());
    return _userRepository
        .userDocuments(
          aadharBack: aadharBack,
          aadharFront: aadharFront,
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
