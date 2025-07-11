import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/wrong_location.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_code_scanner.dart';

class QrAccessibleOrNot extends StatefulWidget {
  const QrAccessibleOrNot({super.key});

  @override
  State<QrAccessibleOrNot> createState() => _QrAccessibleOrNotState();
}

class _QrAccessibleOrNotState extends State<QrAccessibleOrNot> {
  Position? currentPosition;
  bool? isLocationCorrect;
  String? businessType;
  int? _selectedValue;

  @override
  void initState() {
    super.initState();
    String? jsonString = SharedPrefs.getString(keyUserData);

    if (jsonString != null) {
      Map<String, dynamic> userData = jsonDecode(jsonString);
      businessType = userData['business_type'];
      if (businessType == "1") {
        _selectedValue = 1;
      } else if (businessType == "2") {
        _selectedValue = 2;
      } else {
        _selectedValue = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>().state.getData();
    return Initializer(
      init: (context) {
        ///TODO uncomment after demo
        getCurrentLocation(location: (location) {
          currentPosition = location;
        }).then(
          (value) {
            if ((getLocationStatus(
                  currentLatitude: currentPosition?.latitude,
                  currentLongitude: currentPosition?.longitude,
                  targetLatitude: userDetails?.latitude,
                  targetLongitude: userDetails?.longitude,
                ) ??
                false)) {
              isLocationCorrect = true;
              setState(() {});
            } else {
              isLocationCorrect = false;
              setState(() {});
            }
          },
        );
      },
      child: (isLocationCorrect ?? false)
          ? Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!(isLocationCorrect ?? false)) const LoadingWidget(),
                    SizedBox(
                      height: sizeHeight(context) / 40,
                    ),
                    const WrongLocationWidget(
                        buttonTitle: "Go Back To Home Page")
                  ],
                ),
              ),
            )
          : businessType == "1,2" && _selectedValue == null
              ? Scaffold(
                  appBar: CustomImageAppBar(
                    title: 'Business Type',
                    context: context,
                    showEditIcon: false,
                    showSettings: false,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormFieldLabel(
                          isFromFilter: true,
                          label: 'Choose Business Type',
                          style: AppStyle.titleLarge(context),
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Radio(
                                activeColor: primary_color,
                                value: 1,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                              ),
                              Text(
                                'Hotel / Home Stay',
                                style: AppStyle.bodyMedium(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Radio(
                                activeColor: primary_color,
                                value: 2,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                              ),
                              Text(
                                'Vehicle Rental (Two | Four Wheeler Rental)',
                                style: AppStyle.bodyMedium(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : QRCodeScanner(
                  businessType: _selectedValue ?? 0,
                ),
    );
  }
}
