import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/error_slate.dart';
import 'package:host_visitor_connect/common/utils/common_error_handler.dart';
import 'package:host_visitor_connect/features/invoices/bloc/receipts_bloc.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_data.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';
import 'package:host_visitor_connect/features/invoices/ui/receipts/receipt_listing.dart';
import 'package:host_visitor_connect/features/invoices/ui/receipts/receipt_month_list.dart';

class ReceiptsBuilder extends StatelessWidget {
  const ReceiptsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.read<ReceiptsBloc>(),
      listener: (context, UiState state) {
        if (state is Error) {
          CommonErrorHandler(
            context,
            exception: state.exception,
          ).showToast();
        }
      },
      builder: (_, UiState state) {
        final List<ReceiptResponseData> receipts =
            context.read<ReceiptsBloc>().state.getData()?.data ?? [];

        return state.build(
          defaultState: () => receipts.isEmpty
              ? const BlankSlate(
                  key: Key('blankSlate'),
                  title: 'No Data Available',
                )
              : ReceiptListing(invoicesMonths: receipts),

          //..
          loading: () => receipts.isEmpty
              ? const Center(
                  child: LoadingWidget(),
                )
              : ReceiptListing(invoicesMonths: receipts),

          //..
          success: (_) => receipts.isEmpty
              ? const BlankSlate(
                  key: Key('blankSlate'),
                  title: 'No Data Available',
                )
              : ReceiptListing(invoicesMonths: receipts),

          //..
          error: (_) => (receipts.isEmpty) && state is Error
              ? const VoterListingErrorSlate(
                  key: Key('error'),
                )
              : ReceiptListing(invoicesMonths: receipts),
        );
      },
    );
  }
}
