import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/bloc/current_visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/check_out_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/swipable_visitor.dart';
import 'package:provider/provider.dart';

class VisitorsGroupListing extends StatefulWidget {
  final List<Room> rooms;
  final bool? isUsers;
  final FiltersModel? filtersModel;
  final bool? isFromCurrentVisitors;
  const VisitorsGroupListing({
    Key? key,
    required this.rooms,
    this.isUsers,
    this.filtersModel,
    this.isFromCurrentVisitors,
  }) : super(key: key);

  @override
  State<VisitorsGroupListing> createState() => descending();
}

class descending extends State<VisitorsGroupListing> {
  late VisitorsGroupingBloc _visitorsGroupingBloc;
  late ScrollController _visitorListScrollController;

  late CurrentVisitorsGroupingBloc _currentVisitorsGroupingBloc;
  late ScrollController _currentVisitorListScrollController;
  List<Room> rooms = [];

  void _listenToListScroll() {
    final scrollOffset = _visitorListScrollController.offset;
    final scrollPosition = _visitorListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _visitorsGroupingBloc.getNextPageOfRooms(
          filtersModel: widget.filtersModel,
        );
      }
    }
  }

  void _listenToListScrollCurrentVisitors() {
    final scrollOffset = _currentVisitorListScrollController.offset;
    final scrollPosition = _currentVisitorListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _currentVisitorsGroupingBloc.getNextPageOfRooms(
          filtersModel: widget.filtersModel,
        );
      }
    }
  }

  @override
  void initState() {
    sorting();
    if (widget.isFromCurrentVisitors ?? false) {
      _currentVisitorsGroupingBloc = context.read<CurrentVisitorsGroupingBloc>();
      _currentVisitorListScrollController = ScrollController();
      _currentVisitorListScrollController.addListener(_listenToListScrollCurrentVisitors);
    } else {
      _visitorsGroupingBloc = context.read<VisitorsGroupingBloc>();
      _visitorListScrollController = ScrollController();
      _visitorListScrollController.addListener(_listenToListScroll);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.isFromCurrentVisitors ?? false) {
      _currentVisitorListScrollController.removeListener(_listenToListScrollCurrentVisitors);
      _currentVisitorListScrollController.dispose();
    } else {
      _visitorListScrollController.removeListener(_listenToListScroll);
      _visitorListScrollController.dispose();
    }
    super.dispose();
  }

// sort accending decending only
  sorting() {
    if (!(widget.isFromCurrentVisitors ?? true)) {
      rooms = widget.rooms.toList();
    } else {
      rooms = widget.rooms.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('listViewKey'),
      controller: widget.isFromCurrentVisitors ?? false
          ? _currentVisitorListScrollController
          : _visitorListScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0),
      itemCount: rooms.length + 1,
      itemBuilder: (context, index) {
        if (index < rooms.length) {
          return MultiProvider(
            providers: [
              BlocProvider(
                create: (_) => OutgoingCallBloc(),
              ),
              BlocProvider(
                create: (_) => CheckOutBloc(),
              ),
              ChangeNotifierProvider.value(
                value: CheckOutVisitor(),
              ),
            ],
            child: SwiperBuilder(
              isFromCurrentVisitors: widget.isFromCurrentVisitors,
              // roomNo: rooms[index].roomNo,
              room: rooms[index],
            ),
          );
        } else {
          return _NextPageLoader(
            isFromCurrentVisitors: widget.isFromCurrentVisitors,
          );
        }
      },
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  final bool? isFromCurrentVisitors;

  const _NextPageLoader({
    this.isFromCurrentVisitors,
  });

  @override
  Widget build(BuildContext context) {
    final voterListingBloc = isFromCurrentVisitors ?? false
        ? context.read<CurrentVisitorsGroupingBloc>()
        : context.read<VisitorsGroupingBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: voterListingBloc.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
