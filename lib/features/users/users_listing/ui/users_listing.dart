import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/user_details_screen.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/list_item_user.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/user.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:provider/provider.dart';

class UsersListing extends StatefulWidget {
  final List<User> users;
  final bool? isUsers;
  const UsersListing({
    Key? key,
    required this.users,
    this.isUsers,
  }) : super(key: key);

  @override
  State<UsersListing> createState() => _UsersListingState();
}

class _UsersListingState extends State<UsersListing> {
  late UsersListingBloc _usersListingBloc;
  late ScrollController _userListScrollController;

  void _listenToListScroll() {
    final scrollOffset = _userListScrollController.offset;
    final scrollPosition = _userListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _usersListingBloc.getNextPageOfUsers();
      }
    }
  }

  @override
  void initState() {
    _usersListingBloc = context.read<UsersListingBloc>();
    _userListScrollController = ScrollController();
    _userListScrollController.addListener(_listenToListScroll);

    super.initState();
  }

  @override
  void dispose() {
    _userListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        controller: _userListScrollController,
        itemCount: widget.users.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.users.length) {
            return GestureDetector(
              child: MultiProvider(
                providers: [
                  BlocProvider(
                    create: (context) => OutgoingCallBloc(),
                  ),
                  BlocProvider(
                    create: (_) => CheckOutBloc(),
                  ),
                ],
                child: ListItemUser(
                  user: widget.users[index],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  goToRoute(
                    UserDetailsScreen(
                      user: widget.users[index],
                    ),
                  ),
                );
              },
            );
          } else {
            return _NextPageLoader();
          }
        },
      ),
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userListingBloc = context.read<UsersListingBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: userListingBloc.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
