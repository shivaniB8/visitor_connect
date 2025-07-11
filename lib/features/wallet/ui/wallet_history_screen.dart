import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_statement_histroy_fragment.dart';

class WalletHistoryScreen extends StatefulWidget {
  final String date;
  final int transactionType;
  final int hostId;
  const WalletHistoryScreen({
    super.key,
    required this.date,
    required this.transactionType,
    required this.hostId,
  });

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        context: context,
        title: 'Wallet History',
        showEditIcon: false,
        showSettings: false,
      ),
      body: WalletStatementHistoryFragment(
        date: widget.date,
        transactionType: widget.transactionType,
        hostId: widget.hostId,
      ),
    );
  }
}
