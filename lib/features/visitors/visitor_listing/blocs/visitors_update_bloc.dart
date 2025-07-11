import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/api_services/visitors_api_service.dart';
import 'package:image_picker/image_picker.dart';

class UpdateVisitorsBloc extends Cubit<UiState<SuccessResponse>> {
  final VisitorApiService _visitorApiService;

  UpdateVisitorsBloc({VisitorApiService? visitorApiService})
      : _visitorApiService = visitorApiService ?? VisitorApiService(),
        super(Default());

  Future updateVisitorsDetails({
    required Map<String, dynamic> visitorsUpdatedData,
    XFile? profilePhoto,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
  }) {
    emit(Progress());
    return _visitorApiService
        .updateVisitorsDetails(
            visitorsUpdatedData: visitorsUpdatedData,
            profilePhoto: profilePhoto,
            passportFirstPhoto: passportFirstPhoto,
            passportLastPhoto: passportLastPhoto,
            visaPhoto: visaPhoto)
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
