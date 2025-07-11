import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/features/rentals/data/network/responses/driving_licence_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/api_services/add_visitor_api_services.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/add_foreigner_visitor_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/check_mobile_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class AddVisitorRepository {
  final AddVisitorApiServices _addVisitorApiServices;

  AddVisitorRepository({AddVisitorApiServices? addVisitorApiServices})
      : _addVisitorApiServices =
            addVisitorApiServices ?? AddVisitorApiServices();

  Future<AddForeignerVisitorResponse> addForeignerVisitorManually({
    required Map<String, dynamic> foreignerVisitor,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
    required XFile profilePhoto,
  }) {
    return _addVisitorApiServices.addForeignerVisitorManually(
        foreignerVisitor: foreignerVisitor,
        passportFirstPhoto: passportFirstPhoto,
        passportLastPhoto: passportLastPhoto,
        profilePhoto: profilePhoto,
        visaPhoto: visaPhoto);
  }

  Future<CheckMobileResponse> checkMobileNumber({
    required String mobileNo,
  }) {
    return _addVisitorApiServices.checkMobileNumber(
      mobileNo: mobileNo,
    );
  }

  Future<OtpGenerationResponse> requestOtp({
    String? mobileNo,
    String? aadharNo,
    int? update,
    int? id,
  }) {
    return _addVisitorApiServices.requestOtp(
      mobileNo: mobileNo,
      update: update,
      id: id,
      aadharNo: aadharNo,
    );
  }

  Future<OtpGenerationResponse> getAadharDetails({
    required String mobileNo,
    required String aadharNo,
    required int update,
    required int id,
    required String otp,
  }) {
    return _addVisitorApiServices.getAadharDetails(
      mobileNo: mobileNo,
      update: update,
      id: id,
      aadharNo: aadharNo,
      otp: otp,
    );
  }

  Future<KeyValueListResponse> getReasonToVisit() {
    return _addVisitorApiServices.getReasonToVisit();
  }

  Future<KeyValueListResponse> getBloodGrps() async {
    return _addVisitorApiServices.getBloodGrps();
  }

  Future<SuccessResponse> updateVisitorInfo({
    required Map<String, dynamic> indianVisitorInfo,
  }) {
    return _addVisitorApiServices.updateVisitorInfo(
      indianVisitorInfo: indianVisitorInfo,
    );
  }

  Future<SuccessResponse> visitorDocuments({
    XFile? aadharFront,
    XFile? aadharBack,
    required int visitorId,
  }) async {
    return _addVisitorApiServices.visitorDocuments(
      aadharFront: aadharFront,
      aadharBack: aadharBack,
      visitorId: visitorId,
    );
  }

  Future<SuccessResponse> drivingLicenceDocuments({
    XFile? licenceFront,
    XFile? licenceBack,
    required int visitorId,
  }) async {
    return _addVisitorApiServices.drivingLicenceDocuments(
      licenceFront: licenceFront,
      licenceBack: licenceBack,
      visitorId: visitorId,
    );
  }
}
