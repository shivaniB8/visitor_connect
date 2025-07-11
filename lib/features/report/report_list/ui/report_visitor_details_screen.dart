import 'package:flutter/material.dart';

import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';

import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/cancel_bottom_sheet.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/report/report_history/ui/report_history_fragment.dart';
import 'package:host_visitor_connect/features/report/report_history/ui/report_history_provider.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_provider.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitor_details_body.dart';

import 'model/report.dart';

class ReportVisitorDetailsScreen extends StatefulWidget {
  final Report? report;

  const ReportVisitorDetailsScreen({
    super.key,
    this.report,
  });

  @override
  State<ReportVisitorDetailsScreen> createState() =>
      _ReportVisitorDetailsScreenState();
}

class _ReportVisitorDetailsScreenState extends State<ReportVisitorDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomImageAppBar(
        title: 'Visitor',
        context: context,
        showEditIcon: false,
        showSettings: false,
      ),
      body: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            labelStyle: text_style_para1.copyWith(
              fontSize: 18.0,
              color: const Color(0xFFc9c9c9),
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Colors.black,
            indicatorWeight: 1,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            unselectedLabelStyle: text_style_para1.copyWith(
              fontSize: 15.0,
              color: const Color(0xFFc9c9c9),
              fontWeight: FontWeight.w500,
            ),
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Report Details',
              ),
              Tab(
                text: 'Report History',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: VisitorDetailsBody(
                      isReported: true,
                      visitor: Visitor(
                        id: widget.report?.id,
                        fullName: widget.report?.visitorFkValue,
                        visitorFk: widget.report?.visitorFk,
                        city: widget.report?.city,
                        area: widget.report?.area,
                        pincode: widget.report?.pincode,
                        // clientName: widget.reports[index].clientName,
                        age: widget.report?.age,
                        gender: widget.report?.gender,
                        mobileNo: widget.report?.mobileNumber,
                        email: widget.report?.email,
                        visitorType: widget.report?.visitorType,
                        country: widget.report?.country,
                        image: widget.report?.visitorPhoto,
                        registrationDate: widget.report?.registrationDate,
                        expiryDate: widget.report?.expiryDate,
                        aadharNo: widget.report?.aadharNumber,
                        visitingReason: widget.report?.reasonValueVisit,
                        visaNumber: widget.report?.visaNumber,
                        visitorExitDate: widget.report?.visaExpiry,
                        passportNo: widget.report?.passportNumber,
                        qrImage: widget.report?.qrPhoto,
                        aadharImage: widget.report?.aadharPhoto,
                        address: widget.report?.address,
                        entryDate: widget.report?.visitingFrom,
                        lastUpdatedBy: widget.report?.updatedBy,
                        updatedAt: widget.report?.updatedAt,
                        visitingReasonFk: widget.report?.reasonFkVisit,
                        visitingTill: widget.report?.visitingTill,
                        reasonValue: widget.report?.reasonToVisit,
                        aadharVerifiedStatus:
                            widget.report?.aadharVerifiedStatus,
                        passportVerifiedStatus:
                            widget.report?.passportVerifiedStatus,
                      ),
                    ),
                  ),
                ),
                ReportHistoryProvider(
                  child: ReportHistoryFragment(
                      visitorId: widget.report?.visitorFk,
                      report: widget.report),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateVoterDetails extends StatelessWidget {
  final Visitor? visitor;

  const UpdateVoterDetails({
    super.key,
    this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: sizeHeight(context) / 5,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    UpdateVoterDetailsBottomSheet(
                      visitor: visitor,
                    ),
                    const CancelBottomSheet()
                  ],
                ),
              );
            },
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 16),
        isRectangularBorder: true,
        text: 'Update',
      ),
    );
  }
}

class UpdateVoterDetailsBottomSheet extends StatelessWidget {
  final Visitor? visitor;

  const UpdateVoterDetailsBottomSheet({
    super.key,
    required this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // GestureDetector(
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(10),
          //         topRight: Radius.circular(10),
          //       ),
          //     ),
          //     alignment: Alignment.center,
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
          //     child: Text(
          //       'Update Visitor',
          //       style: AppStyle.bodyLarge(context).copyWith(
          //           fontWeight: FontWeight.w500, color: profileTextColor),
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       goToRoute(
          //         MultiProvider(
          //           providers: [
          //             BlocProvider(
          //               create: (_) => TitlesBloc(),
          //             ),
          //             BlocProvider(
          //               create: (_) => ReasonToVisitBloc(),
          //             ),
          //           ],
          //           child: VisitorUpdateScreen(
          //             visitor: visitor,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // Container(
          //   height: 2,
          //   color: dividerColor,
          // ),
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
              child: Text(
                'Report Visitor',
                style: AppStyle.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.w500, color: profileTextColor),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                goToRoute(
                  ReportVisitorProviders(
                    child: ReportVisitorScreen(
                      visitor: visitor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
