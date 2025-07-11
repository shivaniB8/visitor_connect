import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';

import 'package:host_visitor_connect/features/report/report_list/data/repos/report_visitor_repository.dart';
import 'package:image_picker/image_picker.dart';

class ReportVisitorBloc extends Cubit<UiState<SuccessResponse>> {
  final ReportVisitorRepository _reportVisitorRepository;

  ReportVisitorBloc({ReportVisitorRepository? addVisitorRepository})
      : _reportVisitorRepository =
            addVisitorRepository ?? ReportVisitorRepository(),
        super(Default());

  Future reportVisitor({
    required Map<String, dynamic> reportVisitorMap,
    XFile? reportPhoto,
  }) {
    emit(Progress());
    return _reportVisitorRepository
        .reportVisitor(
          reportVisitorMap: reportVisitorMap,
          reportPhoto: reportPhoto,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(SuccessResponse successResponse) async {
    emit(Success(successResponse));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
