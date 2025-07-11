import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_expansion_tile.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/invoices_list_response.dart';
import 'package:host_visitor_connect/features/invoices/data/network/responses/receipt_response.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReceiptListing extends StatefulWidget {
  final InvoicesListResponse? receiptListResponse;
  final List<ReceiptResponseData>? invoicesMonths;

  const ReceiptListing({
    super.key,
    this.receiptListResponse,
    this.invoicesMonths,
  });

  @override
  State<ReceiptListing> createState() => _ReceiptListingState();
}

class _ReceiptListingState extends State<ReceiptListing> {
  late ScrollController _invoiceListScrollController;
  late final AppExpansionTileController _tileController;
  late ScrollController _visitorListScrollController;
  String _listCurrentIndex = "";

  void _listenToListScroll() {
    final scrollOffset = _visitorListScrollController.offset;
    final scrollPosition = _visitorListScrollController.position;

    // print("scroll scrollPosition > ${scrollPosition}");

    // checking scroll offset & position
    // if (scrollPosition.ra) {
    // if (scrollOffset >= scrollPosition.minScrollExtent) {
    //   print(" innn  ");
    //reached bottom
    //commented api call as pagination not added in backend
    // _reportListBloc.getNextPageOfReports(
    //   filtersModel: widget.filtersModel,
    // );
    // }
    // }
  }

  @override
  void initState() {
    _invoiceListScrollController = ScrollController();
    _tileController = AppExpansionTileController();
    // _visitorListScrollController
    _visitorListScrollController = ScrollController();
    // _visitorListScrollController.addListener(_listenToListScroll);
    super.initState();
  }

  @override
  void dispose() {
    _invoiceListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          controller: _visitorListScrollController,
          itemCount: widget.invoicesMonths?.length ?? 0,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < (widget.invoicesMonths?.length ?? 0)) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                leading:
                    _hostImageWidget(widget.invoicesMonths?[index].hc22 ?? ""),
                trailing: _trailingWidget(
                    widget.invoicesMonths?[index].hc20.toString(),
                    widget.invoicesMonths?[index].hc6),
                title: Text(widget.invoicesMonths?[index].hc3 ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.titleLarge(context).copyWith(
                        fontSize: appSize(context: context, unit: 10) / 14)),
                subtitle: Text(
                    widget.invoicesMonths?[index].hc18
                            .toString()
                            .toUpperCase() ??
                        "",
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.bodyMedium(context).copyWith(
                        color: Colors.grey,
                        fontSize: appSize(context: context, unit: 10) / 20)),
                onTap: () {
                  print(
                      "file url >>> $googlePhotoUrl$visitorConnectDev$hostFolderName${SharedPrefs.getInt(keyHostFk)}/${widget.invoicesMonths?[index].hc15}");
                  _launchURL(
                      "$googlePhotoUrl$visitorConnectDev$hostFolderName${SharedPrefs.getInt(keyHostFk)}/$paymentReceipt${widget.invoicesMonths?[index].hc15}");
                },
              );
            }
            return const SizedBox.shrink();
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: appSize(context: context, unit: 10) / 3),
              child: const Divider(color: Colors.grey, thickness: .5),
            );
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       child: Text(timeStampToDateTime(_listCurrentIndex)),
        //     ),
        //   ],
        // )
      ],
    );
  }

  void _stickyDate() {}

  _launchURL(url) async {
    // const url = 'https://flutter.dev/exapmle.pdf';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _hostImageWidget(imgUrl) => CachedNetworkImage(
        imageUrl: '$googlePhotoUrl${getBucketName()}$userPhoto${imgUrl}',
        imageBuilder: (context, imageProvider) {
          return Container(
            width: appSize(context: context, unit: 10) / 12,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) => SizedBox(
          width: appSize(context: context, unit: 10) / 4,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: light_blue_color,
          width: appSize(context: context, unit: 10) / 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.orange,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: Image.asset('$icons_path/building.png').image)),
            ),
          ),
        ),
      );

  _trailingWidget(amount, date) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(timeStampToDateTime(date),
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bodyMedium(context).copyWith(
                  color: Colors.grey,
                  fontSize: appSize(context: context, unit: 10) / 20)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("₹ $amount",
                  style: AppStyle.titleLarge(context).copyWith(
                      fontSize: appSize(context: context, unit: 10) / 16)),
              Icon(CupertinoIcons.arrow_up_right,
                  size: appSize(context: context, unit: 10) / 14),
            ],
          ),
        ],
      );
}
