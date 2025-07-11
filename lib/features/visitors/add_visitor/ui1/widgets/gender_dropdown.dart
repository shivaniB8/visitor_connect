import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/model/add_indian_visitor.dart';

class GenderDropdown extends StatefulWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? genders;
  final Function()? onSuccess;
  bool isGenderNull;
  final bool isIsEnable;

  GenderDropdown({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isGenderNull = false,
    this.genders,
    required this.isIsEnable,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return FormDropDownWidget(
      isNull: context.read<AddForeignerVisitor>().gender == null &&
          widget.isGenderNull,
      isRequired: true,
      removeValue: () {
        context.read<AddForeignerVisitor>().gender = null;
        setState(() {
          widget.isGenderNull = true;
        });
      },
      errorMessage: "Please select Gender",
      dropdownFirstItemName: 'Select Gender',
      titles: widget.genders ?? [],
      title: '',
      onTap: (data) {
        if (data.value != null) {
          context.read<AddForeignerVisitor>().gender = data.value;
          setState(() {
            widget.isGenderNull = false;
          });
        }
      },
      isItEnabled: widget.isIsEnable,
    );
  }
}

class BloodGrpDropDown extends StatefulWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? bloodGrps;
  final Function()? onSuccess;
  bool isBloodAGrpNull;
  final bool isIsEnable;

  BloodGrpDropDown({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isBloodAGrpNull = false,
    this.bloodGrps,
    required this.isIsEnable,
  });

  @override
  State<BloodGrpDropDown> createState() => _BloodGrpDropDownState();
}

class _BloodGrpDropDownState extends State<BloodGrpDropDown> {
  @override
  Widget build(BuildContext context) {
    return FormDropDownWidget(
      isNull: context.read<AddForeignerVisitor>().bloodGrpFk == null &&
          widget.isBloodAGrpNull,
      isRequired: true,
      removeValue: () {
        context.read<AddForeignerVisitor>().bloodGrpFk = null;
        setState(() {
          widget.isBloodAGrpNull = true;
        });
      },
      errorMessage: "Please select Blood Group",
      dropdownFirstItemName: 'Select Blood Group',
      titles: widget.bloodGrps ?? [],
      title: '',
      onTap: (data) {
        if (data.value != null) {
          context.read<AddForeignerVisitor>().bloodGrpFk = data.value;
          context.read<AddForeignerVisitor>().bloodGrpValue = data.label;
          setState(() {
            widget.isBloodAGrpNull = false;
          });
        }
      },
      isItEnabled: widget.isIsEnable,
    );
  }
}
