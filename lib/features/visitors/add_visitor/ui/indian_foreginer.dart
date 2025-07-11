import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/wrong_location.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/add_foregin_visitor.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/add_visitor_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/add_visitor_screen.dart';

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
          // showEditIcon: false,
          // showSettings: false,
          title: 'Add Visitor',
          context: context,
        ),
        // body: Text('hoo'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: sizeHeight(context) / 50),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Visitor is",
                style: AppStyle.titleLarge(context),
              ),
            ),
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
            SizedBox(
              height: sizeHeight(context) / 17,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DotsProgressButton(
                  onPressed: () {
                    if (!isSelected1 && !isSelected2) {
                      setState(() {
                        error = 'Please select visitor type';
                      });
                    } else {
                      Navigator.of(context).push(
                        goToRoute(
                          isSelected1
                              ? const AddVisitorProviders(
                                  child: AddVisitorScreen())
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
          ],
        ),
      ),
    );
  }
}

class VisitorDetailsCard extends StatelessWidget {
  final String visitorIs;
  final String imagePath;
  final String title;
  final List<String> details;
  final bool isSelected;

  const VisitorDetailsCard({
    Key? key,
    required this.visitorIs,
    required this.imagePath,
    required this.title,
    required this.details,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeHeight(context) / 35),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Expanded(
                child: Container(
                  width: appSize(context: context, unit: 1.5),
                  decoration: BoxDecoration(
                    color: background_grey_color,
                    border: Border.all(
                        color: Colors.grey.withOpacity(
                      0.3,
                    )),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        visitorIs,
                        style: AppStyle.bodySmall(context),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: sizeHeight(context) / 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: sizeHeight(context) / 30),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isSelected
                  ? primary_color.withOpacity(0.3)
                  : background_grey_color,
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    height: sizeHeight(context) / 8,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyle.bodyLarge(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        ...details
                            .map(
                              (detail) => Text(
                                ' \u2022 $detail',
                                style: AppStyle.bodyMedium(context),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
