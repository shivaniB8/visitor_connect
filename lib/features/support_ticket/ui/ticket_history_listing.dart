import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_history_response.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/list_item_ticket_history.dart';

class TicketHistoryListing extends StatefulWidget {
  final TicketHistoryResponse? ticketHistory;

  final ScrollController scrollController;
  final Function? onScroll;

  // final WalletFiltersModel? walletFiltersModel;
  const TicketHistoryListing({
    Key? key,
    this.ticketHistory,
    required this.scrollController, this.onScroll,
    // this.wallet,
    // this.walletFiltersModel,
  }) : super(key: key);

  @override
  State<TicketHistoryListing> createState() => _TicketHistoryListingState();
}

class _TicketHistoryListingState extends State<TicketHistoryListing> {
  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      ("maxx > ${widget.scrollController.position.maxScrollExtent}");
    });
    _scrollController2.addListener(() {
      if(_scrollController2.position.hasContentDimensions){
        ("maxx > ${widget.scrollController.position.maxScrollExtent}");
      }
      // print("maxScrollExtent > ${_scrollController2.position.maxScrollExtent}");
      // print("maxScrollExtent offset > ${_scrollController2.position.}");
    });
    // widget.scrollController.addListener(_syncScroll);
    // _scrollController2.addListener(_syncScroll);
  }

  void _syncScroll() {
    if (widget.scrollController.position.hasContentDimensions &&
        _scrollController2.position.hasContentDimensions) {
      if (widget.scrollController.offset != _scrollController2.offset) {
        if (widget.scrollController.position.userScrollDirection ==
            ScrollDirection.idle) {
          widget.scrollController.jumpTo(_scrollController2.offset);
        } else if (_scrollController2.position.userScrollDirection ==
            ScrollDirection.idle) {
          _scrollController2.jumpTo(widget.scrollController.offset);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TicketMessages>? ticketMessageList =
        widget.ticketHistory?.data?.ticketMessages?.reversed.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
      child: ListView.builder(
        controller: _scrollController2,
        reverse: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 8),
        itemCount: (ticketMessageList?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          if (index < (ticketMessageList?.length ?? 0)) {
            return ListItemTicketHistory(
              ticketHistoryResponse: ticketMessageList?[index],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
