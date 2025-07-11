import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_response.dart';
import 'package:host_visitor_connect/features/qr/data/repos/qr_scanner_repository.dart';
import 'package:image_picker/image_picker.dart';

class FaceMatchBloc extends Cubit<UiState<SuccessResponse>> {
  final QrScannerRepository _qrScannerRepository;

  FaceMatchBloc({QrScannerRepository? qrScannerRepository})
      : _qrScannerRepository = qrScannerRepository ?? QrScannerRepository(),
        super(Default());

  Future faceMatch({
    required int visitorId,
    required String aadhaarPhoto,
    required XFile profilePhoto,
  }) {
    emit(Progress());
    return _qrScannerRepository
        .faceMatch(
          aadhaarPhoto: aadhaarPhoto,
          visitorId: visitorId,
          profilePhoto: profilePhoto,
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
