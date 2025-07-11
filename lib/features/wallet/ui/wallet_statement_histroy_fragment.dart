import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_statement_history_builder.dart';

class WalletStatementHistoryFragment extends StatefulWidget {
  final String date;
  final int transactionType;
  final int hostId;

  const WalletStatementHistoryFragment({
    Key? key,
    required this.date,
    required this.transactionType,
    required this.hostId,
  }) : super(key: key);

  @override
  State<WalletStatementHistoryFragment> createState() =>
      WalletStatementHistoryFragmentState();
}

class WalletStatementHistoryFragmentState
    extends State<WalletStatementHistoryFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<WalletStatementHistoryBloc>().walletStatementHistoryListing(
          fromWallet: false,
          date: widget.date,
          transactionType: widget.transactionType,
          hostId: widget.hostId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => WalletStatementHistoryBloc(),
      child: WalletStatementHistoryBuilder(
        date: widget.date,
        transactionType: widget.transactionType,
        hostId: widget.hostId,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
