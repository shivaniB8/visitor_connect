import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/visitors/history/data/network/responses/visitor_room_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/api_services/visitors_api_service.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/check_out_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/outgoing_call_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/virtual_number_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/visitor_details_response.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:image_picker/image_picker.dart';

class VisitorRepository {
  final VisitorApiService _visitorApiService;

  VisitorRepository({VisitorApiService? visitorApiService})
      : _visitorApiService = visitorApiService ?? VisitorApiService();

  Future<PageResponse<VisitorDetailsResponse>> getVisitorListing({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filterModel,
  }) {
    return _visitorApiService.visitorListing(
      pageNo: pageNo,
      searchTerm: searchTerm,
      filterModel: filterModel,
    );
  }

  Future<CheckOutResponse> visitorCheckout({
    required int visitorId,
    String? checkOutDate,
    String? checkOutTime,
  }) {
    return _visitorApiService.visitorCheckout(
        visitorId: visitorId, checkOutDate: checkOutDate, checkOutTime: checkOutTime);
  }

  Future<KeyValueListResponse> getCountryList() {
    return _visitorApiService.getCountryList();
  }

  Future<SuccessResponse> updateVisitorsDetails({
    required Map<String, dynamic> visitorsUpdatedData,
    XFile? profilePhoto,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
  }) async {
    return _visitorApiService.updateVisitorsDetails(
        visitorsUpdatedData: visitorsUpdatedData,
        profilePhoto: profilePhoto,
        passportFirstPhoto: passportFirstPhoto,
        passportLastPhoto: passportLastPhoto,
        visaPhoto: visaPhoto);
  }

  Future<VirtualNumberResponse> getVirtualNumebers() {
    return _visitorApiService.getVirtualNumbers();
  }

  Future<OutgoingCallResponse> outgoingCall({
    required int visitorId,
    required int settingId,
  }) {
    return _visitorApiService.outgoingCall(
      visitorId: visitorId,
      settingId: settingId,
    );
  }

  Future<PageResponse<VisitorRoomResponse>> visitorsGrouping({
    required int pageNo,
    String? searchTerm,
    FiltersModel? filterModel,
    int? orderBy,
  }) {
    return _visitorApiService.visitorsGrouping(
      pageNo: pageNo,
      searchTerm: searchTerm,
      filterModel: filterModel,
      orderBy: orderBy,
    );
  }
}
