import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';

import 'package:host_visitor_connect/features/Filter/ui/widgets/show_bottom_sheet.dart';

class SelectField extends StatefulWidget {
  final List<KeyValueResponse> items;
  final String hintText;
  final String title;
  final bool displaySearchField;
  final bool showBottomSheet;
  final Widget? suffixIcon;
  final Function(KeyValueResponse? v) onSelect;
  final String? errorMsg;
  final Function() onTap;
  final bool? enabled;
  final TextStyle? style;

  const SelectField(
      {Key? key,
      required this.items,
      required this.title,
      required this.hintText,
      required this.displaySearchField,
      this.suffixIcon,
      this.showBottomSheet = true,
      required this.onSelect,
      this.errorMsg,
      required this.onTap,
      this.enabled = true,
      this.style})
      : super(key: key);

  @override
  _SelectFieldState createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  TextEditingController searchController = TextEditingController();
  late ValueNotifier<List<KeyValueResponse>> itemsNotifier;

  @override
  void initState() {
    super.initState();
    itemsNotifier = ValueNotifier<List<KeyValueResponse>>(widget.items);
  }

  @override
  void didUpdateWidget(covariant SelectField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        itemsNotifier.value = widget.items;
      });
    }
  }

  void _openBottomSheet(BuildContext context) {
    showBottomSheetSearch(
      displaySearchField: widget.displaySearchField,
      context: context,
      hintText: widget.title,
      searchController: searchController,
      itemsNotifier: itemsNotifier,
      onSelect: widget.onSelect,
    );
  }

  void _onTapHandler(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    widget.onTap();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          return AddFormField(
            reportFilter: true,
            isEnable2: true,
            isEnable: true,
            errorMsg: widget.errorMsg,
            title: widget.title,
            hintText: widget.hintText,
            style: widget.style,
            onChanged: (v) {},
            onTap: () => _onTapHandler(context),
            suffixIcon: widget.suffixIcon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: primary_color,
                ),
          );
        }),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    itemsNotifier.dispose();
    super.dispose();
  }
}
