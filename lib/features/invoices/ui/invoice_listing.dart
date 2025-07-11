import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_expansion_tile.dart';
import 'package:host_visitor_connect/common/custom_widget/permission_card.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoice_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/network/responses/invoices_list_response.dart';

class InvoiceListing extends StatefulWidget {
  final InvoicesListResponse? invoicesListResponse;
  final Map<String, List<InvoiceData>>? invoicesMonths;

  const InvoiceListing({
    super.key,
    this.invoicesListResponse,
    this.invoicesMonths,
  });

  @override
  State<InvoiceListing> createState() => _InvoiceListingState();
}

class _InvoiceListingState extends State<InvoiceListing> {
  late ScrollController _invoiceListScrollController;
  late final AppExpansionTileController _tileController;

  @override
  void initState() {
    _invoiceListScrollController = ScrollController();
    _tileController = AppExpansionTileController();
    super.initState();
  }

  @override
  void dispose() {
    _invoiceListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.invoicesMonths?.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < (widget.invoicesMonths?.length ?? 0)) {
          return Column(
            children: [
              PermissionsCard(
                isFromMenu: index == 0 ? true : false,
                title:
                    "${widget.invoicesMonths?.keys.toList()[index] ?? ''} ${widget.invoicesMonths?.values.toList()[index].first.invoiceDate?.split('-')[0]}",
                tileController: _tileController,
                child: SizedBox(
                  child: Table(
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(3)),
                          children: [
                            _tableHeader("Date"),
                            _tableHeader("Actual\n(₹)"),
                            _tableHeader("TAX\n(₹)"),
                            _tableHeader("Total\n(₹)"),
                            _tableHeader("Invoice"),
                          ]),
                      ...List.generate(
                          (widget.invoicesMonths?.values
                                  .toList()[index]
                                  .length ??
                              0), (idx) {
                        // print(
                        //     "pdf >> $googlePhotoUrl${getBucketName()}$invoicesFolder${getHostFolder(widget.invoicesMonths?.values.toList()[index][idx].hostFk)}${widget.invoicesMonths?.values.toList()[index][idx].fileName}.pdf");
                        return TableRow(children: [
                          _tableContent(
                              "${widget.invoicesMonths?.values.toList()[index][idx].invoiceDate?.split("-").last} ${getMonthInWord(int.tryParse(widget.invoicesMonths?.values.toList()[index][idx].invoiceDate?.split("-")[1] ?? "") ?? 0)}"),
                          _tableContent(widget.invoicesMonths?.values
                                  .toList()[index][idx]
                                  .amountBeforeTax ??
                              ""),
                          _tableContent(widget.invoicesMonths?.values
                                  .toList()[index][idx]
                                  .taxAmount ??
                              ""),
                          _tableContent(widget.invoicesMonths?.values
                                  .toList()[index][idx]
                                  .totalAmount ??
                              ""),
                          _pdfView(widget.invoicesMonths?.values
                              .toList()[index][idx]
                              .fileLink)

                          // "$googlePhotoUrl${getBucketName()}$hostFolder${getHostFolder(widget.invoicesMonths?.values.toList()[index][idx].hostFk)}${widget.invoicesMonths?.values.toList()[index][idx].fileName}")
                        ]);
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _tableHeader(text) => TableCell(
          // verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(text,
            textAlign: TextAlign.center,
            style: AppStyle.bodySmall(context).copyWith(
                fontSize: appSize(context: context, unit: 10) / 16,
                fontWeight: FontWeight.w600)),
      ));

  _tableContent(text) => TableCell(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(text.toString(),
            textAlign: TextAlign.center,
            style: AppStyle.bodySmall(context)
                .copyWith(fontSize: appSize(context: context, unit: 10) / 18)),
      ));

  _pdfView(url) => TableCell(
          child: GestureDetector(
        onTap: () => _launchURL(url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("View",
                  style: AppStyle.bodySmall(context).copyWith(
                      fontSize: appSize(context: context, unit: 10) / 18)),
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
