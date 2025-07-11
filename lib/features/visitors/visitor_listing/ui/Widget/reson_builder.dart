import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/visitors_update_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/update_visitor.dart';
import 'package:provider/provider.dart';

import '../../../../../common/blocs/state_events/ui_state.dart';

class ReasonBuilderEdit extends StatefulWidget {
  final bool? isFromListing;
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? reasons;
  final Function()? onSuccess;
  final bool isUpdate;
  bool reasonIsNull;
  final String? reason;
  final Function()? isSelectedReasonOther;
  final bool? isIsEnable;

  ReasonBuilderEdit({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isUpdate = false,
    required this.reasonIsNull,
    this.isSelectedReasonOther,
    this.reasons,
    this.isFromListing,
    this.reason,
    this.isIsEnable,
  });

  @override
  State<ReasonBuilderEdit> createState() => _ReasonBuilderEditState();
}

class _ReasonBuilderEditState extends State<ReasonBuilderEdit> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorsBloc>().state is Progress,
      child: FormDropDownWidget(
        isNull: widget.reasonIsNull,
        isRequired: true,
        removeValue: () {
          context.read<UpdateVisitor>().reason = null;
          context.read<UpdateVisitor>().reasonFk = null;
          setState(() {
            widget.reasonIsNull = true;
          });
        },
        errorMessage: "Please select Reason",
        dropdownFirstItemName: 'Select Reason',
        titles: widget.reasons ?? [],
        title: widget.reason ?? '',
        onTap: (data) {
          if (!(data.label.isNullOrEmpty())) {
            context.read<UpdateVisitor>().reason = data.label;
            context.read<UpdateVisitor>().reasonFk = data.value;
              widget.reasonIsNull = false;
              widget.isSelectedReasonOther?.call();
            setState(() {
            });
          }
        },
        isItEnabled: widget.isIsEnable ?? false,
      ),
    );
  }
}
