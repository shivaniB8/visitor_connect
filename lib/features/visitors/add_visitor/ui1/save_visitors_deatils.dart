import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_success_page.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/form_dropdown_widget.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/rentals/bloc/driving_licence_bloc.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/reason_visit_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/update_visitors_info_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/aadhar_data_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/update_visitor_info_builder.dart';
import '../../../../common/utils/utils.dart';
import 'aadhar_details.dart';
import 'model/add_indian_visitor.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';

class SaveVisitorDetails extends StatefulWidget {
  const SaveVisitorDetails({
    super.key,
    this.aadharDataResponse,
  });
  final AadharDataResponse? aadharDataResponse;
  @override
  State<SaveVisitorDetails> createState() => _SaveVisitorDetailsState();
}

class _SaveVisitorDetailsState extends State<SaveVisitorDetails> {
  bool reasonIsNull = false;
  String? businessType;
  int? _selectedValue;
  bool businessTypeIsNull = false;
  bool isLicenceConfirmed = false;
  bool isLicenceError = false;

  @override
  void initState() {
    getReasons();
    String? jsonString = SharedPrefs.getString(keyUserData);

    if (jsonString != null) {
      Map<String, dynamic> userData = jsonDecode(jsonString);
      businessType = userData['business_type'];
      if (businessType == "1") {
        _selectedValue = 1;
        isLicenceConfirmed = true;
      } else if (businessType == "2") {
        _selectedValue = 2;
        isLicenceConfirmed = false;
      } else {
        _selectedValue = null;
      }
    }

    context.read<UpdateVisitorInfo>().briefReason = null;
    super.initState();
  }

  getReasons() async {
    await context.read<ReasonToVisitBloc>().getReasonToVisit();
  }

