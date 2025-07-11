import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/single_selection_dropdwon.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';

class BranchDropDown extends StatelessWidget {
  final Function()? onLoginPressed;
  final Function()? onSuccess;
  final bool isUpdate;
  final List<KeyValueResponse>? list;

  const BranchDropDown({
    super.key,
    this.onLoginPressed,
    this.onSuccess,
    this.isUpdate = false,
    this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SingleSelectionDropdown(
      dropdownFirstItemName: 'Select Branch',
      isRequired: true,
      removeValue: () {},
      errorMessage: "Please select Branch.",
      list: list ?? [],
      onTap: (data) {},
      initialValue: '',
    );
  }
}
