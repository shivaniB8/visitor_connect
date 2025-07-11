import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';

class RequestOtpBloc extends Cubit<UiState<OtpGenerationResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  RequestOtpBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future requestOtp({
    String? mobileNo,
    String? aadharNo,
    int? update,
    int? id,
    bool? isUpdateDetails = false,
  }) {
    if (isUpdateDetails ?? true) {
      emit(Progress1());
    } else {
      emit(Progress());
    }
    return _addVisitorRepository
        .requestOtp(
          mobileNo: mobileNo,
          aadharNo: aadharNo,
          update: update,
          id: id,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(OtpGenerationResponse otpGenerationResponse) async {
    emit(Success(otpGenerationResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
