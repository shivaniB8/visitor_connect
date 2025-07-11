import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/create_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/modules_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_mobile_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_web_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/create_ticket_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class CreateNewTicketDialog extends StatefulWidget {
  const CreateNewTicketDialog({super.key});

  @override
  State<CreateNewTicketDialog> createState() => _CreateNewTicketDialogState();
}

class _CreateNewTicketDialogState extends State<CreateNewTicketDialog> {
  String? _selectedOption;
  bool showErrorSelectedOption = false;
  String? _selectedProblem;
  bool showErrorSelectedProblem = false;
  String? description1;
  String? description2;
  List<XFile> files = [];
  List<KeyValueResponse?> selectedInformTo = [];
  bool showErrorUserSelect = false;
  List<KeyValueResponse?> selectModule = [];
  bool showError = false;
  bool showDescriptionError = false;
  bool showDescriptionError2 = false;

  List<KeyValueResponse> appModules = [
    KeyValueResponse(value: 1, label: 'Scan QR'),
    KeyValueResponse(value: 2, label: 'Driving Licence'),
    KeyValueResponse(value: 3, label: 'Registration Certificate (RC)'),
    KeyValueResponse(value: 4, label: 'Host'),
    KeyValueResponse(value: 5, label: 'Guest'),
    KeyValueResponse(value: 6, label: 'Rent Agreement'),
    KeyValueResponse(value: 7, label: 'Support Ticket'),
    KeyValueResponse(value: 8, label: 'Add Visitor'),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogHeader(),
              Text(
                'Select what type of support you need',
                style: AppStyle.bodyLarge(context)
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  radioButton(
                    context: context,
                    groupValue: _selectedOption,
                    value: 'technical',
                    title: const Text('Facing technical problem'),
                    onChanged: (String? value) {
                      setState(() {
                        showErrorSelectedOption = false;
                        _selectedOption = value;
                      });
                    },
                  ),
                  radioButton(
                    context: context,
                    title: const Text(
                        'Need help in some settings (Navigational guidance)'),
                    value: 'navigational',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        showErrorSelectedOption = false;
                        _selectedOption = value;
                      });
                    },
                  ),
                  if (showErrorSelectedOption)
                    Text(
                      'Please select issue type',
                      style: AppStyle.errorStyle(context),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (_selectedOption == 'technical') ...[
                technicalProblem(
                    changeColor: (value) {
                      // setState(() {
                      //   _selectedProblem = value;
                      // });
                    },
                    context: context),
              ] else if (_selectedOption == 'navigational') ...[
                navigationProblem(),
              ],
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please Note: ',
                      style: AppStyle.bodyMedium(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          'Please Note: Our support team is available from Monday to Friday 10AM to 6PM excluding public holidays.',
                      style: AppStyle.bodyMedium(context)
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeHeight(context) / 40,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CreateTicketBuilder(
                    onCreateTicket: () {
                      if (_selectedOption == null ||
                          _selectedOption.isNullOrEmpty()) {
                        setState(() {
                          showErrorSelectedOption = true;
                        });
                      }
                      if (_selectedOption == 'technical') {
                        if (_selectedProblem == null ||
                            _selectedProblem.isNullOrEmpty()) {
                          setState(() {
                            showErrorSelectedProblem = true;
                          });
                        }
                        if (selectedInformTo.isEmpty) {
                          setState(() {
                            showErrorUserSelect = true;
                          });
                        }
                        if (description1 == null ||
                            (description1?.isEmpty ?? false)) {
                          setState(() {
                            showDescriptionError = true;
                          });
                        }
                        if ((_selectedOption?.isNotEmpty ?? false) &&
                            (_selectedProblem?.isNotEmpty ?? false) &&
                            (description1?.isNotEmpty ?? false) &&
                            selectedInformTo.isNotEmpty) {
                          context.read<CreateTicket>().informTo =
                              selectedInformTo;
                          context.read<CreateTicket>().description =
                              description1;
                          context.read<CreateTicket>().models = selectModule;
                          context.read<CreateTicket>().sa5 =
                              _selectedProblem == "web"
                                  ? 1
                                  : _selectedProblem == "android"
                                      ? 2
                                      : _selectedProblem == "ios"
                                          ? 3
                                          : _selectedProblem == "all"
                                              ? 4
                                              : null;
                          context.read<CreateTicket>().sa6 =
                              _selectedOption == "technical" ? 1 : 2;
                          if (_selectedOption == 'technical') {
                            context.read<CreateTicketBloc>().createTicket(
                                  ticketMap:
                                      context.read<CreateTicket>().toJson,
                                  screenshot1: files.isNotEmpty
                                      ? files.first
                                      : XFile(''),
                                  screenshot2:
                                      files.isNotEmpty && files.length > 1
                                          ? files[1]
                                          : XFile(''),
                                  screenshot3:
                                      files.isNotEmpty && files.length > 2
                                          ? files[2]
                                          : XFile(''),
                                  screenshot4:
                                      files.isNotEmpty && files.length > 3
                                          ? files[3]
                                          : XFile(''),
                                  screenshot5:
                                      files.isNotEmpty && files.length > 4
                                          ? files[4]
                                          : XFile(''),
                                );
                          }
                        }
                      } else {
                        if (description2 == null ||
                            (description2?.isEmpty ?? false)) {
                          setState(() {
                            showDescriptionError2 = true;
                          });
                        }
                        if (!(description2.isNullOrEmpty())) {
                          context.read<CreateTicket>().description =
                              description2;
                          context.read<CreateTicket>().sa6 =
                              _selectedOption == "technical" ? 1 : 2;
                          context.read<CreateTicketBloc>().createTicket(
                                ticketMap: context.read<CreateTicket>().toJson,
                              );
                        }
                      }
                    },
                    onSuccess: () {
                      context.read<NewTicketBloc>().getTickets(status: 1);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Button(
                    style: AppStyle.bodyLarge(context).copyWith(
                      color: Colors.white,
                    ),
                    text: 'Close',
                    isRectangularBorder: true,
                    backgroundColor: disabled_color,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String shortenFileName(String fileName) {
    if (fileName.length <= 10) return fileName;
    String extension = fileName.split('.').last;
    return "${fileName.substring(0, 8)}...${fileName[fileName.length - extension.length - 2]}.$extension";
  }

  Widget radioButton({
    Widget? title,
    String? groupValue,
    required String value,
    void Function(String?)? onChanged,
    required BuildContext context,
  }) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      dense: true,
      titleTextStyle: AppStyle.titleSmall(context),
      horizontalTitleGap: 0,
      leading: Radio<String>(
        activeColor: buttonColor,
        groupValue: groupValue,
        value: value,
        onChanged: onChanged,
      ),
      contentPadding: EdgeInsets.zero,
      title: title,
    );
  }

  Widget technicalProblem({
    required BuildContext context,
    Function(String?)? changeColor,
  }) {
    final items = _selectedProblem == 'web' || _selectedProblem == 'all'
        ? context
            .read<UsersListWebBloc>()
            .state
            .getData()
            ?.data
            ?.map((e) => MultiSelectItem<KeyValueResponse?>(
                e, capitalizedString('${e.label}')))
            .toList()
        : context
            .read<UsersListMobileBloc>()
            .state
            .getData()
            ?.data
            ?.map((e) => MultiSelectItem<KeyValueResponse?>(
                e, capitalizedString('${e.label}')))
            .toList();

    final modules = _selectedProblem == 'ios' || _selectedProblem == 'android'
        ? appModules
            .map((e) => MultiSelectItem<KeyValueResponse?>(
                e, capitalizedString('${e.label}')))
            .toList()
        : context
            .read<ModulesBloc>()
            .state
            .getData()
            ?.data
            ?.map((e) => MultiSelectItem<KeyValueResponse?>(
                e, capitalizedString('${e.label}')))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Problem In',
          style:
              AppStyle.bodyLarge(context).copyWith(fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  radioButton(
                    context: context,
                    value: 'web',
                    groupValue: _selectedProblem,
                    title: const Text('Web Application'),
                    onChanged: (value) {
                      changeColor?.call(value);
                      setState(() {
                        showErrorSelectedProblem = false;
                        _selectedProblem = value;
                        selectedInformTo.clear();
                        selectModule.clear();
                      });
                    },
                  ),
                  radioButton(
                    context: context,
                    title: const Text('Android Application'),
                    value: 'android',
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      changeColor?.call(value);
                      setState(() {
                        showErrorSelectedProblem = false;
                        _selectedProblem = value;
                        selectedInformTo.clear();
                        selectModule.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  radioButton(
                    context: context,
                    title: const Text('IOS Application'),
                    value: 'ios',
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      changeColor?.call(value);
                      setState(() {
                        showErrorSelectedProblem = false;
                        _selectedProblem = value;
                        selectedInformTo.clear();
                        selectModule.clear();
                      });
                    },
                  ),
                  radioButton(
                    context: context,
                    title: const Text('All'),
                    value: 'all',
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      changeColor?.call(value);
                      setState(() {
                        showErrorSelectedProblem = false;
                        _selectedProblem = value;
                        selectedInformTo.clear();
                        selectModule.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showErrorSelectedProblem)
          Text(
            'Please select issue type',
            style: AppStyle.errorStyle(context),
          ),
        if (_selectedProblem != null || (_selectedProblem?.isNotEmpty ?? false))
          const Row(
            children: [
              Text(
                'Affected User',
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        if (_selectedProblem != null || (_selectedProblem?.isNotEmpty ?? false))
          multiSelect(
            isUser: true,
            modules: items ?? [],
            onConfirm: (values) {
              selectedInformTo = values;
              setState(
                () {
                  if (selectedInformTo.isEmpty) {
                    showErrorUserSelect = true;
                  } else {
                    showErrorUserSelect = false;
                  }
                },
              );
            },
          ),
        if (showErrorUserSelect && !showErrorSelectedProblem)
          Text(
            'Please select affected user',
            style: AppStyle.errorStyle(context),
          ),
        const SizedBox(
          height: 10,
        ),
        if (_selectedProblem != null || (_selectedProblem?.isNotEmpty ?? false))
          const Text(
            'Module',
          ),
        const SizedBox(
          height: 5,
        ),
        if (_selectedProblem != null || (_selectedProblem?.isNotEmpty ?? false))
          multiSelect(
            modules: modules ?? [],
            onConfirm: (values) {
              selectModule = values;
              setState(
                () {
                  if (selectModule.isEmpty) {
                    showError = true;
                  } else {
                    showError = false;
                  }
                },
              );
            },
          ),
        const SizedBox(
          height: 5,
        ),
        if (showError)
          Text(
            'Please select module',
            style: AppStyle.errorStyle(context),
          ),
        const SizedBox(
          height: 10,
        ),
        AddFormField(
          isRequired: true,
          label: 'Description',
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          maxLines: 5,
          maxLength: 100,
          hintText: 'Problem Description',
          onChanged: (value) {
            description1 = value;
          },
        ),
        if (showDescriptionError)
          Text(
            'Please add description of issue',
            style: AppStyle.errorStyle(context),
          ),
        Text(
          'Kindly provide a detailed description of the issue you are facing, Tickets without proper details will be entertained with very less priority or not be entertained at all',
          style: AppStyle.titleExtraSmall(context).copyWith(color: Colors.red),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Attach Screenshots ',
                style: AppStyle.bodyMedium(context),
              ),
              TextSpan(
                text: '(Max 5)',
                style: AppStyle.bodyMedium(context).copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        UploadMultiImage(
          isEnable: true,
          onImagesSelected: (image) {
            setState(() {
              if (image.length == 5 && files.isEmpty) {
                files.addAll(image);
              } else if (files.length < 5 && files.isNotEmpty) {
                int fileLength = 5 - files.length;
                files.addAll(image.sublist(0, fileLength));
              } else {
                files.addAll(
                    image.sublist(0, image.length < 5 ? image.length : 5));
              }
            });
            Navigator.pop(context);
          },
          showGallery: true,
          child: Container(
            decoration: BoxDecoration(
              color: background_grey_color,
              border: Border.all(color: disabled_color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: chooseFiles(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget multiSelect({
    bool isUser = false,
    modules,
    required void Function(List<KeyValueResponse?>) onConfirm,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: MultiSelectBottomSheetField<KeyValueResponse?>(
        initialChildSize: 0.4,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          border: Border(
            bottom: selectModule.isNotEmpty
                ? BorderSide(
                    color: Colors.grey.withOpacity(0.6),
                  )
                : BorderSide.none,
          ),
        ),

        searchable: true,
        listType: MultiSelectListType.LIST,
        searchTextStyle:
            AppStyle.titleSmall(context).copyWith(color: text_color),
        searchHintStyle: AppStyle.titleSmall(context),
        selectedItemsTextStyle:
            AppStyle.titleSmall(context).copyWith(color: text_color),
        itemsTextStyle:
            AppStyle.titleSmall(context).copyWith(color: text_color),
        cancelText: Text("Cancel", style: AppStyle.titleSmall(context)),
        confirmText: Text("Ok",
            style: AppStyle.titleSmall(context).copyWith(color: buttonColor)),
        buttonIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 25,
        ),
        selectedColor: primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        // searchable: true,
        maxChildSize: 0.5,
        buttonText: Text(isUser ? "Select User" : "Select Module",
            style: AppStyle.titleSmall(context).copyWith(color: text_color)),
        title: Text(
          isUser ? "Select User" : "Select Module",
          style: AppStyle.titleSmall(context),
        ),
        items: modules ?? [],
        onConfirm: onConfirm,
        chipDisplay: MultiSelectChipDisplay(
          chipColor: Colors.grey.withOpacity(0.1),
          textStyle: AppStyle.titleSmall(context).copyWith(color: text_color),
          height: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onTap: (value) {
            setState(
              () {
                if (isUser) {
                  selectedInformTo.remove(value);
                  setState(() {
                    if (selectedInformTo.isEmpty) {
                      showErrorUserSelect = true;
                    } else {
                      showErrorUserSelect = false;
                    }
                  });
                } else {
                  selectModule.remove(value);
                  setState(() {
                    if (selectModule.isEmpty) {
                      showError = true;
                    } else {
                      showError = false;
                    }
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget chooseFiles() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: border_color_support,
                border: Border.all(color: disabled_color.withOpacity(0.3)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Text('Choose Files'),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            if (files.isEmpty) const Text('No file chosen'),
          ],
        ),
        if (files.isNotEmpty)
          const SizedBox(
            height: 10,
          ),
        if (files.isNotEmpty) getFiles(),
      ],
    );
  }

  Widget getFiles() {
    return Column(
        children: files.map((image) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: background_grey_color,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                children: [
                  Text(
                    shortenFileName(image.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          files.remove(image);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    }).toList());
  }

  Widget navigationProblem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddFormField(
          padding: const EdgeInsets.symmetric(vertical: 10),
          maxLines: 5,
          maxLength: 100,
          hintText: 'Problem Description',
          onChanged: (value) {
            description2 = value;
          },
        ),
        if (showDescriptionError2)
          Text(
            'Please add description of issue',
            style: AppStyle.errorStyle(context),
          ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
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
              'Create Support Ticket',
              style: AppStyle.titleMedium(context),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class CreateTicket extends ChangeNotifier {
  int? sa5;
  int? sa6;
  List<KeyValueResponse?>? models;
  List<KeyValueResponse?>? informTo;
  String? description;

  Map<String, dynamic> get toJson {
    return {
      "sa5": sa5,
      "sa6": sa6,
      "effecteduser": jsonEncode(informTo?.map((e) => e?.toJson()).toList()),
      "sa35": jsonEncode(models?.map((e) => e?.toJson()).toList()),
      "sb5": description ?? '',
    };
  }
}
