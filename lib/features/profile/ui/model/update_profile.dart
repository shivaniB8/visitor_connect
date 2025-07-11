import 'package:host_visitor_connect/features/profile/data/network/request/update_profile_request.dart';

class UpdateProfile {
  int? userId;
  String? title;
  int? fkTitle;
  String? fullName;
  String? email;
  String? address;

  UpdateProfileRequest toApiModel() {
    return UpdateProfileRequest(
      title: title,
      fkTitle: fkTitle,
      email: email,
      fullName: fullName,
      userId: userId,
      address: address,
    );
  }
}
