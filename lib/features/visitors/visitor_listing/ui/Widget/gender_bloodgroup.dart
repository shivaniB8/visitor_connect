// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/update_visitor.dart';

class GenderDropdownEdit extends StatefulWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? genders;
  final Function()? onSuccess;
  bool isGenderNull;
  final bool isIsEnable;
  final String? initialValue;

  GenderDropdownEdit({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isGenderNull = false,
    this.genders,
    this.initialValue,
    required this.isIsEnable,
  });

  @override
  State<GenderDropdownEdit> createState() => _GenderDropdownEditState();
}

class _GenderDropdownEditState extends State<GenderDropdownEdit> {
  @override
  Widget build(BuildContext context) {
    return FormDropDownWidget(
      isNull:
          context.read<UpdateVisitor>().gender == null && widget.isGenderNull,
      isRequired: true,
      removeValue: () {
        context.read<UpdateVisitor>().gender = null;
        setState(() {
          widget.isGenderNull = true;
        });
      },
      errorMessage: "Please select Gender",
      dropdownFirstItemName: 'Select Gender',
      titles: widget.genders ?? [],
      title: widget.initialValue ?? "",
      onTap: (data) {
        if (data.value != null) {
          context.read<UpdateVisitor>().gender = data.value;
          setState(() {
            widget.isGenderNull = false;
          });
        }
      },
      isItEnabled: widget.isIsEnable,
    );
  }
}

class BloodGrpDropDownEdit extends StatefulWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? bloodGrps;
  final Function()? onSuccess;
  bool isBloodAGrpNull;
  final bool isIsEnable;
  final String? initialValue;

  BloodGrpDropDownEdit({
    super.key,
    this.onUpdateVoterPressed,
    this.initialValue,
    this.onSuccess,
    this.isBloodAGrpNull = false,
    this.bloodGrps,
    required this.isIsEnable,
  });

  @override
  State<BloodGrpDropDownEdit> createState() => _BloodGrpDropDownEditState();
}

class _BloodGrpDropDownEditState extends State<BloodGrpDropDownEdit> {
  @override
  Widget build(BuildContext context) {
    return FormDropDownWidget(
      isNull: context.read<UpdateVisitor>().bloodGrpFk == null &&
          widget.isBloodAGrpNull,
      isRequired: true,
      removeValue: () {
        context.read<UpdateVisitor>().bloodGrpFk = null;
        setState(() {
          widget.isBloodAGrpNull = true;
        });
      },
      errorMessage: "Please select Blood Group",
      dropdownFirstItemName: 'Select Blood Group',
      titles: widget.bloodGrps ?? [],
      title: widget.initialValue ?? "",
      onTap: (data) {
        if (data.value != null) {
          context.read<UpdateVisitor>().bloodGrpFk = data.value;
          context.read<UpdateVisitor>().bloodGrpValue = data.label;
          setState(() {
            widget.isBloodAGrpNull = false;
          });
        }
      },
      isItEnabled: widget.isIsEnable,
    );
  }
}
