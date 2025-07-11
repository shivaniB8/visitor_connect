import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/error_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/ticket_history_listing.dart';

class TicketHistoryBuilder extends StatelessWidget {
  // final FiltersModel? filters;
  final ScrollController scrollController;

  const TicketHistoryBuilder({
    Key? key,
    required this.scrollController,
    // required this.filters,
    // this.doApiCall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<TicketHistoryBloc>(),
      listener: (context, UiState state) {
        if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        return state.build(
          defaultState: () => const BlankSlate(
            key: Key('blankSlate'),
            title: 'No Data Available',
          ),

          //..
          loading: () => const SizedBox(
            height: 100,
            child: Center(
              child: LoadingWidget(),
            ),
          ),

          //..
          success: (_) => TicketHistoryListing(
            scrollController: scrollController,
            ticketHistory: context.read<TicketHistoryBloc>().state.getData(),
          ),

          //..
          error: (_) => const ErrorSlate(
            key: Key('error'),
          ),
        );
      },
    );
  }
}
