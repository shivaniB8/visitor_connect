import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/res/colors.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_search_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';

import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/list_item_visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:provider/provider.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class SearchedVisitorListing extends StatefulWidget {
  final List<Visitor> visitor;
  final String? searchTerm;

  final Function(Visitor)? selectedVisitorData;

  const SearchedVisitorListing({
    Key? key,
    required this.visitor,
    this.searchTerm,
    required this.selectedVisitorData,
  }) : super(key: key);

  @override
  State<SearchedVisitorListing> createState() => _SearchedVisitorListingState();
}

class _SearchedVisitorListingState extends State<SearchedVisitorListing> {
  late ReportVisitorSearchTermBloc _reportVisitorSearchTermBloc;
  late ScrollController _reportListScrollController;

  Visitor? selectedVisitor;
  int selectedIdx = -1;

  void _listenToListScroll() {
    final scrollOffset = _reportListScrollController.offset;
    final scrollPosition = _reportListScrollController.position;

    //checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _reportVisitorSearchTermBloc.getNextPageOfVoters(
          searchTerm: widget.searchTerm ?? '',
        );
      }
    }
  }

  @override
  void initState() {
    _reportVisitorSearchTermBloc = context.read<ReportVisitorSearchTermBloc>();
    _reportListScrollController = ScrollController();
    _reportListScrollController.addListener(_listenToListScroll);

    super.initState();
  }

  @override
  void dispose() {
    _reportListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        controller: _reportListScrollController,
        itemCount: widget.visitor.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.visitor.length) {
            return GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedIdx = index;
                    widget.selectedVisitorData?.call(widget.visitor[index]);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                child: MultiProvider(
                  providers: [
                    BlocProvider.value(value: context.read<OutgoingCallBloc>()),
                    ChangeNotifierProvider.value(
                      value: context.read<CheckOutVisitor>(),
                    ),
                  ],
                  child: ListItemVisitor(
                    isFromSearchVisitor: true,
                    isFromMainList: false,
                    selectedIdx: selectedIdx,
                    index: index,
                    isFromReportScreen: true,
                    visitor: widget.visitor[index],
                  ),
                ),
              ),
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
    final voterListingBloc = context.read<ReportVisitorSearchTermBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: voterListingBloc.state is Progress,
          child: const CircularProgressIndicator(
            color: primary_color,
          ),
        ),
      ),
    );
  }
}
