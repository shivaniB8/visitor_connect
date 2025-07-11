import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/check_mobile_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';

class CheckMobileNumberBloc extends Cubit<UiState<CheckMobileResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  CheckMobileNumberBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future checkMobileNumber({
    required String mobileNo,
  }) {
    emit(Progress());
    return _addVisitorRepository
        .checkMobileNumber(mobileNo: mobileNo)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(CheckMobileResponse checkMobileResponse) async {
    emit(Success(checkMobileResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
