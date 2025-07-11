import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_reported_builder.dart';
import 'package:provider/provider.dart';

class QrReportedVisitor extends StatefulWidget {
  final QrScannerDataResponse? visitor;
  final int businessType;
  const QrReportedVisitor({
    super.key,
    this.visitor,
    required this.businessType,
  });

  @override
  State<QrReportedVisitor> createState() => _QrReportedVisitorState();
}

class _QrReportedVisitorState extends State<QrReportedVisitor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.read<QrScannerBloc>().state is Progress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomImageAppBar(
          title: 'Report Details',
          context: context,
          showSettings: false,
          showEditIcon: false,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizedString(
                              'Visitor is reported',
                            ),
                            style: AppStyle.errorStyle(context).copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: sizeHeight(context) / 55),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Name',
                            style: AppStyle.bodyMedium(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            capitalizedString(
                              widget.visitor?.aw3 ?? 'Not Available',
                            ),
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Reported By',
                            style: AppStyle.bodyMedium(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            capitalizedString(
                              widget.visitor?.aw5 ?? 'Not Available',
                            ),
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Report Reason',
                            style: AppStyle.bodyMedium(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            capitalizedString(
                              widget.visitor?.aw7 ?? 'Not Available',
                            ),
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Reported On',
                            style: AppStyle.bodyMedium(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            timeStampToDateTime(
                              widget.visitor?.aw9 ?? 'Not Available',
                            ),
                            style: AppStyle.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CallQRApiBuilder(
                              businessType: widget.businessType,
                              onPressed: () async {
                                print("printDriving licence status");
                                print(widget.businessType);
                                await context
                                    .read<QrScannerBloc>()
                                    .getQrScannerData(
                                      visitorId: widget.visitor?.aw2 ?? 0,
                                      aadhar: '',
                                      allowToScan: 1,
                                      businessType: widget.businessType,
                                    );
                              },
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
                              isRectangularBorder: true,
                              text: "Cancel",
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    goToRoute(const HomePage()),
                                    (route) => false);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
