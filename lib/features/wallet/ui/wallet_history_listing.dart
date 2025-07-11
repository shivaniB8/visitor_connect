import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_expansion_tile.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/wallet_filters_model.dart';

class WalletHistoryListing extends StatefulWidget {
  final bool? isFromHistory;
  final List<Wallet>? wallet;
  final String? date;
  final int? transactionType;
  final int? hostId;

  const WalletHistoryListing({
    Key? key,
    this.wallet,
    this.isFromHistory,
    this.date,
    this.transactionType,
    this.hostId,
  }) : super(key: key);

  @override
  State<WalletHistoryListing> createState() => _WalletHistoryListingState();
}

class _WalletHistoryListingState extends State<WalletHistoryListing> {
  late HostAccountStatementBloc _hostAccountStatementBloc;
  late ScrollController _walletListScrollController;

  late ScrollController _walletHistoryController;
  late WalletStatementHistoryBloc _walletStatementHistoryBloc;
  late final AppExpansionTileController _tileController;
  int? indexExpanded;

  void _listenToListScroll() {
    final scrollOffset = _walletListScrollController.offset;
    final scrollPosition = _walletListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _hostAccountStatementBloc.getNextPageOfWalletStatement();
      }
    }
  }

  void _listenToListScrollHistory() {
    final scrollOffset = _walletHistoryController.offset;
    final scrollPosition = _walletHistoryController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        _walletStatementHistoryBloc.getNextPageOfWalletStatementHistory(
          fromWallet: false,
          date: widget.date ?? '',
          transactionType: widget.transactionType ?? 0,
          hostId: widget.hostId ?? 0,
        );
      }
    }
  }

  int monthNameToNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'january':
        return 1;
      case 'february':
        return 2;
      case 'march':
        return 3;
      case 'april':
        return 4;
      case 'may':
        return 5;
      case 'june':
        return 6;
      case 'july':
        return 7;
      case 'august':
        return 8;
      case 'september':
        return 9;
      case 'october':
        return 10;
      case 'november':
        return 11;
      case 'december':
        return 12;
      default:
        return 1; // Default to January if month name is unrecognized
    }
  }

  @override
  void initState() {
    _tileController = AppExpansionTileController();
    if (widget.isFromHistory ?? false) {
      _walletStatementHistoryBloc = context.read<WalletStatementHistoryBloc>();
      _walletHistoryController = ScrollController();
      _walletHistoryController.addListener(_listenToListScrollHistory);
    } else {
      _hostAccountStatementBloc = context.read<HostAccountStatementBloc>();
      _walletListScrollController = ScrollController();
      _walletListScrollController.addListener(_listenToListScroll);
    }
    // getWalletLength();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.isFromHistory ?? false) {
      _walletHistoryController.dispose();
    } else {
      _walletListScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black12)),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                    child: Row(
                      children: [
                        _tableHeader("Date"),
                        _tableHeader("Debit\n(₹)", color: Colors.red),
                        _tableHeader("Credit\n(₹)", color: Colors.green),
                        _tableHeader("Total\n(₹)"),
                      ],
                    ),
                  ),
                  ...List.generate(
                    widget.wallet?.length ?? 0,
                    (idx) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (indexExpanded == idx) {
                                  indexExpanded = null;
                                } else {
                                  indexExpanded = idx;
                                }
                              });

                              if (indexExpanded == idx) {
                                /// Hit the API: getCreditOrDebit
                                context
                                    .read<WalletStatementHistoryBloc>()
                                    .walletStatementHistoryListing(
                                      fromWallet: false,
                                      date: widget.wallet?[idx].debitDate ??
                                          widget.wallet?[idx].creditDate ??
                                          "",
                                      transactionType: widget.wallet?[idx].transactionType ?? 0,
                                      hostId: widget.wallet?[idx].hostId ?? 0,
                                    );
                              }
                            },
                            child: Row(
                              children: [
                                _tableContent(_getDayNMonth(widget.wallet?[idx].debitDate ??
                                    widget.wallet?[idx].creditDate ??
                                    "N/A")),
                                _tableContent(widget.wallet?[idx].debitAmount ?? "0",
                                    color: Colors.red),
                                _tableContent(widget.wallet?[idx].creditAmount,
                                    color: Colors.green),
                                _tableContent(
                                  widget.wallet?[idx].balanceAmount,
                                  rightSideWidget: Icon(
                                    CupertinoIcons.arrow_right_square_fill,
                                    size: appSize(context: context, unit: 10) / 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (idx == indexExpanded) // && if subList is not empty && not null
                            _getCreditOrDebitTransactionsList()
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getCreditOrDebitTransactionsList() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(color: Colors.black12),
        child: BlocConsumer(
          bloc: context.read<WalletStatementHistoryBloc>(),
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Progress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Success) {
              return Column(
                children: context.read<WalletStatementHistoryBloc>().state.getData()?.isNotEmpty ??
                        false
                    ? List.generate(
                        context.read<WalletStatementHistoryBloc>().state.getData()?.length ?? 0,
                        // (widget.wallet?.values.toList()[index].length ?? 0),
                        (idx) {
                          return context
                                      .read<WalletStatementHistoryBloc>()
                                      .state
                                      .getData()
                                      ?.isNotEmpty ??
                                  false
                              ? _expandedListTile(
                                  context.read<WalletStatementHistoryBloc>().state.getData()![idx])
                              : const BlankSlate(title: 'No Data Found');
                        },
                      )
                    : [
                        const SizedBox(
                          height: 80,
                          child: BlankSlate(title: 'No Data Found'),
                        ),
                      ],
              );
            } else {
              return const SizedBox(
                height: 50,
                child: BlankSlate(title: 'No Data Found'),
              );
            }
          },
        ),
      );

  String _getDayNMonth(String? date) {
    log("DATE; ${date == "N/A"}");
    if (date != "N/A") {
      String day = date?.split("-").last ?? "";
      String monthInWord =
          getMonthInWord(int.tryParse(date?.split("-")[1] ?? "0") ?? 0, inFullWords: false);
      return "$day $monthInWord";
    }
    return "N/A";
  }

  _tableHeader(text, {Color? color}) => Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(text,
                textAlign: TextAlign.center,
                style: AppStyle.bodySmall(context).copyWith(
                    color: color ?? Colors.black,
                    fontSize: appSize(context: context, unit: 10) / 16,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      );

  _tableContent(text, {Color? color, Widget? rightSideWidget}) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text.toString(),
                  textAlign: TextAlign.center,
                  style: AppStyle.bodySmall(context).copyWith(
                      color: color ?? Colors.black,
                      fontSize: appSize(context: context, unit: 10) / 18)),
              if (rightSideWidget != null) const SizedBox(width: 4),
              rightSideWidget ?? const SizedBox.shrink()
            ],
          ),
        ),
      );

  _expandedListTile(Wallet wallet) => SizedBox(
        child: ListTile(
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          leading: Text(wallet.debitTime ?? wallet.creditTime ?? ""),
          trailing: Text(wallet.debitAmount != null && wallet.debitAmount != 0
              ? "₹ ${wallet.debitAmount}"
              : wallet.creditAmount != null && wallet.creditAmount != 0
                  ? "₹ ${wallet.creditAmount}"
                  : ""),
          title: Text(capitalizedString((() {
            final words = wallet.heading?.toLowerCase().split(" ") ?? [];

            // Ensure we have enough words to extract the range
            const start = 2;
            const end = 8;
            if (words.length > start) {
              // Ensure end index is within range
              final validEnd = end > words.length ? words.length : end;
              return words.getRange(start, validEnd).join(" ");
            } else {
              return ""; // Return empty string if not enough words
            }
          })()),
              style: AppStyle.labelSmall(context)
                  .copyWith(fontSize: appSize(context: context, unit: 10) / 20)),
        ),
      );

  _tableSubContent(text, {Color? color, Widget? rightSideWidget}) => Expanded(
        child: Container(
          color: Colors.black26,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text.toString(),
                  textAlign: TextAlign.center,
                  style: AppStyle.bodySmall(context).copyWith(
                      color: color ?? Colors.black,
                      fontSize: appSize(context: context, unit: 10) / 18)),
              if (rightSideWidget != null) const SizedBox(width: 4),
              rightSideWidget ?? const SizedBox.shrink()
            ],
          ),
        ),
      );

  _pdfView(url) => TableCell(
          child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("View",
                  style: AppStyle.bodySmall(context)
                      .copyWith(fontSize: appSize(context: context, unit: 10) / 18)),
              Icon(CupertinoIcons.arrow_up_right_square_fill,
                  size: appSize(context: context, unit: 10) / 14)
            ],
          ),
        ),
      ));

  _launchURL(url) async {
    // const url = 'https://flutter.dev/exapmle.pdf';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  final bool? isFromHistory;
  WalletStatementHistoryBloc? walletHistoryBloc;
  HostAccountStatementBloc? hostAccountStatementBloc;

  _NextPageLoader({
    Key? key,
    this.isFromHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFromHistory ?? false) {
      walletHistoryBloc = context.read<WalletStatementHistoryBloc>();
    } else {
      hostAccountStatementBloc = context.read<HostAccountStatementBloc>();
    }

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: isFromHistory ?? false
              ? walletHistoryBloc?.state is Progress
              : hostAccountStatementBloc?.state is Progress,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}

// ...List.generate(
//     (widget.wallet?.values
//             .toList()[index]
//             .length ??
//         0), (idx) {
//   // print(
//   //     "pdf >> $googlePhotoUrl${getBucketName()}$invoicesFolder${getHostFolder(widget.invoicesMonths?.values.toList()[index][idx].hostFk)}${widget.invoicesMonths?.values.toList()[index][idx].fileName}.pdf");
//   return TableRow(children: [
//     _tableContent(
//         "${widget.invoicesMonths?.values.toList()[index][idx].invoiceDate?.split("-").last} ${getMonthInWord(int.tryParse(widget.invoicesMonths?.values.toList()[index][idx].invoiceDate?.split("-")[1] ?? "") ?? 0)}"),
//     _tableContent(widget.invoicesMonths?.values
//             .toList()[index][idx]
//             .amountBeforeTax ??
//         ""),
//     _tableContent(widget.invoicesMonths?.values
//             .toList()[index][idx]
//             .taxAmount ??
//         ""),
//     _tableContent(widget.invoicesMonths?.values
//             .toList()[index][idx]
//             .totalAmount ??
//         ""),
//     _pdfView(widget.invoicesMonths?.values
//         .toList()[index][idx]
//         .fileLink)
//
//     // "$googlePhotoUrl${getBucketName()}$hostFolder${getHostFolder(widget.invoicesMonths?.values.toList()[index][idx].hostFk)}${widget.invoicesMonths?.values.toList()[index][idx].fileName}")
//   ]);
// }),
