import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/model/add_indian_visitor.dart';

class GenderDropdown extends StatelessWidget {
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? genders;
  final Function()? onSuccess;
  final bool isGenderNull;

  const GenderDropdown({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    required this.isGenderNull,
    this.genders,
  });

  @override
  Widget build(BuildContext context) {
    return FormDropDownWidget(
      isNull: isGenderNull,
      isRequired: true,
      removeValue: () {
        context.read<AddForeignerVisitor>().gender = null;
      },
      errorMessage: "Please select Gender",
      dropdownFirstItemName: 'Select Gender',
      titles: genders ?? [],
      title: '',
      onTap: (data) {
        if (data.value != null) {
          context.read<AddForeignerVisitor>().gender = data.value;
        }
      },
      isItEnabled: true,
    );
  }
}
