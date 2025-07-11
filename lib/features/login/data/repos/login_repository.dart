import 'package:host_visitor_connect/common/data/network/responses/success_response.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/login/data/network/api_services/login_api_service.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_branch_response.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_response.dart';

class LoginRepository {
  final LoginApiService _loginApiService;

  LoginRepository({LoginApiService? loginApiService})
      : _loginApiService = loginApiService ?? LoginApiService();

  Future<LoginResponse> loginWithPassword({
    required String phoneNo,
    required String password,
    required int branchId,
    required int reLoginId,
    int? hostId,
  }) async {
    return _loginApiService.loginWithPassword(
        phoneNo: phoneNo,
        hostId: hostId,
        password: password,
        branchId: branchId,
        reLoginId: reLoginId);
  }

  Future<LoginBranchResponse> loginMobileNumber({
    required String phoneNo,
  }) async {
    return _loginApiService.loginMobileNumber(
      phoneNo: phoneNo,
    );
  }

  Future<void> postData({
    required Map<String, dynamic> data,
  }) async {
    return _loginApiService.postData(
      data: data,
    );
  }

  Future<SuccessResponse> forgotPassword({
    required String phoneNo,
  }) async {
    return _loginApiService.forgotPassword(
      phoneNo: phoneNo,
    );
  }

  Future<SuccessResponse> logout() async {
    return _loginApiService.logout();
  }

  bool isUserLoggedIn() {
    final authToken = SharedPrefs.getString(apiAuthenticationToken);
    return authToken != null && authToken.isNotEmpty;
  }
}
