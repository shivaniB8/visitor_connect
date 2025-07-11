import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bottomsheet.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_communication_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/model/ticket.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/ticket_communication_builder.dart';
import 'package:image_picker/image_picker.dart';

import 'ticket_listing_fragment.dart';

class TicketHistoryScreen extends StatefulWidget {
  final int? sa1;
  final Ticket? ticket;

  const TicketHistoryScreen({
    super.key,
    this.sa1,
    this.ticket,
  });

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  List<XFile> files = [];
  String? message;
  bool showErrorMsg = false;
  TextEditingController? textEditingController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    textEditingController = TextEditingController();
    Future.delayed(const Duration(milliseconds: 1000), () {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    });

    super.initState();
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double spacing = appSize(context: context, unit: 10) / 10;
    print("spacing >> ${spacing}");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: CustomImageAppBar(
      //   title: 'Ticket History',
      //   context: context,
      //   showSearchField: false,
      //   showEditIcon: false,
      //   showSettings: false,
      // ),
      backgroundColor: Colors.white,
      // insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DialogHeader(),
              SizedBox(height: spacing / 10),
              SubHeader(
                ticketNo: widget.ticket?.ticketNumber.toString(),
                allocatedTo: widget.ticket?.ticketOwnerEmployeeValue ?? 'N/A',
                requestDate: widget.ticket?.ticketCreatedAt,
                requestFor: widget.ticket?.problemIn?.problemIn(),
                ticketStatus: 'Submitted',
              ),
              SizedBox(height: spacing - 5),
              Container(
                  height: spacing * 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                    color: card_background_grey_color,
                  ),
                  child: TicketListingFragment(
                      scrollController: _scrollController, sa1: widget.sa1)),
              SizedBox(height: spacing),
              _messageInteractionWidget(),
              SizedBox(height: spacing - 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageInteractionWidget() => Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              AddFormField(
                controller: textEditingController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                maxLines: 3,
                fillColor: card_background_grey_color,
                maxLength: 100,
                hintText: 'Type message',
                label: 'Message',
                isRequired: true,
                onChanged: (value) {
                  message = value;
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TicketCommunicationBuilder(
                    onSubmitMessage: () {
                      if ((message?.isEmpty ?? false) || message == null) {
                        setState(() {
                          showErrorMsg = true;
                        });
                      } else {
                        setState(() {
                          showErrorMsg = false;
                        });
                        context
                            .read<TicketCommunicationBloc>()
                            .ticketCommunication(
                              sa1: widget.sa1,
                              sb5: message,
                              screenshot1:
                                  files.isNotEmpty ? files.first : XFile(''),
                              screenshot2: files.isNotEmpty && files.length > 1
                                  ? files[1]
                                  : XFile(''),
                              screenshot3: files.isNotEmpty && files.length > 2
                                  ? files[2]
                                  : XFile(''),
                              screenshot4: files.isNotEmpty && files.length > 3
                                  ? files[3]
                                  : XFile(''),
                              screenshot5: files.isNotEmpty && files.length > 4
                                  ? files[4]
                                  : XFile(''),
                            );
                      }
                    },
                    onSuccess: () {
                      setState(() {
                        files.clear();
                      });
                      textEditingController?.clear();
                      context
                          .read<TicketHistoryBloc>()
                          .getTicketHistory(sa1: widget.sa1 ?? 0);
                    },
                  ),
                ),
              ),
              if (showErrorMsg)
                Text(
                  'Please enter message',
                  style: AppStyle.errorStyle(context),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: UploadMultiImage(
                  isEnable: true,
                  onImagesSelected: (image) {
                    setState(
                      () {
                        if (image.length == 5 && files.isEmpty) {
                          files.addAll(image);
                        } else if (files.length < 5 && files.isNotEmpty) {
                          int fileLength = 5 - files.length;
                          files.addAll(image.sublist(0, fileLength));
                        } else {
                          files.addAll(image.sublist(
                              0, image.length < 5 ? image.length : 5));
                        }
                      },
                    );
                    Navigator.pop(context);
                  },
                  showGallery: true,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: border_color_support,
                      border:
                          Border.all(color: disabled_color.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon(
                        //   Icons.attachment,
                        //   size: appSize(context: context, unit: 10) / 14,
                        // ),
                        // const SizedBox(width: 4),
                        Text('Attach Files',
                            style: AppStyle.buttonStyle(context).copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    appSize(context: context, unit: 10) / 18)),
                        const SizedBox(width: 4),
                        Text("(Max 5)",
                            style: AppStyle.labelSmall(context).copyWith(
                                fontSize:
                                    appSize(context: context, unit: 10) / 18,
                                color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              StatefulBuilder(builder: (context, setState) {
                return GestureDetector(
                  onTap: () {
                    if (files.isNotEmpty) {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 12),
                              decoration: BoxDecoration(
                                  // color: Colors.white
                                  ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Files Attached:",
                                          style: AppStyle.titleLarge(context)
                                              .copyWith(
                                                  fontSize: appSize(
                                                          context: context,
                                                          unit: 10) /
                                                      12),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Okay",
                                            style: AppStyle.buttonStyle(context)
                                                .copyWith(
                                                    fontSize: appSize(
                                                            context: context,
                                                            unit: 10) /
                                                        15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  getFiles(setState)
                                ],
                              ),
                            );
                          });
                    }
                  },
                  child: Container(
                    // color: Colors.orange,
                    width: appSize(context: context, unit: 10) / 6.5,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CircleAvatar(
                          radius: appSize(context: context, unit: 10) / 17,
                          backgroundColor: border_color_support,
                          child: Text(files.length.toString(),
                              style: AppStyle.labelSmall(context).copyWith(
                                  color: Colors.black54,
                                  fontSize:
                                      appSize(context: context, unit: 10) /
                                          17)),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.attach_file,
                              size: appSize(context: context, unit: 10) / 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ],
      );

  // Widget chooseFiles() {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //               color: border_color_support,
  //               border: Border.all(color: disabled_color.withOpacity(0.3)),
  //             ),
  //             child: const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
  //               child: Text('Choose Files'),
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           if (files.isEmpty) const Text('No file chosen'),
  //         ],
  //       ),
  //       if (files.isNotEmpty)
  //         const SizedBox(
  //           height: 10,
  //         ),
  //       // if (files.isNotEmpty) getFiles(),
  //     ],
  //   );
  // }

  Widget getFiles(setStatee) {
    return StatefulBuilder(builder: (context, setState) {
      return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: files.map((image) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: background_grey_color,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Image.file(
                        File(image.path),
                        width: 70,
                        height: 70,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 2, left: 4, right: 4),
                        child: Text(
                          shortenFileName(image.name),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.labelLarge(context).copyWith(
                              fontSize:
                                  appSize(context: context, unit: 10) / 22),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      ///   this state effects count on ui
                      setStatee(() {
                        files.remove(image);
                      });

                      ///   this state effects on Bottomsheet
                      setState(() {
                        files = files;
                      });
                    },
                    child: CircleAvatar(
                      radius: appSize(context: context, unit: 10) / 18,
                      backgroundColor: Colors.redAccent,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: appSize(context: context, unit: 10) / 12,
                      ),
                    )),
              ],
            );
          }).toList());
    });
  }

  String shortenFileName(String fileName) {
    if (fileName.length <= 10) return fileName;
    String extension = fileName.split('.').last;
    return "${fileName.substring(0, 8)}...${fileName[fileName.length - extension.length - 2]}.$extension";
  }
}

