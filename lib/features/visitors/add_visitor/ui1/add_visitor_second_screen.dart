// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_success_page.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/reason_visit_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/update_visitors_info_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/model/add_indian_visitor.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/update_visitor_info_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddVisitorSecondScreen extends StatefulWidget {
  final OtpGenerationResponse? otpGenerationResponse;
  final QrScannerDataResponse? qrScannerDataResponse;
  final ForeignerData? foreignerData;
  final MobileResponseData? mobileResponseData;
  final bool? isAaddharDocument;
  final int visitorType;
  final bool? isUpdateForeigner;
  final bool? updateIndianVisitor;
  final bool? isFromScan;
  final int? businessType;

  const AddVisitorSecondScreen({
    super.key,
    this.otpGenerationResponse,
    this.foreignerData,
    this.mobileResponseData,
    this.qrScannerDataResponse,
    this.isAaddharDocument,
    required this.visitorType,
    this.isUpdateForeigner,
    this.updateIndianVisitor,
    this.isFromScan,
    this.businessType,
  });

  @override
  State<AddVisitorSecondScreen> createState() => _AddVisitorSecondScreenState();
}

class _AddVisitorSecondScreenState extends State<AddVisitorSecondScreen> {
  String? errorMsg;
  bool reasonIsNull = false;
  XFile? profilePhoto;
  List<KeyValueResponse>? reasons;
  int? _selectedValue;

  @override
  void initState() {
    getReasons();
    final updateVisitorInfo = context.read<UpdateVisitorInfo>();
    updateVisitorInfo.visitorType = widget.visitorType;

    // updateVisitorInfo.visitingFrom = DateTime.now();

    // updateVisitorInfo.visitingTill =
    //     DateTime.now().add(const Duration(days: 1));

    // updateVisitorInfo.visaExpiry = DateTime.now().add(
    //   const Duration(days: 1),
    // );
    // indian visitor
    if (widget.visitorType == 1 && !(widget.isFromScan ?? false)) {
      if (widget.updateIndianVisitor ?? false) {
        updateVisitorInfo.mobileNumber =
            widget.mobileResponseData?.mobileNumber;
        updateVisitorInfo.briefReason = null;
        updateVisitorInfo.visitorId?.add(widget.mobileResponseData?.id ?? 0);
        updateVisitorInfo.historyIds
            ?.add(widget.mobileResponseData?.historyId ?? 0);
        updateVisitorInfo.fullName = widget.mobileResponseData?.fullName;
        updateVisitorInfo.visitorType = widget.mobileResponseData?.visitorType;
      } else {
        updateVisitorInfo.visitorId?.add(
            widget.otpGenerationResponse?.data?.aadharDataResponse?.visitorFk ??
                0);
        updateVisitorInfo.mobileNumber = widget
            .otpGenerationResponse?.data?.aadharDataResponse?.mobileNumber;
        updateVisitorInfo.historyIds?.add(
            widget.otpGenerationResponse?.data?.aadharDataResponse?.historyId ??
                0);
        updateVisitorInfo.fullName =
            widget.otpGenerationResponse?.data?.aadharDataResponse?.fullName;
      }
    }
    // foreigner visitor
    else if (widget.visitorType == 2 && !(widget.isFromScan ?? false)) {
      if (widget.isUpdateForeigner ?? false) {
        updateVisitorInfo.mobileNumber =
            widget.mobileResponseData?.mobileNumber;
        updateVisitorInfo.visitorId?.add(widget.mobileResponseData?.id ?? 0);
        updateVisitorInfo.historyIds
            ?.add(widget.mobileResponseData?.historyId ?? 0);
        updateVisitorInfo.fullName = widget.mobileResponseData?.fullName;
      } else {
        updateVisitorInfo.visitorId?.add(widget.foreignerData?.id ?? 0);
        updateVisitorInfo.mobileNumber = widget.foreignerData?.mobileNumber;
        updateVisitorInfo.fullName = widget.foreignerData?.fullName;
        updateVisitorInfo.visitorType = widget.visitorType;
        updateVisitorInfo.historyIds
            ?.add(widget.foreignerData?.visitorHistoryId ?? 0);
      }
    } else if ((widget.isFromScan ?? false)) {
      updateVisitorInfo.mobileNumber = widget.qrScannerDataResponse?.mobileNo;
      updateVisitorInfo.passportNumber =
          widget.qrScannerDataResponse?.passportNo;
      updateVisitorInfo.visitorId?.add(widget.qrScannerDataResponse?.id ?? 0);
      updateVisitorInfo.historyIds
          ?.add(widget.qrScannerDataResponse?.historyId ?? 0);
      updateVisitorInfo.fullName = widget.qrScannerDataResponse?.fullName;
    }
    _selectedValue = widget.businessType;
    super.initState();
  }

