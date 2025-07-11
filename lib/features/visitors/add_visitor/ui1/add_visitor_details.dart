import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/aadhar_data_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/save_visitors_deatils.dart';
import 'aadhar_details.dart';
import 'add_visitor_details_provider.dart';
import 'add_visitor_provider.dart';
import 'add_visitor_screen.dart';

class AddVisitorDetails extends StatefulWidget {
  const AddVisitorDetails({super.key, this.aadharDataResponse});
  final AadharDataResponse? aadharDataResponse;

  @override
  State<AddVisitorDetails> createState() => _AddVisitorDetailsState();
}

class _AddVisitorDetailsState extends State<AddVisitorDetails> {
  @override
  void initState() {
    super.initState();
    if (widget.aadharDataResponse != null) {
      if (!GlobalVariable.aadharData.contains(widget.aadharDataResponse?.id)) {
        GlobalVariable.aadharData.add(widget.aadharDataResponse!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final aadharNumbers = GlobalVariable.aadharData;
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        context: context,
        title: "Add Visitor Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sizeHeight(context) / 25,
              ),
              Container(
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Center(
                    child: Text(
                      'Indian',
                      style: AppStyle.bodySmall(context)
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizeHeight(context) / 35,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: aadharNumbers.length,
                itemBuilder: (context, index) {
                  return AadharDetails(
                    aadharDataResponse: aadharNumbers[index],
                  );
                },
              ),
              SizedBox(
                height: sizeHeight(context) / 35,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DotsProgressButton(
                  text: "Add Visitor",
                  onPressed: () {
                    Navigator.of(context).push(
                      goToRoute(
                        const AddVisitorProviders(
                          child: AddVisitorScreen(),
                        ),
                      ),
                    );
                  },
                  isRectangularBorder: true,
                ),
              ),
              SizedBox(
                height: sizeHeight(context) / 40,
              ),
              Center(
                child: Text(
                  "or",
                  style: AppStyle.bodyLarge(context),
                ),
              ),
              SizedBox(
                height: sizeHeight(context) / 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DotsProgressButton(
                  text: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      goToRoute(
                        AddVisitorDetailsProvider(
                          child: SaveVisitorDetails(
                            aadharDataResponse: widget.aadharDataResponse,
                          ),
                        ),
                      ),
                    );
                  },
                  isRectangularBorder: true,
                ),
              ),
              SizedBox(
                height: sizeHeight(context) / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
