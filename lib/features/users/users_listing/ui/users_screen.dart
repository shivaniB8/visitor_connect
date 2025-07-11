import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/filter_sort_widget.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/user_listing_fragment.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users_filter_widget.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users_provider.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

class UsersScreen extends StatefulWidget {
  final FiltersModel? filterModel;
  final bool? filterApplied;
  final int initialIndex;
  final String searchedValue;
  final bool? clearSearchText;
  const UsersScreen({
    super.key,
    this.clearSearchText,
    this.filterModel,
    this.initialIndex = 0,
    this.searchedValue = '',
    this.filterApplied,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
  }

  void _onSearch(String query) {
    _searchQuery = query;
    context
        .read<UsersListingBloc>()
        .getUsersListing(filters: FiltersModel(searchTerm: _searchQuery));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Users List',
        onSearch: _onSearch,
        searchHint: "Search by Name.",
        context: context,
        showSearchField: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
          child: Column(
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
                      return BlocProvider.value(
                        value: context.read<UsersListingBloc>(),
                        child: const UserFilter(),
                      );
                    },
                  );
                },
              ),
              const Expanded(
                child: UsersProvider(
                  child: UserListingFragment(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
