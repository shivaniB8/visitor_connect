import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/swipable_visitor.dart';
import 'package:provider/provider.dart';

class RentedListing extends StatefulWidget {
  final List<Room> rooms;
  const RentedListing({super.key, required this.rooms});

  @override
  State<RentedListing> createState() => _RentedListingState();
}

class _RentedListingState extends State<RentedListing> {
  late RentedListingBloc _rentedListingBloc;
  late ScrollController _rentedListScrollController;

  void _listenToListScrollRent() {
    final scrollOffset = _rentedListScrollController.offset;
    final scrollPosition = _rentedListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _rentedListingBloc.getNextPageOfRooms(
            // filtersModel: widget.filtersModel,
            );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _rentedListingBloc = context.read<RentedListingBloc>();
    _rentedListScrollController = ScrollController();
    _rentedListScrollController.addListener(_listenToListScrollRent);
  }

  @override
  void dispose() {
    _rentedListScrollController.removeListener(_listenToListScrollRent);
    _rentedListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('listViewKey'),
      controller: _rentedListScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      itemCount: widget.rooms.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.rooms.length) {
          return MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => OutgoingCallBloc(),
              ),
              BlocProvider(
                create: (_) => CheckOutBloc(),
              ),
              ChangeNotifierProvider.value(
                value: context.read<CheckOutVisitor>(),
              ),
            ],
            child: SwiperBuilder(
              businessType: "Car/Bike No",
              room: widget.rooms[index],
            ),
          );
        } else {
          return _NextPageLoader();
        }
      },
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rentedListingBloc = context.read<RentedListingBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: rentedListingBloc.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
