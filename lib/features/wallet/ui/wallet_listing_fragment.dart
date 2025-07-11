import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_statement_builder.dart';

class WalletListingFragment extends StatefulWidget {
  const WalletListingFragment({Key? key}) : super(key: key);

  @override
  State<WalletListingFragment> createState() => WalletListingFragmentState();
}

class WalletListingFragmentState extends State<WalletListingFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<HostAccountStatementBloc>().getHostAccountStatementBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const WalletStatementBuilder();
  }

  @override
  bool get wantKeepAlive => true;
}
