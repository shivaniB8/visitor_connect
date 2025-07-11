import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/error_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/ui/open_tickets_listing.dart';

class OpenTicketListingBuilder extends StatelessWidget {
  // final FiltersModel? filters;

  const OpenTicketListingBuilder({
    Key? key,
    // required this.filters,
    // this.doApiCall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OpenTicketBloc>().isfilterApplied = false;
        context.read<OpenTicketBloc>().getTickets(
              status: 2,
              isRefreshingList: true,
            );
        await context.read<OpenTicketBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<OpenTicketBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final tickets = context.read<OpenTicketBloc>().tickets;

          return state.build(
            defaultState: () => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : OpenTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            loading: () => tickets.isEmpty
                ? const Center(
                    child: LoadingWidget(),
                  )
                : OpenTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            success: (_) => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : OpenTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            error: (_) => tickets.isEmpty
                ? const ErrorSlate(
                    key: Key('error'),
                  )
                : OpenTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),
          );
        },
      ),
    );
  }
}
