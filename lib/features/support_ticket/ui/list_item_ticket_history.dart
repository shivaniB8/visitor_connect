import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/data/network/responses/ticket_history_response.dart';
import 'package:photo_view/photo_view.dart';

class ListItemTicketHistory extends StatefulWidget {
  final TicketMessages? ticketHistoryResponse;

  const ListItemTicketHistory({
    super.key,
    this.ticketHistoryResponse,
  });

  @override
  State<ListItemTicketHistory> createState() => _ListItemTicketHistoryState();
}

class _ListItemTicketHistoryState extends State<ListItemTicketHistory> {
  double height = 200.0;

  @override
  Widget build(BuildContext context) {
    List<String?>? images = widget.ticketHistoryResponse?.sb6?.split(',');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.ticketHistoryResponse?.sb12 == 2 ||
                  widget.ticketHistoryResponse?.sb12 == 3)
                CachedNetworkImage(
                  key: Key(
                      '$googlePhotoUrl${getBucketName()}${widget.ticketHistoryResponse?.sb12 == 2 ? superAdminFolder : clientFolder}${widget.ticketHistoryResponse?.profileimagename}'),
                  imageUrl:
                      '$googlePhotoUrl${getBucketName()}${widget.ticketHistoryResponse?.sb12 == 2 ? superAdminFolder : clientFolder}${widget.ticketHistoryResponse?.profileimagename}',
                  imageBuilder: (context, imageProvider) => Container(
                    width: appSize(context: context, unit: 10) / 6,
                    height: appSize(context: context, unit: 10) / 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => ClipOval(
                    child: Image.asset(
                      width: MediaQuery.of(context).size.height / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      '$icons_path/avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (widget.ticketHistoryResponse?.sb12 == 2 ||
                  widget.ticketHistoryResponse?.sb12 == 3)
                const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: widget.ticketHistoryResponse?.sb12 == 2 ||
                          widget.ticketHistoryResponse?.sb12 == 3
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  alignment:
                                      (widget.ticketHistoryResponse?.sb12 == 1)
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8)),
                                      color: Colors.grey),
                                  child: Text(
                                    "${capitalizedString(widget.ticketHistoryResponse?.sb11 ?? 'N/A').split(" ")[0]} ${capitalizedString(widget.ticketHistoryResponse?.sb11 ?? 'N/A').split(" ")[1]}",
                                    style: AppStyle.titleExtraSmall(context)
                                        .copyWith(
                                            color: Colors.black54,
                                            fontSize: appSize(
                                                    context: context,
                                                    unit: 10) /
                                                20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 10,
                                    widget.ticketHistoryResponse?.sb5 ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign:
                                        (widget.ticketHistoryResponse?.sb12 ==
                                                1)
                                            ? TextAlign.end
                                            : TextAlign.start,
                                    style: AppStyle.titleLarge(context)
                                        .copyWith(
                                            fontSize: appSize(
                                                    context: context,
                                                    unit: 10) /
                                                18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.ticketHistoryResponse?.sb6?.isNotEmpty ??
                              false)
                            const SizedBox(
                              height: 5,
                            ),
                          if (widget.ticketHistoryResponse?.sb6?.isNotEmpty ??
                              false)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              child: Align(
                                alignment:
                                    widget.ticketHistoryResponse?.sb12 == 1
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      images?.length ?? 0,
                                      (index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: displayImage(
                                              images?[index] ?? ''),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      '${timeStampToTime(widget.ticketHistoryResponse?.z501)}',
                      style: AppStyle.titleExtraSmall(context).copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: appSize(context: context, unit: 10) / 22),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (widget.ticketHistoryResponse?.sb12 == 1)
                const SizedBox(width: 15),
              if (widget.ticketHistoryResponse?.sb12 == 1)
                CachedNetworkImage(
                  key: Key(
                      '$googlePhotoUrl${getBucketName()}$hostFolder${widget.ticketHistoryResponse?.profileimagename}'),
                  imageUrl:
                      '$googlePhotoUrl${getBucketName()}$hostFolder${widget.ticketHistoryResponse?.profileimagename}',
                  imageBuilder: (context, imageProvider) => Container(
                    width: appSize(context: context, unit: 10) / 6,
                    height: appSize(context: context, unit: 10) / 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => ClipOval(
                    child: Image.asset(
                      width: MediaQuery.of(context).size.height / 15,
                      height: MediaQuery.of(context).size.height / 15,
                      '$icons_path/avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayImage(
    String fileUrl,
  ) {
    return CachedNetworkImage(
      key: Key(fileUrl),
      imageUrl: fileUrl,
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Image',
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.close),
                                  )
                                ],
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                // color: Colors.transparent,
                                height: sizeHeight(context) / 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PhotoView(
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    imageProvider: NetworkImage(
                                      fileUrl,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.height / 20,
          height: MediaQuery.of(context).size.height / 20,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Container(
        width: MediaQuery.of(context).size.height / 20,
        height: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          '$icons_path/avatar.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
