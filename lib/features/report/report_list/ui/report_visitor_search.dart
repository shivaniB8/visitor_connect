import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/search_bar.dart';

import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';

import 'package:host_visitor_connect/common/enum.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_search_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_provider.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_screen.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/searched_visitor_listing.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'model/search_term.dart';

class ReportVisitorSearch extends StatefulWidget {
  final SearchFilterState? searchFilterState;
  final SearchFilterState? searchListState;

  const ReportVisitorSearch(
      {super.key, this.searchFilterState, this.searchListState});

  @override
  State<ReportVisitorSearch> createState() => _ReportVisitorSearchState();
}

class _ReportVisitorSearchState extends State<ReportVisitorSearch> {
  Visitor? selectedVisitorData;
  String _searchQuery = '';

  void onSearch(String query) {
    _searchQuery = query;
    context
        .read<ReportVisitorSearchTermBloc>()
        .visitorSearchReport(pageNo: 0, searchTerm: _searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomImageAppBar(
        title: 'Reported Visitor List',
        context: context,
        showSearchField: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(sizeHeight(context) / 80),
            child: SearchAppBar(
              onSearch: onSearch,
              hintText: "Search by Name.",
              searchFeildBgColor: Colors.transparent,
            ),
          ),
          searchListing(),
          (selectedVisitorData?.fullName?.isNotEmpty ?? false) &&
                  MediaQuery.of(context).viewInsets.bottom == 0
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: DotsProgressButton(
                      isRectangularBorder: true,
                      text: 'Continue',
                      isProgress: false,
                      onPressed: () {
                        if (!(selectedVisitorData?.fullName.isNullOrEmpty() ??
                            false)) {
                          Navigator.push(
                            context,
                            goToRoute(
                              ReportVisitorProviders(
                                child: ReportVisitorScreen(
                                  visitor: selectedVisitorData,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget searchListing() {
    final state = context.watch<ReportVisitorSearchTermBloc>().state;
    if (state is Progress) {
      return Center(
        child: Container(
            padding: const EdgeInsets.only(
              top: 230,
            ),
            child: LoadingWidget()),
      );
    } else if ((context.read<ReportVisitorSearchTermBloc>().visitor.isEmpty) &&
        state is Success) {
      return const BlankSlate(title: 'Visitor not found');
    } else if ((context
        .read<ReportVisitorSearchTermBloc>()
        .visitor
        .isNotEmpty)) {
      return Expanded(
        child: SearchedVisitorListing(
          searchTerm: context.read<ReportSearch>().searchTerm,
          selectedVisitorData: (selectedVoter) {
            setState(
              () {
                // TODO: Highlight this line in pink: selectedVisitorData = selectedVoter;
                selectedVisitorData = selectedVoter;
              },
            );
          },
          visitor: context.read<ReportVisitorSearchTermBloc>().visitor,
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
          child: Text(
            "Search For Vistors List",
            style: AppStyle.bodyLarge(context).copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
        ),
      );
    }
  }
}
