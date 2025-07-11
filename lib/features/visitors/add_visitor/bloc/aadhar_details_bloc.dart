import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';

class AadharDetailsBloc extends Cubit<UiState<OtpGenerationResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  AadharDetailsBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future getAadharDetails({
    required String mobileNo,
    required String aadharNo,
    required int update,
    required int id,
    required String otp,
  }) {
    emit(Progress());
    return _addVisitorRepository
        .getAadharDetails(
          mobileNo: mobileNo,
          aadharNo: aadharNo,
          update: update,
          id: id,
          otp: otp,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(OtpGenerationResponse otpGenerationResponse) async {
    emit(Success(otpGenerationResponse));
  }

  clearState() {
    emit(Default());
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
