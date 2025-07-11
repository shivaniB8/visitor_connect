import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';

import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_edit_form.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_update_provider.dart';

class VisitorUpdateScreen extends StatefulWidget {
  final Visitor? visitor;
  final List<KeyValueResponse>? titlesData;
  final List<KeyValueResponse>? bloodGroup;
  final List<KeyValueResponse>? visitorReason;
  final int? businessType;
  final bool isFromScan;

  const VisitorUpdateScreen(
      {super.key,
      this.visitor,
      this.titlesData,
      this.bloodGroup,
      this.visitorReason,
      this.businessType,
      this.isFromScan = false});

  @override
  State<VisitorUpdateScreen> createState() => _VisitorUpdateScreenState();
}

class _VisitorUpdateScreenState extends State<VisitorUpdateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Update Visitor screen");

    print(widget.visitor?.visitingReason);

    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Update Visitor',
        context: context,
        showEditIcon: false,
        showSettings: false,
      ),
      body: IgnorePointer(
        ignoring: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: EditVisitorsProvider(
              child: VisitorEditForm(
                isFromScan: widget.isFromScan,
                visitor: widget.visitor,
                titles: widget.titlesData,
                bloodGroup: widget.bloodGroup,
                reasonVisit: widget.visitorReason,
                businessType: widget.businessType,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
