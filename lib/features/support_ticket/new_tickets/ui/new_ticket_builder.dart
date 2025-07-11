import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/error_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/ui/new_ticket_listing.dart';

class NewTicketListingBuilder extends StatelessWidget {
  // final FiltersModel? filters;

  const NewTicketListingBuilder({
    Key? key,
    // required this.filters,
    // this.doApiCall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewTicketBloc>().isfilterApplied = false;
        context.read<NewTicketBloc>().getTickets(
              status: 1,
              isRefreshingList: true,
            );
        await context.read<NewTicketBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<NewTicketBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final tickets = context.read<NewTicketBloc>().tickets;

          return state.build(
            defaultState: () => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : NewTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            loading: () => tickets.isEmpty
                ? const Center(
                    child: LoadingWidget(),
                  )
                : NewTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            success: (_) => tickets.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : NewTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),

            //..
            error: (_) => tickets.isEmpty
                ? const ErrorSlate(
                    key: Key('error'),
                  )
                : NewTicketListing(
                    tickets: tickets,
                    // filters: filters,
                  ),
          );
        },
      ),
    );
  }
}
