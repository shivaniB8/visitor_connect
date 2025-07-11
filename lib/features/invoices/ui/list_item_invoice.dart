import 'dart:async';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/files_download_progress_dialog.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoice_data.dart';

class ListItemInvoice extends StatefulWidget {
  final InvoiceData? invoiceData;
  const ListItemInvoice({
    super.key,
    this.invoiceData,
  });

  @override
  State<ListItemInvoice> createState() => _ListItemInvoiceState();
}

class _ListItemInvoiceState extends State<ListItemInvoice> {
  Future<void> _openDocument(
    BuildContext context,
  ) async {
    final remotePdfPath =
        '$googlePhotoUrl${getBucketName()}$invoicesFolder${getHostFolder(widget.invoiceData?.hostFk)}${widget.invoiceData?.fileName}.pdf';
    if (widget.invoiceData?.fileName?.isNotEmpty ?? false) {
      final fileInfo =
          await FilesCacheManager.instance.getFileFromCache(remotePdfPath);

      if (fileInfo != null) {
        // ignore: use_build_context_synchronously
        openFile(context, fileInfo.file.path);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (_) => FilesDownloadProgressDialog(
            downloadStream: _getDocumentDownloadStream(remotePdfPath),
            onComplete: (filePath) {
              openFile(context, filePath);
            },
          ),
        );
      }
    }
  }

  Stream _getDocumentDownloadStream(String path) {
    return FilesCacheManager.instance.getFileStream(
      path,
      key: path,
      withProgress: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizedString(
                          widget.invoiceData?.clientFkValue ?? ''),
                      style: text_style_title7,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: 'Date', style: text_style_para1),
                          const TextSpan(text: ': ', style: text_style_para1),
                          TextSpan(
                            text: widget.invoiceData?.invoiceDate,
                            style: text_style_title12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Invoice Amount', style: text_style_para1),
                          const TextSpan(text: ': ', style: text_style_para1),
                          TextSpan(
                            text: '${widget.invoiceData?.amountBeforeTax} Rs',
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Tax Amount', style: text_style_para1),
                          const TextSpan(text: ': ', style: text_style_para1),
                          TextSpan(
                            text: '${widget.invoiceData?.taxAmount} Rs',
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Total Amount', style: text_style_para1),
                          const TextSpan(text: ': ', style: text_style_para1),
                          TextSpan(
                            text: '${widget.invoiceData?.totalAmount} Rs',
                            style: text_style_title13.copyWith(
                                color: buttonColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _openDocument(context);
                },
                icon: Image.asset('$icons_path/download.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
