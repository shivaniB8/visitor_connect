import 'package:host_visitor_connect/common/data/network/responses/key_value_list_response.dart';
import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/api_services/user_api_service.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/profile/data/network/responses/update_profile_response.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final UserApiService _userApiService;

  UserRepository({UserApiService? userApiService})
      : _userApiService = userApiService ?? UserApiService();

  Future<UserDetailsResponse> userDetails() async {
    return _userApiService.userDetails();
  }

  Future<SuccessResponse> resetPassword({
    required String newPassword,
    required String oldPassword,
    required String confirmPassword,
  }) async {
    return _userApiService.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      oldPassword: oldPassword,
    );
  }

  Future<KeyValueListResponse> getBranches() async {
    return _userApiService.getBranches();
  }

  Future<KeyValueListResponse> getTitles() async {
    return _userApiService.getTitles();
  }

  Future<UpdateProfileResponse> updateUserDetails({
    required Map<String, dynamic> userUpdatedData,
    XFile? profilePhoto,
  }) async {
    return _userApiService.updateUserDetails(
      userUpdatedData: userUpdatedData,
      profilePhoto: profilePhoto,
    );
  }

  Future<SuccessResponse> userDocuments({
    XFile? aadharFront,
    XFile? aadharBack,
  }) async {
    return _userApiService.userDocuments(
      aadharFront: aadharFront,
      aadharBack: aadharBack,
    );
  }

  Future<SuccessResponse> deleteAccount() async {
    return _userApiService.deleteAccount();
  }
}
