import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_time_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/title_full_name.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/widgets/upload_documents.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/visitors_update_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/update_visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/Widget/gender_bloodgroup.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/Widget/reson_builder.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_update_builder%20.dart';
import 'package:image_picker/image_picker.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:intl/intl.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart'
    as string_ext;
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';

class VisitorEditForm extends StatefulWidget {
  final Visitor? visitor;
  final bool isUpdate;
  final List<KeyValueResponse>? titles;
  final List<KeyValueResponse>? reasonVisit;
  final List<KeyValueResponse>? bloodGroup;
  final int? businessType;
  final bool isFromScan;

  const VisitorEditForm({
    super.key,
    this.titles,
    this.visitor,
    this.bloodGroup,
    this.reasonVisit,
    this.isUpdate = false,
    this.businessType,
    this.isFromScan = false,
  });

  @override
  _VisitorEditFormState createState() => _VisitorEditFormState();
}

class _VisitorEditFormState extends State<VisitorEditForm> {
  XFile? profilePhoto;
  bool isTitleNull = false;
  bool firstNameNotValid = false;
  bool hasFocus = false;
  bool reasonIsNull = false;
  String? countryFk;
  XFile? passportPhoto;
  XFile? passportPhoto2;
  bool passportPhotoMsg = false;
  XFile? visaPhoto;
  bool visaPhotoMsg = false;
  bool dobNull = false;
  bool visaExpiryNull = false;
  bool genderNull = false;
  bool bloodGroupNull = false;

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year != date2.year) {
      return date1.year < date2.year;
    } else if (date1.month != date2.month) {
      return date1.month < date2.month;
    } else {
      return date1.day < date2.day;
    }
  }

  bool checkFirstNameIsNull() {
    if (context.read<UpdateVisitor>().fkTitle == null) {
      isTitleNull = true;
    } else {
      isTitleNull = false;
    }
    if (context.read<UpdateVisitor>().fullName.isNullOrEmpty()) {
      firstNameNotValid = true;
    } else {
      firstNameNotValid = false;
    }

    setState(() {});

    if (isTitleNull || firstNameNotValid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UpdateVisitor>().visitorId = widget.visitor?.id;
    context.read<UpdateVisitor>().visitorFk = widget.visitor?.visitorFk;
    context.read<UpdateVisitor>().email = widget.visitor?.email;
    context.read<UpdateVisitor>().profilePhoto = widget.visitor?.image;
    context.read<UpdateVisitor>().fkTitle = widget.visitor?.fkTitle;
    context.read<UpdateVisitor>().title = widget.visitor?.title;
    context.read<UpdateVisitor>().visaNumber = widget.visitor?.visaNumber;
    context.read<UpdateVisitor>().visaExpiryDate =
        widget.visitor?.visaExpiryDate;
    context.read<UpdateVisitor>().bloodGrpValue = widget.visitor?.bloodGrp;
    context.read<UpdateVisitor>().bloodGrpFk = widget.visitor?.bloodGrpFk;
    context.read<UpdateVisitor>().gender = widget.visitor?.gender;
    context.read<UpdateVisitor>().reason = widget.visitor?.reasonValue;
    context.read<UpdateVisitor>().otherReason = widget.visitor?.visitingReason;

    context.read<UpdateVisitor>().reasonFk = widget.visitor?.visitingReasonFk;
    context.read<UpdateVisitor>().roomNo = widget.visitor?.roomNo;
    context.read<UpdateVisitor>().visitorType = widget.visitor?.visitorType;
    context.read<UpdateVisitor>().dateOfBirth = widget.visitor?.birthDate;
    context.read<UpdateVisitor>().fullName = capitalizedString([
      widget.visitor?.firstName,
      widget.visitor?.middleName,
      widget.visitor?.lastName,
    ].where((part) => part != null && part.isNotEmpty).join(' '));
    context.read<UpdateVisitor>().businessType = widget.businessType;
  }

  @override
  Widget build(BuildContext context) {
    print("Edit form");
    print(widget.visitor?.visitingReason);
    print(context.read<UpdateVisitor>().otherReason);
    print(widget.businessType);

    return IgnorePointer(
      ignoring: context.watch<UpdateVisitorsBloc>().state is Progress,
      child: Padding(
        padding: EdgeInsets.only(
          top: sizeHeight(context) / 60,
          left: 10,
          right: 10,
          bottom: sizeHeight(context) / 60,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              child: FormBuilder(
                key: context.read<GlobalKey<FormBuilderState>>(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      uploadImage(),
                      SizedBox(
                        height: sizeHeight(context) / 30,
                      ),
                      BlocProvider(
                        create: (context) => ValidatorOnChanged(),
                        child: BlocBuilder<ValidatorOnChanged, String>(
                          builder: (context, state) {
                            return TitleAndFirstNameWidget(
                              isItEnabled: context
                                      .watch<UpdateVisitorsBloc>()
                                      .state is Progress
                                  ? false
                                  : true,
                              isEnable: context
                                      .watch<UpdateVisitorsBloc>()
                                      .state is Progress
                                  ? false
                                  : true,
                              state: state,
                              onChanged: (name) {
                                String? fullName;
                                if (name.isNotEmpty) {
                                  fullName = name.trimLeft();
                                  fullName = name.trimRight();
                                }
                                context
                                    .read<ValidatorOnChanged>()
                                    .validateFullName(
                                      fullName ?? '',
                                    );

                                context.read<UpdateVisitor>().fullName =
                                    fullName; // First name
                              },
                              validator: (value) {
                                if (value.isNullOrEmpty()) {
                                  firstNameNotValid = true;
                                  setState(() {});
                                }
                                if (!(value.isNullOrEmpty())) {
                                  int spaceCount = value!.split(' ').length - 1;
                                  if (spaceCount == 0) {
                                    firstNameNotValid = true;
                                    setState(() {});
                                  } else if (spaceCount >= 1 &&
                                      spaceCount <= 3) {
                                    firstNameNotValid = false;
                                  } else if (spaceCount > 3) {
                                    firstNameNotValid = true;
                                    setState(() {});
                                  }
                                }
                                return null;
                              },
                              isTitleNull: isTitleNull,
                              isFirstNameNotValid: firstNameNotValid,
                              onTap: (data) {
                                context.read<UpdateVisitor>().fkTitle =
                                    data.value;
                                context.read<UpdateVisitor>().title =
                                    data.label;
                              },
                              isUpdate: true,
                              initialValue: capitalizedString(
                                  (context.read<UpdateVisitor>().fullName ??
                                      '')),
                              titles: widget.titles,
                              title: context.read<UpdateVisitor>().fkTitle,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: sizeHeight(context) / 60,
                      ),
                      if (widget.visitor?.visitorType ==
                          2) // foreign visitors only
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: BlocProvider(
                                create: (context) => ValidatorOnChanged(),
                                child: BlocBuilder<ValidatorOnChanged, String>(
                                  builder: (context, state) => AddFormField(
                                    isEnable: context
                                            .watch<UpdateVisitorsBloc>()
                                            .state is Progress
                                        ? false
                                        : true,
                                    errorMsg: state,
                                    isRequired: true,
                                    hintText: 'Enter Your Visa Number',
                                    label: 'Visa Number',
                                    maxLength: 30,
                                    maxLines: 1,
                                    initialValue: context
                                        .read<UpdateVisitor>()
                                        .visaNumber,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[A-Z0-9]')),
                                    ],
                                    onChanged: (visa) {
                                      context.read<UpdateVisitor>().visaNumber =
                                          visa;
                                      FormErrorBuilder
                                          .validateFormAndShowErrors(context);
                                    },
                                    validator: (value) {
                                      if (value?.isEmpty ?? false) {
                                        return 'Visa number is required';
                                      }
                                      return null; // Return null if validation passes
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DateTimeField(
                                    minYear: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day - 1),
                                    initialValue: string_ext.dateTimeFromString(
                                      context
                                          .watch<UpdateVisitor>()
                                          .visaExpiryDate,
                                    ),
                                    setValue: (date) {
                                      if (date != null) {
                                        if (isSameDate(date, DateTime.now())) {
                                          context
                                              .read<UpdateVisitor>()
                                              .visaExpiryDate = null;
                                          visaExpiryNull = true;
                                        } else {
                                          context
                                                  .read<UpdateVisitor>()
                                                  .visaExpiryDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date);
                                          visaExpiryNull = false;
                                        }
                                        setState(() {});
                                      }
                                    },
                                    isReadOnly: false,
                                    isEnabled: context
                                            .watch<UpdateVisitorsBloc>()
                                            .state is Progress
                                        ? false
                                        : true,
                                    isRequired: true,
                                    label: 'Valid Through',
                                    value: string_ext.dateTimeFromString(context
                                        .watch<UpdateVisitor>()
                                        .visaExpiryDate),
                                  ),
                                  if (visaExpiryNull)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 10),
                                      child: Text(
                                        "Please select Visa Expiry Date",
                                        style: AppStyle.errorStyle(context),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FormFieldLabel(
                                  label: 'Gender',
                                  isRequired: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GenderDropdownEdit(
                                  initialValue: context
                                      .watch<UpdateVisitor>()
                                      .gender
                                      ?.getGender(),
                                  isIsEnable: context
                                          .watch<UpdateVisitorsBloc>()
                                          .state is Progress
                                      ? false
                                      : true,
                                  isGenderNull: genderNull,
                                  genders: [
                                    KeyValueResponse(value: 1, label: 'Male'),
                                    KeyValueResponse(value: 2, label: 'Female'),
                                    KeyValueResponse(value: 3, label: 'Other'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DateTimeField(
                                  isRequired: true,
                                  maxYear: DateTime.now()
                                      .add(const Duration(days: 1)),
                                  initialValue: string_ext.dateTimeFromString(
                                    context.watch<UpdateVisitor>().dateOfBirth,
                                  ),
                                  setValue: (date) {
                                    if (date != null) {
                                      context
                                              .read<UpdateVisitor>()
                                              .dateOfBirth =
                                          DateFormat('yyyy-MM-dd').format(date);
                                      dobNull = false;

                                      setState(() {});
                                    }
                                  },
                                  isReadOnly: false,
                                  isDOB: true,
                                  isEnabled: context
                                          .watch<UpdateVisitorsBloc>()
                                          .state is Progress
                                      ? false
                                      : true,
                                  label: 'DOB',
                                  value: string_ext.dateTimeFromString(
                                    context.watch<UpdateVisitor>().dateOfBirth,
                                  ),
                                ),
                                if (dobNull)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 10),
                                    child: Text(
                                      "Please select Date of Birth",
                                      style: AppStyle.errorStyle(context),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizeHeight(context) / 60,
                      ),
                      widget.isFromScan
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FormFieldLabel(
                                  label: 'Blood Group',
                                  isRequired: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                BloodGrpDropDownEdit(
                                  isIsEnable: context
                                          .watch<UpdateVisitorsBloc>()
                                          .state is Progress
                                      ? false
                                      : true,
                                  isBloodAGrpNull: bloodGroupNull,
                                  initialValue: context
                                      .watch<UpdateVisitor>()
                                      .bloodGrpValue,
                                  bloodGrps: widget.bloodGroup,
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormFieldLabel(
                                        label: 'Blood Group',
                                        isRequired: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        child: BloodGrpDropDownEdit(
                                          isIsEnable: context
                                                  .watch<UpdateVisitorsBloc>()
                                                  .state is Progress
                                              ? false
                                              : true,
                                          isBloodAGrpNull: bloodGroupNull,
                                          initialValue: context
                                              .watch<UpdateVisitor>()
                                              .bloodGrpValue,
                                          bloodGrps: widget.bloodGroup,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AddFormField(
                                        label: widget.businessType == 2
                                            ? "Car / Bike' Number"
                                            : 'Room Number',
                                        maxLines: 1,
                                        isRequired: true,
                                        initialValue: widget.visitor?.roomNo,
                                        isEnable: context
                                                .watch<UpdateVisitorsBloc>()
                                                .state is Progress
                                            ? false
                                            : true,
                                        hintText: widget.businessType == 2
                                            ? "Enter Car / Bike' Number"
                                            : "Enter Room Number",
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[A-Z0-9]')),
                                        ],
                                        onChanged: (value) {
                                          context.read<UpdateVisitor>().roomNo =
                                              value;
                                          FormErrorBuilder
                                              .validateFormAndShowErrors(
                                                  context);
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return 'Please enter ${widget.businessType == 2 ? 'Car / Bike' : 'Room'} number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                      SizedBox(
                        height: sizeHeight(context) / 60,
                      ),
                      const FormFieldLabel(
                        label: 'Reason To Visit',
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReasonBuilderEdit(
                        isIsEnable: context.watch<UpdateVisitorsBloc>().state
                                is Progress
                            ? false
                            : true,
                        reasons: widget.reasonVisit ?? [],
                        reason: context.watch<UpdateVisitor>().reason,
                        reasonIsNull: reasonIsNull,
                        isSelectedReasonOther: () {
                          setState(() {});
                          // FormErrorBuilder.validateFormAndShowErrors(context);
                        },
                      ),
                      if (context.watch<UpdateVisitor>().reason == "Other")
                        SizedBox(
                          height: sizeHeight(context) / 120,
                        ),
                      if (context.watch<UpdateVisitor>().reason == "Other")
                        AddFormField(
                          isRequired: true,
                          isEnable: context.watch<UpdateVisitorsBloc>().state
                                  is Progress
                              ? false
                              : true,
                          hintText: "Enter Reason",
                          initialValue:
                              context.read<UpdateVisitor>().otherReason,
                          onChanged: (value) {
                            context.read<UpdateVisitor>().otherReason = value;
                            FormErrorBuilder.validateFormAndShowErrors(context);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return 'Please enter reason to visit';
                            }
                            return null;
                          },
                        ),
                      SizedBox(
                        height: sizeHeight(context) / 60,
                      ),
                      BlocProvider(
                        create: (context) => ValidatorOnChanged(),
                        child: BlocBuilder<ValidatorOnChanged, String>(
                            builder: (context, state) {
                          return AddFormField(
                            isEnable: context.read<UpdateVisitorsBloc>().state
                                    is Progress
                                ? false
                                : true,
                            keyboardType: TextInputType.emailAddress,
                            initialValue: widget.visitor?.email,
                            maxLength: 50,
                            errorMsg: state,
                            hintText: 'Enter Email Id',
                            label: ' Email Id',
                            onChanged: (email) {
                              context.read<UpdateVisitor>().email = email;
                              context.read<ValidatorOnChanged>().validateEmail(
                                    email,
                                  );
                            },
                            validator: (value) {
                              if (widget.visitor?.visitorType == 2) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter Email Id';
                                } else {
                                  if (EmailValidator.validate(value ?? '') ==
                                      false) {
                                    return 'Email address is invalid';
                                  }
                                }
                                return null;
                              } else {
                                return null;
                              }
                            },
                          );
                        }),
                      ),
                      if (widget.visitor?.visitorType == 2)
                        SizedBox(
                          height: sizeHeight(context) / 40,
                        ),
                      if (widget.visitor?.visitorType == 2)
                        UploadVisitorDocuments(
                          isEnable: context.read<UpdateVisitorsBloc>().state
                                  is Progress
                              ? false
                              : true,
                          passportPhoto: passportPhoto,
                          passportPhoto2: passportPhoto2,
                          visaPhoto: visaPhoto,
                          passportPhotoMsg: passportPhotoMsg,
                          visaPhotoMsg: visaPhotoMsg,
                          passportFront: widget.visitor?.passportFrontPhoto,
                          passportBack: widget.visitor?.passportBackPhoto,
                          visaPhotoApi: widget.visitor?.visaPhoto,
                          onPassportPhotoChanged: (image, msg) {
                            setState(() {
                              passportPhoto = image;
                              passportPhotoMsg = msg;
                            });
                          },
                          onPassport2PhotoChanged: (image, msg) {
                            setState(() {
                              passportPhoto2 = image;
                            });
                          },
                          onVisaPhotoChanged: (image, msg) {
                            setState(() {
                              visaPhoto = image;
                              visaPhotoMsg = msg;
                            });
                          },
                        ),
                      SizedBox(
                        height: sizeHeight(context) / 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: UpdateVisitorsBuilder(
                            isOldVisitor: true,
                            onUpdateUserDetailsPressed: () {
                              checkFirstNameIsNull();
                              setState(() {
                                if (widget.visitor?.passportFrontPhoto
                                        .isNullOrEmpty() ??
                                    false) {
                                  if (passportPhoto?.path == null ||
                                      (passportPhoto?.path.isEmpty ?? false)) {
                                    passportPhotoMsg = true;
                                  } else {
                                    passportPhotoMsg = false;
                                  }
                                }
                                if (widget.visitor?.visaPhoto.isNullOrEmpty() ??
                                    false) {
                                  if (visaPhoto?.path == null ||
                                      (visaPhoto?.path.isEmpty ?? false)) {
                                    visaPhotoMsg = true;
                                  } else {
                                    visaPhotoMsg = false;
                                  }
                                }
                                if (context.read<UpdateVisitor>().reasonFk ==
                                    null) {
                                  reasonIsNull = true;
                                } else {
                                  reasonIsNull = false;
                                }
                                if (context.read<UpdateVisitor>().dateOfBirth ==
                                    null) {
                                  dobNull = true;
                                } else {
                                  dobNull = false;
                                }
                                if (context
                                        .read<UpdateVisitor>()
                                        .visaExpiryDate ==
                                    null) {
                                  visaExpiryNull = true;
                                } else {
                                  visaExpiryNull = false;
                                }
                                if (context.read<UpdateVisitor>().gender ==
                                    null) {
                                  genderNull = true;
                                } else {
                                  genderNull = false;
                                }
                                if (context.read<UpdateVisitor>().bloodGrpFk ==
                                    null) {
                                  bloodGroupNull = true;
                                } else {
                                  bloodGroupNull = false;
                                }
                              });
                              if (FormErrorBuilder.validateFormAndShowErrors(
                                      context) &&
                                  !checkFirstNameIsNull() &&
                                  (widget.visitor?.visitorType == 2
                                      ? (widget.visitor?.passportFrontPhoto
                                                      .isNullOrEmpty() ??
                                                  false
                                              ? !passportPhotoMsg
                                              : true) &&
                                          (widget.visitor?.visaPhoto
                                                      .isNullOrEmpty() ??
                                                  false
                                              ? !visaPhotoMsg
                                              : true) &&
                                          !visaExpiryNull
                                      : true) &&
                                  !reasonIsNull &&
                                  !dobNull &&
                                  !genderNull &&
                                  !bloodGroupNull) {
                                context
                                    .read<UpdateVisitorsBloc>()
                                    .updateVisitorsDetails(
                                      passportFirstPhoto:
                                          passportPhoto ?? XFile(''),
                                      passportLastPhoto:
                                          passportPhoto2 ?? XFile(''),
                                      visaPhoto: visaPhoto ?? XFile(''),
                                      profilePhoto: profilePhoto ?? XFile(''),
                                      visitorsUpdatedData:
                                          context.read<UpdateVisitor>().toJson,
                                    );
                              }
                            }),
                      ),
                      SizedBox(
                        height: 10.h,
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

  Widget uploadImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (profilePhoto?.path.isNotEmpty ?? false)
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: background_dark_grey),
            height: appSize(context: context, unit: 10) / 2.5,
            width: appSize(context: context, unit: 10) / 2.5,
            child: ClipOval(
              child: (profilePhoto?.name.contains(".png") ?? false) ||
                      (profilePhoto?.name.contains(".jpg") ?? false) ||
                      (profilePhoto?.name.contains(".jpeg") ?? false)
                  ? Image.file(
                      File(
                        profilePhoto?.path ?? '',
                      ),
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        if (profilePhoto == null)
          CachedNetworkImage(
            fadeInDuration: const Duration(seconds: 0),
            fadeOutDuration: const Duration(seconds: 0),
            placeholderFadeInDuration: const Duration(seconds: 0),
            width: appSize(context: context, unit: 10) / 2.5,
            height: appSize(context: context, unit: 10) / 2.5,
            fit: BoxFit.cover,
            imageUrl: !(widget.visitor?.image.isNullOrEmpty() ?? false)
                ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${widget.visitor?.image}'
                : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${widget.visitor?.aadharImage}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background_dark_grey,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: background_dark_grey,
                ),
                padding:
                    EdgeInsets.all(appSize(context: context, unit: 10) / 10),
                width: appSize(context: context, unit: 10) / 8.5,
                height: appSize(context: context, unit: 10) / 8.5,
                child: const CircularProgressIndicator()),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 50,
              backgroundColor: background_dark_grey,
              child: Image.asset(
                fit: BoxFit.contain,
                '$icons_path/gallery.png',
                width: appSize(context: context, unit: 10) / 6.0,
                height: appSize(context: context, unit: 10) / 6.0,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: UploadImage(
            isEnable: context.watch<UpdateVisitorsBloc>().state is Progress
                ? false
                : true,
            onImageSelected: (image) {
              setState(() {
                profilePhoto = image;
              });
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Center(
                  child: Text(
                    'Upload Photo',
                    style: AppStyle.bodyLarge(context).copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
