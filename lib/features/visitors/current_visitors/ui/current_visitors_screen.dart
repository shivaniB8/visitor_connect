import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/filter_sort_widget.dart';
import 'package:host_visitor_connect/common/enum.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/Filter/bloc/areaFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/cityFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/stateFilterBloc.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/ui/rented_listing_fragment.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/bloc/current_visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/ui/current_visitors_fragment.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/Filter/ui/list_filter.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:provider/provider.dart';

class CurrentVisitorsScreen extends StatefulWidget {
  final FiltersModel? filterModel;
  final bool? filterApplied;
  final int initialIndex;
  final String searchedValue;
  final bool? clearSearchText;
  final int? visitors;
  final SearchFilterState searchFilterState;
  final int currentOpenedTab;

  const CurrentVisitorsScreen({
    super.key,
    this.clearSearchText,
    this.filterModel,
    this.initialIndex = 0,
    this.searchedValue = '',
    this.filterApplied,
    this.visitors,
    this.currentOpenedTab = 0,
    required this.searchFilterState,
  });

  @override
  State<CurrentVisitorsScreen> createState() => _CurrentVisitorsScreenState();
}

class _CurrentVisitorsScreenState extends State<CurrentVisitorsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _isSelected = "guest";
  String? businessType;
  int orderBy = 0;
  UniqueKey appBarKey = UniqueKey();

  @override
  void initState() {
    // context.read<CurrentVisitorsGroupingBloc>().isSort = false;
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _isSelected = tabController.index == 0 ? "guest" : "rentals";
      });
    });
    String? jsonString = SharedPrefs.getString(keyUserData);
    if (jsonString != null) {
      Map<String, dynamic> userData = jsonDecode(jsonString);
      businessType = userData['business_type'];
      if (businessType == "1") {
        _isSelected = "guest";
      } else if (businessType == "2") {
        _isSelected = "rentals";
      } else {
        _isSelected = "guest";
      }
    }
    super.initState();
  }

  void _onSearch(String query) {
    _searchQuery = query;
    if (_isSelected == "guest") {
      context.read<CurrentVisitorsGroupingBloc>().currentVisitorsGrouping(
            pageNo: 0,
            searchTerms: _searchQuery,
          );
    } else {
      context.read<RentedListingBloc>().rentedListing(
            pageNo: 0,
            searchTerms: _searchQuery,
          );
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        key: appBarKey,
        title: 'Current Visitors List',
        context: context,
        searchHint: "Search by Name.",
        onSearch: _onSearch,
        showSearchField: true,
        showEditIcon: false,
        showSettings: false,
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
                        value: context.read<AgeValidationBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<StateFilterBloc>(),
                      ),
                      BlocProvider.value(value: context.read<CityFilterBloc>()),
                      BlocProvider.value(value: context.read<AreaFilterBloc>()),

                      Provider<GlobalKey<FormBuilderState>>(
                        create: (_) => GlobalKey<FormBuilderState>(),
                      ),
                      ChangeNotifierProvider(
                        create: (_) => FiltersModel(),
                      ),
                      BlocProvider.value(
                        value: context.read<VisitorsGroupingBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<CurrentVisitorsGroupingBloc>(),
                      ),
                      BlocProvider.value(
                        value: context.read<ValidatorOnChanged>(),
                      ),
                      BlocProvider.value(
                        value: context.read<RentedListingBloc>(),
                      ),
                      // providerFuntion(),
                    ],
                    child: ListFilter(
                      isFromCurrentVisitor: _isSelected == 'guest' ? true : false,
                      isFromRent: _isSelected == 'rentals' ? true : false,
                      searchFilterState: widget.searchFilterState,
                      currentTab: widget.currentOpenedTab,
                    ),
                  );
                },
              );
            },
            onTapSort: () {
              if (orderBy == 0) {
                orderBy = 1;
              } else {
                orderBy = 0;
              }
              if (_isSelected == "guest") {
                context.read<CurrentVisitorsGroupingBloc>().currentVisitorsGrouping(
                    pageNo: 0, searchTerms: _searchQuery, orderBy: orderBy);
              } else {
                context
                    .read<RentedListingBloc>()
                    .rentedListing(pageNo: 0, searchTerms: _searchQuery, orderBy: orderBy);
              }
            },
          ),
          if (businessType == "1,2")
            IgnorePointer(
              ignoring: context.watch<CurrentVisitorsGroupingBloc>().state is Progress ||
                  context.watch<RentedListingBloc>().state is Progress,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: background_dark_grey),
                ),
                child: Row(
                  children: [
                    _tabbarBoxWidget(
                      sizeHeight(context) / 20,
                      "Visitors List",
                      _isSelected == "guest" ? Colors.white : Colors.black,
                      _isSelected == "guest" ? buttonColor : Colors.transparent,
                      0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 2,
                      color: background_dark_grey,
                      height: sizeHeight(context) / 30,
                    ),
                    _tabbarBoxWidget(
                      sizeHeight(context) / 20,
                      "Rented Car/ Bikes",
                      _isSelected == "rentals" ? Colors.white : Colors.black,
                      _isSelected == "rentals" ? buttonColor : Colors.transparent,
                      1,
                    ),
                  ],
                ),
              ),
            ),
          if (businessType == "1,2")
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MultiProvider(
                    providers: [
                      Provider<GlobalKey<FormBuilderState>>(
                        create: (_) => GlobalKey<FormBuilderState>(),
                      ),
                    ],
                    child: CurrentVisitorListingFragment(
                      filtersModel: widget.filterModel,
                    ),
                  ),
                  RentedListingFragment(
                    filtersModel: widget.filterModel,
                  ),
                ],
              ),
            ),
          if (businessType == "1")
            Expanded(
              child: MultiProvider(
                providers: [
                  Provider<GlobalKey<FormBuilderState>>(
                    create: (_) => GlobalKey<FormBuilderState>(),
                  ),
                ],
                child: CurrentVisitorListingFragment(
                  filtersModel: widget.filterModel,
                ),
              ),
            ),
          if (businessType == "2")
            Expanded(
              child: RentedListingFragment(
                filtersModel: widget.filterModel,
              ),
            ),
        ],
      ),
    );
  }

  Widget _tabbarBoxWidget(double size, String text, Color textColor, Color bgColor, int tabIndex) {
    return Expanded(
      child: Hero(
        tag: text,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = tabIndex == 0 ? "guest" : "rentals";
              tabController.index = tabIndex;
              _searchController.text = '';
              _searchQuery = '';
              appBarKey = UniqueKey();
            });
          },
          child: Container(
            alignment: Alignment.center,
            key: Key(text),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: size / 10),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(22)),
            child: Text(
              text,
              style: AppStyle.titleMedium(context)
                  .copyWith(color: textColor, fontSize: sizeHeight(context) / 55),
            ),
          ),
        ),
      ),
    );
  }
}
