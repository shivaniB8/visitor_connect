import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';
import 'package:image_picker/image_picker.dart';

class VisitorDocumentBloc extends Cubit<UiState<SuccessResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  VisitorDocumentBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  // Future visitorDocuments({
  //   XFile? aadharFront,
  //   XFile? aadharBack,
  //   required int visitorId,
  // }) {
  //   emit(Progress());
  //   return _addVisitorRepository
  //       .visitorDocuments(
  //         aadharBack: aadharBack,
  //         aadharFront: aadharFront,
  //         visitorId: visitorId,
  //       )
  //       .then(_onSuccess)
  //       .handleError(_onError);
  // }

  Future drivingLicenceDocuments({
    XFile? licenceFront,
    XFile? licenceBack,
    required int visitorId,
  }) {
    emit(Progress());
    return _addVisitorRepository
        .drivingLicenceDocuments(
          licenceFront: licenceFront,
          licenceBack: licenceBack,
          visitorId: visitorId,
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
