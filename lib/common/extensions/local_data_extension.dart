import 'dart:convert';
import 'dart:developer';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/features/login/data/network/response/login_branch_response.dart';

List<dynamic> contactJson(List<Contact> data) {
  List<Contact> contacts = data;
  List<dynamic> list = [];

  for (var element in contacts) {
    list.add(jsonEncode(element.toMap()));
  }

  return list;
}

Future<List<KeyValueResponse>> getBranch() async {
  late String? branch = SharedPrefs.getString(keyBranchList);
  if (!(branch.isNullOrEmpty())) {
    late final branches = json.decode(
      branch ?? '',
    );
    late final List<KeyValueResponse> branchList = [];
    for (var i in branches) {
      branchList.add(KeyValueResponse.fromJson(i));
    }
    List<KeyValueResponse> newBranchList = [];
    List<double> distanceList = [];
    Position? currentLocation;

    final getLocation = GetLocation();
    var s = await getLocation.getCurrentLocation();
    currentLocation = s;
    for (int i = 0; i < branchList.length; i++) {
      if ((getLocationStatus(
            currentLatitude: currentLocation?.latitude,
            currentLongitude: currentLocation?.longitude,
            targetLatitude: branchList[i].latitude,
            targetLongitude: branchList[i].longitude,
          ) ??
          false)) {
        double distance = LocationUtils().calculateDistance(
          currentLocation?.latitude,
          currentLocation?.longitude,
          branchList[i].latitude,
          branchList[i].longitude,
        );

        distanceList.add(distance);
        if (distanceList.isNotEmpty &&
            branchList.isNotEmpty &&
            distanceList.length == branchList.length) {
          double smallest =
              distanceList.reduce((curr, next) => curr < next ? curr : next);
          int nearestBranchIndex = distanceList.indexOf(smallest);

          for (int i = 0; i < branchList.length; i++) {
            if (distanceList[i] == smallest) {
              newBranchList.add(branchList[i]);
            }

            String branchInfo =
                'Branch Name: ${branchList[i].label}, Latitude: ${branchList[i].latitude}, Longitude: ${branchList[i].longitude}, Distance: ${distanceList[i]}';

            if (i == nearestBranchIndex) {
              print('$branchInfo [Nearest]');
            } else {
              print(branchInfo);
            }
          }

          KeyValueResponse nearestBranch = branchList[nearestBranchIndex];
          String nearestBranchJson = json.encode(nearestBranch.toJson());
          SharedPrefs.setString('nearestBranch', nearestBranchJson);
        } else {
          print(
              'Error: distanceList and branchList must not be empty and should have the same length.');
        }
      }
    }
    return newBranchList;
  }
  return [];
}
