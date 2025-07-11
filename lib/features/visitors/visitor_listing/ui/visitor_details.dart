// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/model/report.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_provider.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/reason_visit_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/visitor_history_fragment.dart';
import 'package:host_visitor_connect/features/visitors/history/ui/visitor_history_provider.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitor_details_body.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_update_screen.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom_widget/widget/cancel_bottom_sheet.dart';

class VisitorDetails extends StatefulWidget {
  final Visitor? visitor;
  final Report? report;
  final bool? isFromCurrentVisitors;
  final String? businessType;
  const VisitorDetails({
    super.key,
    this.visitor,
    this.report,
    this.isFromCurrentVisitors,
    this.businessType,
  });

  @override
  State<VisitorDetails> createState() => _VisitorDetailsState();
}

class _VisitorDetailsState extends State<VisitorDetails>
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
    print("visitor details data");
    print(widget.visitor?.visaNumber);
    print(widget.visitor?.visaExpiryDate);
    print(widget.visitor?.visitingReason);
    print(widget.visitor?.visitingReasonFk);
    print(widget.visitor?.birthDate.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomImageAppBar(
        title: 'Visitor Details',
        context: context,
        showEditIcon: false,
        showSettings: false,
      ),
      body: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            labelStyle: text_style_para1.copyWith(
              fontSize: 16.0,
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
                text: 'Visitor',
              ),
              Tab(
                text: 'History',
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
                    child: BlocProvider(
                      create: (_) => OutgoingCallBloc(),
                      child: VisitorDetailsBody(
                        businessType: widget.businessType,
                        isFromCurrentVisitors: widget.isFromCurrentVisitors,
                        visitor: widget.visitor,
                      ),
                    ),
                  ),
                ),
                VisitorsHistoryProvider(
                  child: VisitorsHistoryFragment(
                    visitorId: widget.visitor?.visitorFk,
                    visitor: widget.visitor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateVoterDetails extends StatefulWidget {
  final Visitor? visitor;
  final bool isFromScan;
  final int? businessType;

  const UpdateVoterDetails({
    super.key,
    this.visitor,
    this.businessType,
    this.isFromScan = false,
  });

  @override
  State<UpdateVoterDetails> createState() => _UpdateVoterDetailsState();
}

class _UpdateVoterDetailsState extends State<UpdateVoterDetails> {
  @override
  Widget build(BuildContext context) {
    print("visitor other reason");
    print(widget.visitor?.visitingReason);
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
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MultiProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => TitlesBloc(),
                          ),
                          BlocProvider(
                            create: (_) => BloodGrpBloc(),
                          ),
                          BlocProvider(
                            create: (_) => ReasonToVisitBloc(),
                          ),
                        ],
                        child: UpdateVoterDetailsBottomSheet(
                          isFromScan: widget.isFromScan,
                          visitor: widget.visitor,
                          businessType: widget.businessType,
                        )),
                    const CancelBottomSheet()
                  ],
                ),
              );
            },
          );
        },
        isRectangularBorder: true,
        backgroundColor: buttonColor,
        text: 'Update',
      ),
    );
  }
}

class UpdateVoterDetailsBottomSheet extends StatefulWidget {
  final Visitor? visitor;
  final int? businessType;
  final bool isFromScan;

  const UpdateVoterDetailsBottomSheet(
      {super.key,
      required this.visitor,
      this.businessType,
      this.isFromScan = false});

  @override
  State<UpdateVoterDetailsBottomSheet> createState() =>
      _UpdateVoterDetailsBottomSheetState();
}

class _UpdateVoterDetailsBottomSheetState
    extends State<UpdateVoterDetailsBottomSheet> {
  List<KeyValueResponse>? titlesData;
  List<KeyValueResponse>? bloodGroup;
  List<KeyValueResponse>? visitorReason;

  @override
  void initState() {
    getTitle();
    getBloodGrps();
    getVisitorReason();
    super.initState();
  }

  getTitle() async {
    if (titlesData == null) {
      await context.read<TitlesBloc>().getTitles().then((value) {
        titlesData = context.read<TitlesBloc>().state.getData()?.data;
      });
    }
  }

  getBloodGrps() async {
    if (bloodGroup == null) {
      await context.read<BloodGrpBloc>().getBloodGrps().then((value) {
        bloodGroup = context.read<BloodGrpBloc>().state.getData()?.data;
      });
    }
  }

  getVisitorReason() async {
    if (visitorReason == null) {
      await context.read<ReasonToVisitBloc>().getReasonToVisit().then((value) {
        visitorReason = context.read<ReasonToVisitBloc>().state.getData()?.data;
      });
    }
  }

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
        children: [
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
              child: Text(
                'Update Visitor',
                style: AppStyle.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.w500, color: profileTextColor),
              ),
            ),
            onTap: () async {
              await getTitle();
              await getBloodGrps();
              await getVisitorReason();
              if (titlesData != null &&
                  bloodGroup != null &&
                  visitorReason != null) {
                Navigator.push(
                  context,
                  goToRoute(
                    MultiProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => TitlesBloc(),
                        ),
                        BlocProvider(
                          create: (_) => ReasonToVisitBloc(),
                        ),
                        BlocProvider(
                          create: (_) => OutgoingCallBloc(),
                        ),
                        BlocProvider(
                          create: (_) => BloodGrpBloc(),
                        ),
                      ],
                      child: VisitorUpdateScreen(
                        isFromScan: widget.isFromScan,
                        visitor: widget.visitor,
                        titlesData: titlesData,
                        bloodGroup: bloodGroup,
                        visitorReason: visitorReason,
                        businessType: widget.businessType,
                      ),
                    ),
                  ),
                );
              } else {
                AppActionDialog.showActionDialog(
                  image: "$icons_path/ErrorIcon.png",
                  context: context,
                  title: "Error occurred",
                  subtitle: "Something went wrong please\ntry again",
                  child: DotsProgressButton(
                    text: "Try Again",
                    isRectangularBorder: true,
                    buttonBackgroundColor: const Color(0xffF04646),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  showLeftSideButton: false,
                );
              }
            },
          ),
          // Container(
          //   height: 2,
          //   color: dividerColor,
          // ),
          // GestureDetector(
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(10),
          //         bottomRight: Radius.circular(10),
          //       ),
          //     ),
          //     alignment: Alignment.center,
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
          //     child: Text(
          //       'Report Visitor',
          //       style: AppStyle.bodyLarge(context).copyWith(
          //           fontWeight: FontWeight.w500, color: profileTextColor),
          //     ),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       goToRoute(
          //         ReportVisitorProviders(
          //           child: ReportVisitorScreen(
          //             visitor: widget.visitor,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
