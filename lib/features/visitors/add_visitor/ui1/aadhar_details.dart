import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/profile/ui/widget/imageWidget.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/aadhar_data_response.dart';

class AadharDetails extends StatefulWidget {
  final AadharDataResponse? aadharDataResponse;
  final bool showAllAadharDetails;

  const AadharDetails({
    Key? key,
    this.aadharDataResponse,
    this.showAllAadharDetails = true,
  }) : super(key: key);

  @override
  _AadharDetailsState createState() => _AadharDetailsState();
}

class _AadharDetailsState extends State<AadharDetails> {
  final GlobalKey _key = GlobalKey();
  double? containerHeight;

  @override
  void didUpdateWidget(AadharDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_key.currentContext != null) {
        final RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
        setState(() {
          containerHeight = box.size.height;
        });
      }
    });
  }

  Widget buildAadhaarData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ImageWidget(
              aadharImage: widget.aadharDataResponse?.aadharPhoto,
              profileImage: widget.aadharDataResponse?.profilePhoto,
            ),
            if (widget.showAllAadharDetails == false)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  capitalizedString(widget.aadharDataResponse?.fullName ?? ''),
                  style: AppStyle.bodyMedium(context),
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        if (widget.showAllAadharDetails)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                capitalizedString(widget.aadharDataResponse?.fullName ?? ''),
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(height: 5),
              Text(
                'Aadhar No. ${(widget.aadharDataResponse?.aadharNumber != null ? widget.aadharDataResponse?.aadharNumber!.replaceRange(0, 9, "*") : 'N/A') ?? 'N/A'}',
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(height: 5),
              Text(
                'DOB : ${widget.aadharDataResponse?.dob != null ? AppFunctions.formatDate(widget.aadharDataResponse?.dob ?? DateTime.now().toString()) : 'N/A'}',
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(height: 5),
              Text(
                'Gender : ${(widget.aadharDataResponse?.gender ?? 0).getGender()}',
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(height: 5),
              Text(
                'Address : ${widget.aadharDataResponse?.aadharAddress?.trim().split(' ').join(', ') ?? 'N/A'}',
                style: AppStyle.bodyMedium(context),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeHeight(context) / 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: background_grey_color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeHeight(context) / 30, vertical: 10),
            child: widget.aadharDataResponse?.fullName != null
                ? Container(
                    key: _key,
                    child: buildAadhaarData(),
                  )
                : SizedBox(
                    height: containerHeight ?? sizeHeight(context) / 4,
                    child: const LoadingWidget(),
                  ),
          ),
        ),
        SizedBox(
          height: sizeHeight(context) / 35,
        ),
      ],
    );
  }
}
