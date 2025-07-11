import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/qr/data/network/api_services/qr_scanner_api_service.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_response.dart';
import 'package:image_picker/image_picker.dart';

class QrScannerRepository {
  final QrScannerApiService _qrScannerApiService;

  QrScannerRepository({QrScannerApiService? qrScannerApiService})
      : _qrScannerApiService = qrScannerApiService ?? QrScannerApiService();

  Future<QrScannerResponse> getDataFromQr({
    required int visitorId,
    required String aadhar,
    int? allowToScan,
    required int businessType,
  }) async {
    return _qrScannerApiService.getDataFromQr(
      visitorId: visitorId,
      aadhar: aadhar,
      allowToScan: allowToScan,
      businessType: businessType,
    );
  }

  Future<SuccessResponse> faceMatch({
    required int visitorId,
    required String aadhaarPhoto,
    required XFile profilePhoto,
  }) async {
    return _qrScannerApiService.faceMatch(
      aadhaarPhoto: aadhaarPhoto,
      visitorId: visitorId,
      profilePhoto: profilePhoto,
    );
  }
}
