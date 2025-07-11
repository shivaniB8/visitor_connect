import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/wrong_location.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/indian_foreginer.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_foregin_visitor.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_screen.dart';
import 'add_foreigner_provider.dart';

class IndianForeignerVisitor extends StatefulWidget {
  const IndianForeignerVisitor({super.key});

  @override
  State<IndianForeignerVisitor> createState() => _IndianForeignerVisitorState();
}

class _IndianForeignerVisitorState extends State<IndianForeignerVisitor> {
  bool isSelected1 = false;
  bool isSelected2 = false;
  Position? currentPosition;
  String error = '';

  void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBEDF3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 8,
                    child: Text(
                      'Not Allowed',
                      style: text_style_title7,
                    ),
                  ),
                ),
              ),
              const WrongLocationWidget()
            ],
          ),
        );
      },
    ).then(
      (value) => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>().state.getData();
    return Initializer(
      init: (context) {
        getCurrentLocation(location: (location) {
          currentPosition = location;
        }).then(
          (value) {
            if (!(getLocationStatus(
                  currentLatitude: currentPosition?.latitude,
                  currentLongitude: currentPosition?.longitude,
                  targetLatitude: userDetails?.latitude,
                  targetLongitude: userDetails?.longitude,
                ) ??
                false)) {
              afterBuild(
                () async {
                  try {
                    _showLocationPopup(context);
                  } catch (_) {}
                },
              );
            }
          },
        );
      },
      child: Scaffold(
        appBar: CustomImageAppBar(
          showSettings: false,
          showEditIcon: false,
          context: context,
          title: "Add Visitor",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeHeight(context) / 20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Visitor is",
                  style: AppStyle.bodyMedium(context),
                ),
              ),
              SizedBox(height: sizeHeight(context) / 40),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected1 = true;
                    isSelected2 = false;
                    error = '';
                  });
                },
                child: VisitorDetailsCard(
                  visitorIs: "Indian",
                  imagePath: '$images_path/indian_visitor.png',
                  title: 'Required Details',
                  details: const [
                    'Aadhaar card No.',
                    'Mobile No.',
                  ],
                  isSelected: isSelected1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected1 = false;
                    isSelected2 = true;
                    error = '';
                  });
                },
                child: VisitorDetailsCard(
                  visitorIs: "Foreigner",
                  imagePath: '$images_path/foreigner_visitor.png',
                  title: 'Required Details',
                  details: const [
                    'Passport No.',
                    'Visa No.',
                    'Mobile No.',
                    'Upload Photos',
                  ],
                  isSelected: isSelected2,
                ),
              ),
              if (error != '')
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    error,
                    style: AppStyle.errorStyle(context),
                  ),
                ),
              SizedBox(height: sizeHeight(context) / 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DotsProgressButton(
                      onPressed: () {
                        if (!isSelected1 && !isSelected2) {
                          setState(() {
                            error = 'Please select visitor type';
                          });
                        } else {
                          GlobalVariable.aadharData.clear();
                          Navigator.of(context).push(
                            goToRoute(
                              isSelected1
                                  ? const AddVisitorProviders(
                                      child: AddVisitorScreen(),
                                    )
                                  : const AddForeignerVisitorProviders(
                                      child: AddForeignVisitor(),
                                    ),
                            ),
                          );
                        }
                      },
                      isRectangularBorder: true,
                      text: "Next",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
