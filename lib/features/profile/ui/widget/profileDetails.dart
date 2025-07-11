import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';

class ProfileDetails extends StatelessWidget {
  final UserDetailsResponse? userData;
  final List<KeyValueResponse>? branchList;

  const ProfileDetails({super.key, this.userData, this.branchList});

  Future<KeyValueResponse?> getStoredNearestBranch() async {
    // Retrieve the JSON string of the nearest branch from SharedPrefs
    String? nearestBranchJson = SharedPrefs.getString('nearestBranch');

    // Check if a value is stored
    if (nearestBranchJson != null && nearestBranchJson.isNotEmpty) {
      // Decode the JSON to a Map
      Map<String, dynamic> nearestBranchMap = json.decode(nearestBranchJson);

      // Convert the Map to a KeyValueResponse object
      KeyValueResponse nearestBranch =
          KeyValueResponse.fromJson(nearestBranchMap);
      return nearestBranch;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String stationAddress;
    if (userData?.branchArea == null &&
        userData?.branchCity == null &&
        userData?.branchState == null &&
        userData?.branchPincode == null) {
      stationAddress = "Not Available";
    } else {
      stationAddress =
          "${userData?.branchArea ?? ""}, ${userData?.branchCity ?? ""}, ${userData?.branchState ?? ""}, ${userData?.branchPincode ?? ""}";
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: profileHeadingColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11), topRight: Radius.circular(11))),
          padding: EdgeInsets.symmetric(
              vertical: sizeHeight(context) / 60,
              horizontal: appSize(context: context, unit: 10) / 10),
          child: Text(
            'Profile Details',
            style: AppStyle.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        content(
          context: context,
          image: "$icons_path/email.png",
          title: "Email Id",
          subtitle: (userData?.email?.isNotEmpty ?? false)
              ? userData?.email ?? ''
              : "Not Available", // Ensure non-nullable String
        ),
        FutureBuilder<KeyValueResponse?>(
          future: getStoredNearestBranch(),
          builder: (BuildContext context,
              AsyncSnapshot<KeyValueResponse?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              KeyValueResponse? nearestBranch = snapshot.data;
              return content(
                context: context,
                image: "$icons_path/building.png",
                title: "Branch",
                subtitle: nearestBranch?.label ??
                    "Not Available", // Handle nullability
              );
            } else {
              return content(
                context: context,
                image: "$icons_path/building.png",
                title: "Branch",
                subtitle: "Not Available",
              );
            }
          },
        ),
        FutureBuilder<KeyValueResponse?>(
          future: getStoredNearestBranch(),
          builder: (BuildContext context,
              AsyncSnapshot<KeyValueResponse?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              KeyValueResponse? nearestBranch = snapshot.data;
              return content(
                context: context,
                image: "$icons_path/building.png",
                title: "Address",
                subtitle: nearestBranch?.branchAddress ??
                    "Not Available", // Handle nullability
              );
            } else {
              return content(
                context: context,
                image: "$icons_path/building.png",
                title: "Address",
                subtitle: "Not Available",
              );
            }
          },
        ),
      ],
    );
  }

  Widget content({
    required BuildContext context,
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: sizeHeight(context) / 50,
              horizontal: appSize(context: context, unit: 10) / 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                color: lightBgColor,
                height: sizeHeight(context) / 35,
                width: sizeHeight(context) / 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyle.bodySmall(context).copyWith(
                          color: lightBgColor, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: sizeHeight(context) / 130,
                    ),
                    Text(
                      subtitle,
                      style: AppStyle.bodySmall(context).copyWith(
                          color: profileTextColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 1,
          margin: EdgeInsets.symmetric(
              horizontal: appSize(context: context, unit: 10) / 30),
          color: lightBgColor,
        )
      ],
    );
  }
}
