import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_history_listing.dart';

class WalletStatementBuilder extends StatelessWidget {
  final String? date;
  final int? transactionType;
  final int? hostId;
  const WalletStatementBuilder({
    this.date,
    this.transactionType,
    this.hostId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<HostAccountStatementBloc>()
            .getHostAccountStatementBloc(isRefreshingList: true);
        await context.read<HostAccountStatementBloc>().refreshCompleter.future;
      },
      child: BlocConsumer(
        bloc: context.read<HostAccountStatementBloc>(),
        listener: (context, UiState state) {
          if (state is Error) {
            CommonErrorHandler(
              context,
              exception: state.exception,
            ).showToast();
          }
        },
        builder: (_, UiState state) {
          final wallet = context.read<HostAccountStatementBloc>().wallet;

          return state.build(
            defaultState: () => wallet.isEmpty
                ? const BlankSlate(
                    key: Key('blankSlate'),
                    title: 'No Data Available',
                  )
                : WalletHistoryListing(
                    wallet: wallet,
                  ),

            //..
            loading: () => wallet.isEmpty
                ? const Center(
                    child: LoadingWidget(),
                  )
                : WalletHistoryListing(
                    wallet: wallet,
                  ),

            //..
            success: (_) => wallet.isEmpty
                ? const Center(
                    child: BlankSlate(
                      key: Key('blankSlate'),
                      title: 'No Data Available',
                    ),
                  )
                : BlocProvider.value(
                    value: WalletStatementHistoryBloc(),
                    child: WalletHistoryListing(
                      wallet: wallet,
                    ),
                  ),
            //..
            error: (_) => wallet.isEmpty
                ? const VoterListingErrorSlate(
                    key: Key('error'),
                  )
                : WalletHistoryListing(
                    wallet: wallet,
                  ),
          );
        },
      ),
    );
  }
}
