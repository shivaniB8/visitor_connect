import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/dashboard/data/repos/user_repository.dart';
import 'package:host_visitor_connect/features/profile/data/network/responses/update_profile_response.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileBloc extends Cubit<UiState<UpdateProfileResponse>> {
  final UserRepository _userRepository;

  UpdateProfileBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(Default());

  Future updateUserDetails({
    required Map<String, dynamic> userUpdatedData,
    XFile? profilePhoto,
  }) {
    emit(Progress());
    return _userRepository
        .updateUserDetails(
          userUpdatedData: userUpdatedData,
          profilePhoto: profilePhoto,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(UpdateProfileResponse updateProfileResponse) {
    emit(Success(updateProfileResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
