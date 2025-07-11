import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';

import 'package:host_visitor_connect/features/invoices/bloc/invoices_bloc.dart';
import 'package:host_visitor_connect/features/invoices/bloc/receipts_bloc.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoices_builder.dart';
import 'package:host_visitor_connect/features/invoices/ui/receipts/receipts_builder.dart';

class ReceiptFragment extends StatefulWidget {
  const ReceiptFragment({super.key});

  @override
  State<ReceiptFragment> createState() => _ReceiptFragmentState();
}

class _ReceiptFragmentState extends State<ReceiptFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<ReceiptsBloc>().getReceiptList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        title: 'Receipts',
        context: context,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: ReceiptsBuilder(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
