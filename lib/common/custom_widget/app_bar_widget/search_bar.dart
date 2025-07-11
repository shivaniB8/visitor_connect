import 'package:flutter/material.dart';

import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/Icons_button_app.dart';
import 'package:host_visitor_connect/common/enum.dart';

import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

import 'package:host_visitor_connect/common/utils/utils.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class SearchAppBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? searchedValue;
  final Color? searchFeildBgColor;
  final Function(String)? onSearch;

  const SearchAppBar({
    super.key,
    this.controller,
    this.hintText,
    this.searchFeildBgColor,
    this.searchedValue,
    this.onSearch,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _searchController = TextEditingController();

  bool clearSearchText = true;
  Visitor? selectedVisitorData;
  @override
  void initState() {
    super.initState();
    clearSearchText = false;
    widget.controller?.text = widget.searchedValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHeight(context) / 17,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          color: searchFeildBgColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: text_color.withOpacity(0.5))),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: text_color,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: AppStyle.bodyMedium(context),
              ),
              style: AppStyle.bodyMedium(context),
              onChanged: (value) {
                clearSearchText = false;
                setState(() {});
              },
              onFieldSubmitted: (text) {
                callSearch();
              },
            ),
          ),
          IconsButtonApp(
              onPressed: () {
                callSearch();
              },
              icon: (clearSearchText)
                  ? Icon(
                      Icons.close_rounded,
                      color: text_color.withOpacity(0.8),
                      size: sizeHeight(context) / 35,
                    )
                  : Icon(Icons.search_rounded,
                      color: text_color.withOpacity(0.8),
                      size: sizeHeight(context) / 35)),
        ],
      ),
    );
  }

  void callSearch() {
    if (clearSearchText) {
      _searchController.clear();
      widget.onSearch?.call("");
      clearSearchText = false;
      setState(() {});
      return;
    }
    if (_searchController.text.isNotEmpty) {
      widget.onSearch?.call(clearSearchText ? "" : _searchController.text);
      clearSearchText = true;
      setState(() {});
    }
  }
  // void clearSearch() {
  //   FocusScope.of(context).unfocus();
  //   widget.controller?.clear();
  //   setState(() => clearSearchText = false);
  //   switch (widget.searchFilterState) {
  //     case SearchFilterState.reportSearch:
  //       context.read<ReportVisitorSearchTermBloc>().visitorSearchReport(
  //             searchTerm: _searchController.text,
  //           );
  //     case SearchFilterState.reportListSearch:
  //       context.read<ReportListBloc>().reportSearchList(
  //             searchTerm: _searchController.text,
  //           );
  //       break;
  //
  //     default:
  //   }
  // }
  //
  // void searchVoter() {
  //   FocusScope.of(context).unfocus();
  //   clearSearchText = true;
  //   switch (widget.searchFilterState) {
  //     case SearchFilterState.reportSearch:
  //       context.read<ReportVisitorSearchTermBloc>().visitorSearchReport(
  //             searchTerm: _searchController.text,
  //           );
  //     case SearchFilterState.reportListSearch:
  //       context.read<ReportListBloc>().reportSearchList(
  //             searchTerm: _searchController.text,
  //           );
  //       break;
  //
  //     default:
  //   }
  // }

// providerFuntion() {
//   switch (widget.searchFilterState) {
//     case SearchFilterState.visitorSearch:
//       return BlocProvider.value(value: context.read<VisitorsGroupingBloc>());
//     case SearchFilterState.reportSearch:
//       return BlocProvider.value(value: context.read<ReportListBloc>());
//     default:
//   }
// }
}