  @override
  Widget build(BuildContext context) {
    final aadharNumbers = GlobalVariable.aadharData;
    final updateVisitorInfo = context.read<UpdateVisitorInfo>();

    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorInfoBloc>().state is Progress ||
          context.watch<DrivingLicenseBloc>().state is Progress,
      child: Scaffold(
        appBar: CustomImageAppBar(
          showSettings: false,
          showEditIcon: false,
          context: context,
          title: "Save Visitor Details",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FormBuilder(
              key: context.read<GlobalKey<FormBuilderState>>(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizeHeight(context) / 25,
                  ),
                  Container(
                    width: appSize(context: context, unit: 1.5),
                    decoration: BoxDecoration(
                      color: background_grey_color,
                      border: Border.all(
                          color: Colors.grey.withOpacity(
                        0.3,
                      )),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Center(
                        child: Text(
                          'Indian',
                          style: AppStyle.bodySmall(context)
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 50,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: aadharNumbers.length,
                    itemBuilder: (context, index) {
                      return AadharDetails(
                        showAllAadharDetails: false,
                        aadharDataResponse: aadharNumbers[index],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Please confirm your visitors details before saving.",
                        style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.green, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormFieldLabel(
                        isRequired: true,
                        label: "Reason to Visit",
                        // labelColor: drop_down_title,
                      ),
                      const SizedBox(height: 10),
                      ReasonBuilder(
                        reasons: context
                                .watch<ReasonToVisitBloc>()
                                .state
                                .getData()
                                ?.data ??
                            [],
                        reasonIsNull: reasonIsNull,
                        isSelectedReasonOther: () {
                          setState(() {
                            if (context.read<UpdateVisitorInfo>().reasonFk ==
                                null) {
                              reasonIsNull = true;
                            } else {
                              reasonIsNull = false;
                              context.read<UpdateVisitorInfo>().briefReason =
                                  null;
                            }
                          });
                        },
                      ),
                      if (context.watch<UpdateVisitorInfo>().reason == "Other")
                        AddFormField(
                          padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                          maxLines: 4,
                          minLines: 3,
                          isRequired: true,
                          isEnable: context.watch<UpdateVisitorInfoBloc>().state
                                  is Progress
                              ? false
                              : true,
                          hintText: "Enter Reason",
                          onChanged: (value) {
                            context.read<UpdateVisitorInfo>().briefReason =
                                value;
                            FormErrorBuilder.validateFormAndShowErrors(context);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return 'Please enter reason to visit';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 10),
                      if (businessType == "1,2")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormFieldLabel(
                              label: 'Choose Business Type',
                              isRequired: true,
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  activeColor: context
                                          .read<UpdateVisitorInfoBloc>()
                                          .state is Progress
                                      ? gray_color
                                      : primary_color,
                                  value: 1,
                                  groupValue: _selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                      businessTypeIsNull = false;
                                      isLicenceConfirmed = true;
                                    });
                                  },
                                ),
                                Text(
                                  'Hotel / Home Stay',
                                  style: AppStyle.bodyMedium(context),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  activeColor: context
                                          .read<UpdateVisitorInfoBloc>()
                                          .state is Progress
                                      ? gray_color
                                      : primary_color,
                                  value: 2,
                                  groupValue: _selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                      businessTypeIsNull = false;
                                      isLicenceConfirmed = false;
                                    });
                                  },
                                ),
                                Text(
                                  'Vehicle Rental (Two | Four Wheeler Rental)',
                                  style: AppStyle.bodyMedium(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (businessTypeIsNull)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            'Please select business type',
                            style: AppStyle.errorStyle(context),
                          ),
                        ),
                      if (businessType != "1,2" || _selectedValue != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: FormFieldLabel(
                                isRequired: true,
                                label: _selectedValue == 1
                                    ? 'Room No.'
                                    : 'Car / Bike No.',
                              ),
                            ),
                            AddFormField(
                              maxLines: 1,
                              isRequired: true,
                              isEnable: context
                                      .watch<UpdateVisitorInfoBloc>()
                                      .state is Progress
                                  ? false
                                  : true,
                              hintText:
                                  'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.',
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Z0-9]')),
                              ],
                              onChanged: (value) {
                                context.read<UpdateVisitorInfo>().roomNo =
                                    value;
                                FormErrorBuilder.validateFormAndShowErrors(
                                    context);
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.';
                                }
                                return null;
                              },
                            ),
                            if (_selectedValue == 2)
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: FormFieldLabel(
                                  isRequired: true,
                                  label: 'Driving Licence Number',
                                ),
                              ),
                            if (_selectedValue == 2)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AddFormField(
                                      maxLines: 1,
                                      maxLength: 15,
                                      isRequired: true,
                                      isEnable:
                                          isLicenceConfirmed ? false : true,
                                      hintText: 'Enter Driving Licence number',
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[A-Z0-9]')),
                                      ],
                                      onChanged: (value) {
                                        context
                                            .read<UpdateVisitorInfo>()
                                            .drivingLicenceNumber = value;
                                        FormErrorBuilder
                                            .validateFormAndShowErrors(context);
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please enter driving licence number';
                                        } else if (value?.length != 15) {
                                          return 'Please enter valid driving licence number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  isLicenceConfirmed
                                      ? DotsProgressButton(
                                          isRectangularBorder: true,
                                          text: 'View',
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (_) =>
                                                  popUpWidget(context),
                                            );
                                          },
                                        )
                                      : DrivingLicenceBuilder(
                                          onGetData: () {
                                            if (FormErrorBuilder
                                                .validateFormAndShowErrors(
                                                    context)) {
                                              AppFunctions.unFocus(context);
                                              context
                                                  .read<DrivingLicenseBloc>()
                                                  .drivingLicence(
                                                    id: aadharNumbers[0]
                                                            .visitorFk ??
                                                        0,
                                                    dob: aadharNumbers[0].dob ??
                                                        '',
                                                    licenceNo: context
                                                            .read<
                                                                UpdateVisitorInfo>()
                                                            .drivingLicenceNumber ??
                                                        '',
                                                    name: aadharNumbers[0]
                                                            .fullName ??
                                                        '',
                                                  );
                                            }
                                          },
                                          onSuccess: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (_) =>
                                                  popUpWidget(context),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            if (isLicenceError)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  'Please confirm driving licence details',
                                  style: AppStyle.errorStyle(context),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  UpdateVisitorInfoBuilder(
                    appError: (v) {
                      if (v) {
                        setState(() {});
                      }
                    },
                    onUpdate: () {
                      setState(() {
                        if (context.read<UpdateVisitorInfo>().reasonFk ==
                            null) {
                          reasonIsNull = true;
                        } else {
                          reasonIsNull = false;
                        }
                        if (businessType == "1,2" && _selectedValue == null) {
                          businessTypeIsNull = true;
                        } else {
                          businessTypeIsNull = false;
                        }
                      });
                      if (!isLicenceConfirmed) {
                        isLicenceError = true;
                      } else {
                        isLicenceError = false;
                      }
                      if (!reasonIsNull &&
                          !businessTypeIsNull &&
                          !isLicenceError &&
                          FormErrorBuilder.validateFormAndShowErrors(context)) {
                        AppFunctions.unFocus(context);
                        for (int i = 0; i < aadharNumbers.length; i++) {
                          if (!updateVisitorInfo.visitorId!
                              .contains(aadharNumbers[i].visitorFk!)) {
                            updateVisitorInfo.visitorId
                                ?.add(aadharNumbers[i].visitorFk!);
                            updateVisitorInfo.historyIds
                                ?.add(aadharNumbers[i].historyId ?? 0);
                          }
                        }
                        updateVisitorInfo.businessType = _selectedValue;
                        updateVisitorInfo.visitorType = 1;
                        context.read<UpdateVisitorInfoBloc>().updateVisitorInfo(
                              indianVisitorInfo: updateVisitorInfo.toJson,
                            );
                      }
                    },
                    onSuccess: () {
                      Navigator.pushReplacement(
                          context,
                          goToRoute(const SuccessAppScreen(
                            img: '$icons_path/Group.png',
                            title: 'Congratulations!',
                            subtitle: 'Visitor has been added successfully',
                            showBackButton: false,
                          )));
                    },
                    error: (error) {
                      AppActionDialog.showActionDialog(
                        image: "$icons_path/ErrorIcon.png",
                        context: context,
                        title: "Error occurred",
                        subtitle: error.toLowerCase().contains("exception")
                            ? "Something went wrong please\ntry again"
                            : error,
                        child: DotsProgressButton(
                          text: "Try Again",
                          isRectangularBorder: true,
                          buttonBackgroundColor: const Color(0xffF04646),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        showLeftSideButton: false,
                      );
                    },
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 40,
                  ),
                  SizedBox(
                    height: sizeHeight(context) / 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget popUpWidget(BuildContext context) {
    double size =
        MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
    double dialogHeight = size * 0.4;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        height: dialogHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: (!(context
                                      .read<DrivingLicenseBloc>()
                                      .state
                                      .getData()
                                      ?.data
                                      ?.photo
                                      .isNullOrEmpty() ??
                                  false))
                              ? Image.network(
                                  '$googlePhotoUrl${getBucketName()}$drivingLicencePhoto${context.read<DrivingLicenseBloc>().state.getData()?.data?.photo}'
                                  '',
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                )
                              : Image.asset(
                                  '$icons_path/avatar.png',
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      capitalizedString(context
                              .read<DrivingLicenseBloc>()
                              .state
                              .getData()
                              ?.data
                              ?.nameOnDrivingLicense ??
                          'Not Available'),
                      style: text_style_title13.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      context
                              .read<DrivingLicenseBloc>()
                              .state
                              .getData()
                              ?.data
                              ?.drivingLicenseNo ??
                          'Not Available',
                      style: text_style_title13.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      context
                              .read<DrivingLicenseBloc>()
                              .state
                              .getData()
                              ?.data
                              ?.rtoName ??
                          'Not Available',
                      style: text_style_title13.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Address', style: text_style_para1),
                          const TextSpan(text: ' : ', style: text_style_para1),
                          TextSpan(
                            text: context
                                    .read<DrivingLicenseBloc>()
                                    .state
                                    .getData()
                                    ?.data
                                    ?.permanentAdd ??
                                'Not Available',
                            style: text_style_para1,
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
                              text: 'Current Address', style: text_style_para1),
                          const TextSpan(text: ' : ', style: text_style_para1),
                          TextSpan(
                            text: context
                                    .read<DrivingLicenseBloc>()
                                    .state
                                    .getData()
                                    ?.data
                                    ?.currentAdd ??
                                'Not Available',
                            style: text_style_para1,
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
                            text: 'Gender: ',
                            style: text_style_para1,
                          ),
                          TextSpan(
                            text: context
                                .read<DrivingLicenseBloc>()
                                .state
                                .getData()
                                ?.data
                                ?.gender
                                ?.getGender(),
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
                              text: 'Date of Birth: ', style: text_style_para1),
                          TextSpan(
                            text: context
                                    .read<DrivingLicenseBloc>()
                                    .state
                                    .getData()
                                    ?.data
                                    ?.dob ??
                                'Not Available',
                            style: text_style_title13,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!isLicenceConfirmed)
                      Text(
                        "Please confirm your driving licence details before saving.",
                        style: AppStyle.bodyMedium(context).copyWith(
                            color: Colors.green, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (!isLicenceConfirmed)
                      Row(
                        children: [
                          Expanded(
                            child: DotsProgressButton(
                              isRectangularBorder: true,
                              text: 'Confirm',
                              onPressed: () {
                                setState(() {
                                  isLicenceConfirmed = true;
                                  isLicenceError = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DotsProgressButton(
                              buttonBackgroundColor: Colors.grey,
                              isRectangularBorder: true,
                              text: 'Change',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReasonBuilder extends StatelessWidget {
  final bool? isFromListing;
  final Function()? onUpdateVoterPressed;
  final List<KeyValueResponse>? reasons;
  final Function()? onSuccess;
  final bool isUpdate;
  final bool reasonIsNull;
  final String? reason;
  final Function()? isSelectedReasonOther;

  const ReasonBuilder({
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
      ignoring: context.watch<UpdateVisitorInfoBloc>().state is Progress,
      child: FormDropDownWidget(
        isNull: reasonIsNull,
        isRequired: true,
        removeValue: () {
          context.read<UpdateVisitorInfo>().reason = null;
          context.read<UpdateVisitorInfo>().reasonFk = null;
        },
        errorMessage: "Please select Reason",
        dropdownFirstItemName: 'Select Reason',
        titles: reasons ?? [],
        title: reason ?? '',
        onTap: (data) {
          if (!(data.label.isNullOrEmpty())) {
            context.read<UpdateVisitorInfo>().reason = data.label;
            context.read<UpdateVisitorInfo>().reasonFk = data.value;
            if (context.read<UpdateVisitorInfo>().reasonFk != 3) {
              print('yaha aaya');
              context.read<UpdateVisitorInfo>().briefReason = null;
            }
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
