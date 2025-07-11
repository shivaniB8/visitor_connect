import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:provider/provider.dart';

class WalletProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final HostAccountStatementBloc? walletListingBloc;
  final WalletStatementHistoryBloc? walletStatementHistoryBloc;

  const WalletProvider({
    Key? key,
    required this.child,
    this.init,
    this.walletListingBloc,
    this.walletStatementHistoryBloc,
  }) : super(key: key);

  HostAccountStatementBloc _getWalletListing(BuildContext context) {
    return walletListingBloc ?? HostAccountStatementBloc();
  }

  WalletStatementHistoryBloc _getWalletHistoryListing(BuildContext context) {
    return walletStatementHistoryBloc ?? WalletStatementHistoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getWalletListing),
        BlocProvider(create: _getWalletHistoryListing),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