class DialogHeader extends StatelessWidget {
  const DialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Ticket History',
              style: AppStyle.titleLarge(context)
                  .copyWith(fontSize: appSize(context: context, unit: 10) / 13),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                size: appSize(context: context, unit: 10) / 9,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class SubHeader extends StatelessWidget {
  final String? ticketNo;
  final String? ticketStatus;
  final String? allocatedTo;
  final String? requestFor;
  final String? requestDate;

  const SubHeader({
    super.key,
    this.ticketNo,
    this.ticketStatus,
    this.allocatedTo,
    this.requestFor,
    this.requestDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  _commonWidget(context, "Ticket No.", ticketNo ?? '', 1),
                  const SizedBox(width: 12),
                  _commonWidget(
                      context, "Ticket Status.", ticketStatus ?? '', 2),
                  const SizedBox(width: 12),
                  _commonWidget(context, "Allocated To", allocatedTo ?? '', 2),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  _commonWidget(context, "Request For.", requestFor ?? '', 1),
                  const SizedBox(width: 12),
                  _commonWidget(
                      context,
                      "Request Date.",
                      timeStampToDateAndTime(requestDate ?? '', sendAnd: true),
                      1),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _commonWidget(context, title, text, flex) => Expanded(
        flex: flex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyle.titleExtraSmall(context).copyWith(
                fontSize: appSize(context: context, unit: 10) / 21,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  // flex: flex,
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      color: card_background_grey_color,
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          text,
                          style: AppStyle.titleExtraSmall(context).copyWith(
                              fontSize:
                                  appSize(context: context, unit: 10) / 21),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
