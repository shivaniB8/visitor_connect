import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/error_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/bloc/closed_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/ui/closed_tickets_listing.dart';

class ClosedTicketListingBuilder extends StatelessWidget {
  // final FiltersModel? filters;

  const ClosedTicketListingBuilder({
    Key? key,
    // required this.filters,
    // this.doApiCall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ClosedTicketBloc>().isfilterApplied = false;
        context.read<ClosedTicketBloc>().getTickets(
              status: 3,
              isRefreshingList: true,
            );
        await context.read<ClosedTicketBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<ClosedTicketBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final tickets = context.read<ClosedTicketBloc>().tickets;

          return state.build(
            defaultState: () => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ClosedTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            loading: () => tickets.isEmpty
                ? const Center(
                    child: LoadingWidget(),
                  )
                : ClosedTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            success: (_) => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : ClosedTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            error: (_) => tickets.isEmpty
                ? const ErrorSlate(
                    key: Key('error'),
                  )
                : ClosedTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),
          );
        },
      ),
    );
  }
}
