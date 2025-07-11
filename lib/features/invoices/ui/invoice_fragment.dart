import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';

import 'package:host_visitor_connect/features/invoices/bloc/invoices_bloc.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoices_builder.dart';

class InvoiceFragment extends StatefulWidget {
  const InvoiceFragment({super.key});

  @override
  State<InvoiceFragment> createState() => _InvoiceFragmentState();
}

class _InvoiceFragmentState extends State<InvoiceFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<InvoicesBloc>().getInvoiceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        title: 'Tax Invoices',
        context: context,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: InvoicesBuilder(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
