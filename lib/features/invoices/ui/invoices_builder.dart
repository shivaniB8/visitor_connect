import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/invoices/bloc/invoices_bloc.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoice_data.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoice_listing.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoice_month_list.dart';
import '../../../../common/blocs/state_events/ui_state.dart';

class InvoicesBuilder extends StatelessWidget {
  const InvoicesBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<InvoicesBloc>(),
      listener: (context, UiState state) {
        if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        final invoices = context.read<InvoicesBloc>().state.getData()?.data;
        final Map<String, List<InvoiceData>>? invoiceMonths =
            getInvoicesAsPerMonth(invoices);
        return state.build(
          defaultState: () => invoiceMonths?.isEmpty ?? false
              ? const BlankSlate(
                  key: Key('blankSlate'),
                  title: 'No Data Available',
                )
              : InvoiceListing(
                  invoicesMonths: invoiceMonths,
                  invoicesListResponse: invoices,
                ),

          //..
          loading: () => invoiceMonths?.isEmpty ?? false
              ? const Center(
                  child: LoadingWidget(),
                )
              : InvoiceListing(
                  invoicesMonths: invoiceMonths,
                  invoicesListResponse: invoices,
                ),

          //..
          success: (_) => invoiceMonths?.isEmpty ?? false
              ? const BlankSlate(
                  key: Key('blankSlate'),
                  title: 'No Data Available',
                )
              : InvoiceListing(
                  invoicesMonths: invoiceMonths,
                  invoicesListResponse: invoices,
                ),

          //..
          error: (_) => (invoiceMonths?.isEmpty ?? false) && state is Error
              ? const VoterListingErrorSlate(
                  key: Key('error'),
                )
              : InvoiceListing(
                  invoicesMonths: invoiceMonths,
                  invoicesListResponse: invoices,
                ),
        );
      },
    );
  }
}