  getReasons() async {
    await context.read<ReasonToVisitBloc>().getReasonToVisit();
  }

  DateTime? parseDate(String dateString) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  bool dropdownValidationLogic() {
    if (context.read<UpdateVisitorInfo>().reason == null ||
        context.read<UpdateVisitorInfo>().reason == '') {
      reasonIsNull = true;
    } else {
      reasonIsNull = false;
    }
    setState(() {});
    if (reasonIsNull) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorInfoBloc>().state is Progress,
      child: Scaffold(
        appBar: CustomImageAppBar(
          title: 'Add Visitor',
          context: context,
          showSettings: false,
          showEditIcon: false,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 15,
                right: 15,
                bottom: 15,
              ),
              child: FormBuilder(
                key: context.read<GlobalKey<FormBuilderState>>(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormFieldLabel(
                        label: 'Reason to Visit',
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReasonBuilder1(
                        reasons: context
                                .watch<ReasonToVisitBloc>()
                                .state
                                .getData()
                                ?.data ??
                            [],
                        reasonIsNull: reasonIsNull,
                        isSelectedReasonOther: () {
                          setState(() {});
                        },
                      ),
                      if (context.read<UpdateVisitorInfo>().reason == 'Other')
                        SizedBox(
                          height: sizeHeight(context) / 60,
                        ),
                      if (context.read<UpdateVisitorInfo>().reason == 'Other')
                        const FormFieldLabel(
                          label: 'Visiting Reason',
                          isRequired: true,
                        ),
                      if (context.read<UpdateVisitorInfo>().reason == 'Other')
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.read<UpdateVisitorInfo>().reason == 'Other')
                        AddFormField(
                            padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                            maxLines: 4,
                            minLines: 3,
                            hintText: 'Enter Reason',
                            isEnable: (context
                                    .watch<UpdateVisitorInfoBloc>()
                                    .state is Progress)
                                ? false
                                : true,
                            style: AppStyle.bodyMedium(context),
                            validator: (value) {
                              if (value.isNullOrEmpty()) {
                                return 'Please enter Reason';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              if (value.isNullOrEmpty()) {
                                context.read<UpdateVisitorInfo>().briefReason =
                                    null;
                              } else {
                                context.read<UpdateVisitorInfo>().briefReason =
                                    value;
                              }
                            }),
                      AddFormField(
                        hintText:
                            'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.',
                        label:
                            _selectedValue == 1 ? 'Room No.' : 'Car / Bike No.',
                        isRequired: true,
                        maxLines: 1,
                        maxLength: 10,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Z0-9]')),
                        ],
                        onChanged: (roomNo) {
                          context.read<UpdateVisitorInfo>().roomNo = roomNo;
                        },
                        isEnable: (context.watch<UpdateVisitorInfoBloc>().state
                                is Progress)
                            ? false
                            : true,
                        validator: (value) {
                          if (value.isNullOrEmpty()) {
                            return 'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: sizeHeight(context) / 60,
                      // ),
                      // DateTimeField(
                      //   maxYear: context.watch<UpdateVisitorInfo>().visitingFrom,
                      //   minYear: context.watch<UpdateVisitorInfo>().visitingFrom,
                      //   initialValue:
                      //       context.watch<UpdateVisitorInfo>().visitingFrom,
                      //   isReadOnly: true, // Disable user interaction
                      //   isReq  uired: true,
                      //   label: "Registration Date",
                      //   value: context.read<UpdateVisitorInfo>().visitingFrom,
                      //   isEnabled: context.watch<UpdateVisitorInfoBloc>().state
                      //           is Progress
                      //       ? false
                      //       : true,
                      // ),
                      // SizedBox(
                      //   height: sizeHeight(context) / 60,
                      // ),
                      // DateTimeField(
                      //   minYear: context.watch<UpdateVisitorInfo>().visitingTill,
                      //   initialValue:
                      //       context.watch<UpdateVisitorInfo>().visitingTill,
                      //   setValue: (date) {
                      //     if (date != null) {
                      //       // Set the dateOfBirth only if it's valid
                      //       context.read<UpdateVisitorInfo>().visitingTill = date;
                      //       setState(() {});
                      //     }
                      //   },
                      //   isEnabled: context.watch<UpdateVisitorInfoBloc>().state
                      //           is Progress
                      //       ? false
                      //       : true,
                      //   isRequired: true,
                      //   isReadOnly: false,
                      //   label: "Exit Date",
                      //   value: context.read<UpdateVisitorInfo>().visitingTill,
                      // ),
                      // SizedBox(
                      //   height: sizeHeight(context) / 60,
                      // ),
                      // if (widget.visitorType == 2)
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       BlocProvider(
                      //         create: (context) => ValidatorOnChanged(),
                      //         child: BlocBuilder<ValidatorOnChanged, String>(
                      //           builder: (context, state) => AddFormField(
                      //             isEnable: (context
                      //                     .watch<UpdateVisitorInfoBloc>()
                      //                     .state is Progress)
                      //                 ? false
                      //                 : true,
                      //             errorMsg: state,
                      //             isRequired: true,
                      //             hintText: 'Enter Your Visa Number',
                      //             label: 'Visa Number',
                      //             maxLength: 30,
                      //             keyboardType: TextInputType.text,
                      //             onChanged: (visa) {
                      //               context.read<UpdateVisitorInfo>().visaNumber =
                      //                   visa;
                      //             },
                      //             validator: (value) {
                      //               if (value?.isEmpty ?? false) {
                      //                 return 'Visa number is required';
                      //               }
                      //               return null; // Return null if validation passes
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //       DateTimeField(
                      //         minYear:
                      //             context.watch<UpdateVisitorInfo>().visaExpiry,
                      //         initialValue:
                      //             context.watch<UpdateVisitorInfo>().visaExpiry,
                      //         setValue: (date) {
                      //           if (date != null) {
                      //             context.read<UpdateVisitorInfo>().visaExpiry =
                      //                 date;
                      //           }
                      //         },
                      //         isReadOnly: false,
                      //         isRequired: true,
                      //         isEnabled: context
                      //                 .watch<UpdateVisitorInfoBloc>()
                      //                 .state is Progress
                      //             ? false
                      //             : true,
                      //         label: 'Visa Expiry Date',
                      //         value: context.read<UpdateVisitorInfo>().visaExpiry,
                      //       ),
                      //       SizedBox(
                      //         height: sizeHeight(context) / 40,
                      //       ),
                      //       UploadImage(
                      //         isEnable: context
                      //                 .watch<UpdateVisitorInfoBloc>()
                      //                 .state is Progress
                      //             ? false
                      //             : true,
                      //         onImageSelected: (image) {
                      //           setState(() {
                      //             profilePhoto = image;
                      //           });
                      //           Navigator.pop(context);
                      //         },
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             if (profilePhoto?.path.isNotEmpty ?? false)
                      //               SizedBox(
                      //                 width: sizeHeight(context) / 8,
                      //                 height: sizeHeight(context) / 8,
                      //                 child: (profilePhoto?.name
                      //                                 .contains(".png") ??
                      //                             false) ||
                      //                         (profilePhoto?.name
                      //                                 .contains(".jpg") ??
                      //                             false) ||
                      //                         (profilePhoto?.name
                      //                                 .contains(".jpeg") ??
                      //                             false)
                      //                     ? ClipRRect(
                      //                         borderRadius:
                      //                             BorderRadius.circular(6.0),
                      //                         child: Image.file(
                      //                           File(profilePhoto?.path ?? ''),
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       )
                      //                     : const SizedBox.shrink(),
                      //               ),
                      //             if (profilePhoto == null)
                      //               CachedNetworkImage(
                      //                 width: sizeHeight(context) / 8,
                      //                 height: sizeHeight(context) / 8,
                      //                 fit: BoxFit.cover,
                      //                 imageUrl: (widget.visitorType == 2 &&
                      //                         (widget.isUpdateForeigner ?? false))
                      //                     ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.mobileResponseData?.profilePhoto}'
                      //                     : '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.qrScannerDataResponse?.image}',
                      //                 imageBuilder: (context, imageProvider) =>
                      //                     Container(
                      //                   width: sizeHeight(context) / 8,
                      //                   height: sizeHeight(context) / 8,
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(6.0),
                      //                     image: DecorationImage(
                      //                       image: imageProvider,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 placeholder: (context, url) => Container(
                      //                   padding: const EdgeInsets.all(30),
                      //                   child: const CircularProgressIndicator(),
                      //                 ),
                      //                 errorWidget: (context, url, error) =>
                      //                     Container(
                      //                   width: sizeHeight(context) / 8,
                      //                   height: sizeHeight(context) / 8,
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(6.0),
                      //                     color: background_dark_grey,
                      //                     image: DecorationImage(
                      //                       image: Image.asset(
                      //                         '$icons_path/gallery.png',
                      //                         width: appSize(
                      //                                 context: context,
                      //                                 unit: 10) /
                      //                             6.0,
                      //                         height: appSize(
                      //                                 context: context,
                      //                                 unit: 10) /
                      //                             6.0,
                      //                       ).image,
                      //                       fit: BoxFit.contain,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             SizedBox(
                      //               height: sizeHeight(context) / 80,
                      //             ),
                      //             Text(
                      //               'Upload Visitor Photo',
                      //               style: AppStyle.bodyLarge(context).copyWith(
                      //                   color: buttonColor,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),

                      SizedBox(
                        height: sizeHeight(context) / 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: UpdateVisitorInfoBuilder(
                          onUpdate: () {
                            dropdownValidationLogic();
                            if (FormErrorBuilder.validateFormAndShowErrors(
                                context)) {
                              if (!dropdownValidationLogic()) {
                                context.read<UpdateVisitorInfo>().businessType =
                                    _selectedValue;
                                context
                                    .read<UpdateVisitorInfoBloc>()
                                    .updateVisitorInfo(
                                      // profilePhoto: profilePhoto ?? XFile(''),
                                      indianVisitorInfo: context
                                          .read<UpdateVisitorInfo>()
                                          .toJson,
                                    );
                              }
                            }
                          },
                          onSuccess: () {
                            Navigator.of(context)
                                .push(goToRoute(SuccessAppScreen(
                              img: '$icons_path/Group.png',
                              title: 'Congratulations!',
                              subtitle: (widget.updateIndianVisitor ?? false) ||
                                      (widget.isUpdateForeigner ?? false)
                                  ? "Visitor has been updated successfully"
                                  : "Visitor Added Successfully",
                              showBackButton: false,
                            )));
                          },
                          // if (false) {
                          //   Navigator.push(
                          //     context,
                          //     goToRoute(
                          //       DrivingLicenceProviders(
                          //         child: DrivingLicenceForm(
                          //           id: context
                          //               .read<UpdateVisitorInfo>()
                          //               .visitorId,
                          //           name: context
                          //               .read<UpdateVisitorInfo>()
                          //               .fullName,
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          // }
                          //   if (true) {
                          //     Navigator.of(context).push(
                          //       goToRoute(
                          //         const SuccessScreen(
                          //             isVisitor: true,
                          //             title: 'Visitor Updated Successfully',
                          //             subtitle:
                          //                 'Visitor has been updated successfully'),
                          //       ),
                          //     );
                          //   }
                          // }
                          // else if (userDetails?.branchCategory == 6) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => AadharPhotoProvider(
                          //         child: AadharPhotoScreen(
                          //           foreignerData: widget.foreignerData,
                          //           isForeigner: true,
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          //   if (true) {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => AadharPhotoProvider(
                          //           child: AadharPhotoScreen(
                          //             foreignerData: widget.foreignerData,
                          //             isForeigner: true,
                          //             isOldVisitor: true,
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   }
                          // }
                          // if (true) {
                          //   Navigator.of(context).push(
                          //     goToRoute(
                          //       const SuccessScreen(
                          //           isVisitor: true,
                          //           title: 'Visitor Updated Successfully',
                          //           subtitle:
                          //               'Visitor has been updated successfully'),
                          //     ),
                          //   );
                          // }
                          // if (true) {
                          //   Navigator.of(context).push(
                          //     goToRoute(
                          //       const SuccessScreen(
                          //           isVisitor: true,
                          //           title: 'Visitor Updated Successfully',
                          //           subtitle:
                          //               'Visitor has been updated successfully'),
                          //     ),
                          //   );
                          // } else {
                          //   Navigator.of(context).push(
                          //     goToRoute(
                          //       SuccessScreen(
                          //         isVisitor: true,
                          //         title: true
                          //             ? 'Visitor Updated Successfully'
                          //             : 'Visitor Added Successfully',
                          //         subtitle: false
                          //             ? 'Visitor has been updated successfully'
                          //             : 'Visitor has been added successfully',
                          //       ),
                          //     ),
                          //   );
                          // }
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReasonBuilder1 extends StatelessWidget {
  final bool? isFromListing;
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? reasons;
  final Function()? onSuccess;
  final bool isUpdate;
  final bool reasonIsNull;
  final String? reason;
  final Function()? isSelectedReasonOther;

  const ReasonBuilder1({
    super.key,
    this.onUpdateVoterPressed,
    this.onSuccess,
    this.isUpdate = false,
    required this.reasonIsNull,
    this.isSelectedReasonOther,
    this.reasons,
    this.isFromListing,
    this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorInfo>().reason is Progress,
      child: FormDropDownWidget(
        isNull: reasonIsNull,
        isRequired: true,
        removeValue: () {
          // if (isFromListing ?? false) {
          //   context.read<UpdateVisitor>().reason = '';
          //   context.read<UpdateVisitor>().reasonFk = 0;
          // } else {
          context.read<UpdateVisitorInfo>().reason = '';
          context.read<UpdateVisitorInfo>().reasonFk = 0;
          // }
        },
        errorMessage: "Please select Reason",
        dropdownFirstItemName: 'Select Reason',
        titles: reasons ?? [],
        title: reason ?? '',
        onTap: (data) {
          if (!(data.label.isNullOrEmpty())) {
            // if (isFromListing ?? false) {
            //   context.read<UpdateVisitor>().reason = data.label;
            //   context.read<UpdateVisitor>().reasonFk = data.value;
            // } else {
            context.read<UpdateVisitorInfo>().reason = data.label;
            context.read<UpdateVisitorInfo>().reasonFk = data.value;

            if (context.read<UpdateVisitorInfo>().reasonFk != 3) {
              print('yaha aaya');
              context.read<UpdateVisitorInfo>().briefReason = null;
            }
            // }
            isSelectedReasonOther?.call();
          }
        },
        isItEnabled: isFromListing ?? false
            ? context.watch<UpdateVisitorInfoBloc>().state is Progress
                ? false
                : true
            : context.watch<UpdateVisitorInfoBloc>().state is Progress
                ? false
                : true,
      ),
    );
  }
}

class ReasonBuilder extends StatefulWidget {
  final bool? isFromListing;
  final Function()? onReasonChange;
  final List<KeyValueResponse>? reasons;
  final Function()? onSuccess;
  final bool isUpdate;
  bool reasonIsNull;
  final String? reason;
  final bool? isIsEnable;

  ReasonBuilder({
    super.key,
    this.onReasonChange,
    this.onSuccess,
    this.isUpdate = false,
    required this.reasonIsNull,
    this.reasons,
    this.isFromListing,
    this.reason,
    this.isIsEnable = true,
  });

  @override
  State<ReasonBuilder> createState() => _ReasonBuilderState();
}

class _ReasonBuilderState extends State<ReasonBuilder> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorInfo>().reason is Progress,
      child: FormDropDownWidget(
        isNull: context.read<AddForeignerVisitor>().reasonFk == null &&
            widget.reasonIsNull,
        isRequired: true,
        removeValue: () {
          context.read<AddForeignerVisitor>().reason = null;
          context.read<AddForeignerVisitor>().reasonFk = null;
          setState(() {
            widget.reasonIsNull = true;
          });
        },
        errorMessage: "Please select Reason",
        dropdownFirstItemName: 'Select Reason',
        titles: widget.reasons ?? [],
        title: widget.reason ?? '',
        onTap: (data) {
          if (!(data.label.isNullOrEmpty())) {
            context.read<AddForeignerVisitor>().reason = data.label;
            context.read<AddForeignerVisitor>().reasonFk = data.value;
            setState(() {
              widget.reasonIsNull = false;
              widget.onReasonChange?.call();
            });
          }
        },
        isItEnabled: widget.isIsEnable ?? true,
      ),
    );
  }
}
