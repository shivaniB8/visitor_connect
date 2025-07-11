import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/filter_sort_widget.dart';

import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/enum.dart';

import 'package:host_visitor_connect/common/res/colors.dart';

import 'package:host_visitor_connect/common/res/styles.dart';

import 'package:host_visitor_connect/common/utils/location.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/Filter/bloc/areaFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/cityFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/stateFilterBloc.dart';

import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_fragment.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_search.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_search_provider.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/Filter/ui/list_filter.dart';

import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  final bool? filterApplied;
  final Visitor? visitor;
  final int initialIndex;
  final bool? isFromReportScreen;
  final int? selectedIdx;
  final int? index;
  final int currentOpenedTab;
  final String searchedValue;
  final bool? clearSearchText;
  final SearchFilterState searchFilterState;

  const ReportScreen({
    super.key,
    this.clearSearchText,
    this.visitor,
    this.isFromReportScreen,
    this.selectedIdx,
    this.index,
    this.initialIndex = 0,
    this.searchedValue = '',
    this.filterApplied,
    this.currentOpenedTab = 0,
    required this.searchFilterState,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String _searchQuery = '';

  Position? currentPosition;
  bool? isLocationCorrect;

  @override
  void initState() {
    context.read<ReportListBloc>().isSort = false;
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  void _onSearch(String query) {
    _searchQuery = query;
    context
        .read<ReportListBloc>()
        .getReportList(pageNo: 0, searchTerms: _searchQuery);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>().state.getData();
    return Initializer(
      init: (context) {
        getCurrentLocation(location: (location) {
          currentPosition = location;
        }).then(
          (value) {
            if ((getLocationStatus(
                  currentLatitude: currentPosition?.latitude,
                  currentLongitude: currentPosition?.longitude,
                  targetLatitude: userDetails?.latitude,
                  targetLongitude: userDetails?.longitude,
                ) ??
                false)) {
              isLocationCorrect = true;
              setState(() {});
            } else {
              isLocationCorrect = false;
              setState(() {});
            }
          },
        );
      },
      child: Scaffold(
        appBar: CustomImageAppBar(
          // isFromReportScreen: true,
          title: 'Reported List',
          onSearch: _onSearch,
          searchHint: "Search by Name.",
          context: context,
          showSearchField: true,
        ),
        body: Column(
          children: [
            FilterSortWidget(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) {
                    return MultiProvider(
                      providers: [
                        BlocProvider.value(
                            value: context.read<CityFilterBloc>()),
                        BlocProvider.value(
                            value: context.read<AreaFilterBloc>()),
                        BlocProvider.value(
                            value: context.read<AgeValidationBloc>()),
                        BlocProvider.value(
                            value: context.read<ReportListBloc>()),
                        Provider<GlobalKey<FormBuilderState>>(
                            create: (_) => GlobalKey<FormBuilderState>()),
                        BlocProvider.value(
                            value: context.read<StateFilterBloc>()),
                        BlocProvider.value(
                            value: context.read<VisitorsGroupingBloc>()),

                        BlocProvider.value(
                            value: context.read<StateFilterBloc>()),
                        // providerFuntion(),
                        ChangeNotifierProvider(
                          create: (_) => FiltersModel(),
                        ),
                        BlocProvider.value(
                          value: context.read<ValidatorOnChanged>(),
                        ),
                      ],
                      child: ListFilter(
                        isFromReport: true,
                        searchFilterState: widget.searchFilterState,
                        currentTab: widget.currentOpenedTab,
                      ),
                    );
                  },
                );
              },
              onTapSort: () {
                context.read<ReportListBloc>().isSort =
                    !context.read<ReportListBloc>().isSort;
                context
                    .read<ReportListBloc>()
                    .getReportList(pageNo: 0, searchTerms: _searchQuery);
              },
            ),
            const Expanded(
              child: ReportFragment(),
            )
          ],
        ),
        floatingActionButton: (isLocationCorrect ?? false)
            ? IgnorePointer(
                ignoring: context.watch<ReportListBloc>().state is Progress,
                child: SizedBox(
                  width: sizeWidth(context) / 3.5,
                  height: sizeHeight(context) / 20,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: primary_color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Report',
                            style: AppStyle.bodyMedium(context).copyWith(
                              color: primary_text_color,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Adjust overflow behavior if needed
                          ),
                        ),
                        // Add spacing between text and icon
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15.sp,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        goToRoute(
                          const ReportDeathProvider(
                            child: ReportVisitorSearch(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
