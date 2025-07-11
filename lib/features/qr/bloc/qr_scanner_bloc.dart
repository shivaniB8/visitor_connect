import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_response.dart';
import 'package:host_visitor_connect/features/qr/data/repos/qr_scanner_repository.dart';

class QrScannerBloc extends Cubit<UiState<QrScannerResponse>> {
  final QrScannerRepository _qrScannerRepository;

  QrScannerBloc({QrScannerRepository? qrScannerRepository})
      : _qrScannerRepository = qrScannerRepository ?? QrScannerRepository(),
        super(Default());

  Future getQrScannerData({
    required int visitorId,
    required String aadhar,
    int? allowToScan,
    required int businessType,
  }) {
    emit(Progress());
    return _qrScannerRepository
        .getDataFromQr(
          visitorId: visitorId,
          aadhar: aadhar,
          allowToScan: allowToScan,
          businessType: businessType,
        )
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(QrScannerResponse qrScannerResponse) {
    emit(Success(qrScannerResponse));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
