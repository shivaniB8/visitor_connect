import 'dart:convert';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/constant/constant_data.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_success_page.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_time_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/title_full_name.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/qrCode.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/add_foreigner_visitor_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/blood_grp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/check_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/reason_visit_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/visitor_document_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/aadhar_photo_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_foreigner_visitor_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/check_mobile_number_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/widgets/gender_dropdown.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/widgets/upload_documents.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'add_visitor_second_screen.dart';
import 'model/add_indian_visitor.dart';

class AddForeignVisitor extends StatefulWidget {
  const AddForeignVisitor({
    super.key,
  });

  @override
  State<AddForeignVisitor> createState() => _AddForeignVisitorState();
}

class _AddForeignVisitorState extends State<AddForeignVisitor> {
  String? mobileNumber;
  String? countryName;
  String? passportcountryName;
  String? countryFk;
  Country? selectedCountry;
  Country? phoneCode;
  String? errorMsg;
  String? errorMsgCountry = '';
  String? errorMsgPassportCountry;
  bool fileError = false;
  final focusNodeFullName = FocusNode();
  bool isTitleNull = false;
  bool firstNameNotValid = false;
  bool reasonIsNull = false;
  XFile? passportPhoto;
  XFile? passportPhoto2;
  bool passportPhotoMsg = false;
  XFile? visaPhoto;
  bool visaPhotoMsg = false;
  XFile? profilePhoto;
  bool dobNull = false;
  bool visaExpiryNull = false;
  bool passPortExpiryNull = false;
  bool isCheckingMobileNumber = true;
  bool genderNull = false;
  bool bloodGroupNull = false;
  String? businessType;
  int? _selectedValue;
  bool businessTypeIsNull = false;
  ForeignerData? foreignerData;

  @override
  void initState() {
    context.read<TitlesBloc>().getTitles();
    context.read<BloodGrpBloc>().getBloodGrps();
    context.read<ReasonToVisitBloc>().getReasonToVisit();

    context.read<AddForeignerVisitor>().dateOfBirth = null;
    context.read<AddForeignerVisitor>().passportExpiryDate = null;
    context.read<AddForeignerVisitor>().visaExpiryDate = null;
    String? jsonString = SharedPrefs.getString(keyUserData);

    if (jsonString != null) {
      Map<String, dynamic> userData = jsonDecode(jsonString);
      businessType = userData['business_type'];
      if (businessType == "1") {
        _selectedValue = 1;
      } else if (businessType == "2") {
        _selectedValue = 2;
      } else {
        _selectedValue = null;
      }
    }
    super.initState();
  }

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
    if (context.read<AddForeignerVisitor>().title == null) {
      isTitleNull = true;
    } else {
      isTitleNull = false;
    }
    if (context.read<AddForeignerVisitor>().fullName.isNullOrEmpty()) {
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
  Widget build(BuildContext context) {
    print("foreignerData");
    print(foreignerData?.visitorHistoryId);
    print(foreignerData);
    return IgnorePointer(
      ignoring: context.read<CheckMobileNumberBloc>().state is Progress ||
          context.read<AddForeignerVisitorBloc>().state is Progress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomImageAppBar(
          showEditIcon: false,
          showSettings: false,
          title: 'Add Visitor Details',
          context: context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12,
            ),
            child: Column(
              children: [
                FormBuilder(
                  key: context.read<GlobalKey<FormBuilderState>>(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (profilePhoto?.path.isNotEmpty ?? false)
                                SizedBox(
                                  width:
                                      appSize(context: context, unit: 10) / 2.5,
                                  height:
                                      appSize(context: context, unit: 10) / 2.5,
                                  child:
                                      (profilePhoto?.name.contains(".png") ??
                                                  false) ||
                                              (profilePhoto?.name
                                                      .contains(".jpg") ??
                                                  false) ||
                                              (profilePhoto?.name
                                                      .contains(".jpeg") ??
                                                  false)
                                          ? ClipOval(
                                              child: Image.file(
                                                File(profilePhoto?.path ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                ),
                              if (profilePhoto == null)
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: background_dark_grey,
                                  child: Image.asset(
                                    fit: BoxFit.contain,
                                    '$icons_path/gallery.png',
                                    width: appSize(context: context, unit: 10) /
                                        6.0,
                                    height:
                                        appSize(context: context, unit: 10) /
                                            6.0,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          UploadImage(
                            isEnable: context
                                    .watch<AddForeignerVisitorBloc>()
                                    .state is Progress
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Center(
                                  child: Text(
                                    'Click Photo',
                                    style: AppStyle.titleLarge(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const FormFieldLabel(
                        label: 'Country',
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Container(
                          height: appSize(context: context, unit: 10) / 4.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: textFeildFillColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                countryName ?? 'Select Country',
                                style: AppStyle.bodyMedium(context).copyWith(
                                  color: ((context
                                                      .read<
                                                          CheckMobileNumberBloc>()
                                                      .state is! Progress &&
                                                  !(context
                                                          .read<
                                                              CheckMobileNumberBloc>()
                                                          .state
                                                          .getData()
                                                          ?.success ??
                                                      false)) ||
                                              (context
                                                      .read<
                                                          CheckMobileNumberBloc>()
                                                      .state
                                                      .getData()
                                                      ?.status ==
                                                  200)) &&
                                          selectedCountry != null
                                      ? text_color
                                      : gray_color,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (context.read<CheckMobileNumberBloc>().state
                                      is! Progress &&
                                  !(context
                                          .read<CheckMobileNumberBloc>()
                                          .state
                                          .getData()
                                          ?.success ??
                                      false) ||
                              context
                                      .read<CheckMobileNumberBloc>()
                                      .state
                                      .getData()
                                      ?.status ==
                                  200) {
                            showCountryPicker(
                              exclude: ['IN'],
                              countryListTheme: CountryListThemeData(
                                padding: const EdgeInsets.all(10),
                                bottomSheetHeight:
                                    MediaQuery.of(context).size.height / 2,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              useSafeArea: true,
                              context: context,
                              showPhoneCode: true,
                              showSearch: true,
                              onSelect: (Country country) {
                                setState(
                                  () {
                                    countryName =
                                        country.displayNameNoCountryCode;
                                    selectedCountry = country;

                                    context
                                            .read<AddForeignerVisitor>()
                                            .countyCode =
                                        selectedCountry?.phoneCode;
                                    context
                                            .read<AddForeignerVisitor>()
                                            .countryName =
                                        countryName?.split(" ")[0];

                                    int index = counties.indexWhere((element) =>
                                        element['maj4'] ==
                                        context
                                            .read<AddForeignerVisitor>()
                                            .countyCode);

                                    countryFk = (index + 1).toString();

                                    context
                                        .read<AddForeignerVisitor>()
                                        .countryFk = countryFk;
                                    errorMsgCountry = '';
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                      if (errorMsgCountry != '')
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 7),
                          child: Text(
                            errorMsgCountry.toString(),
                            style: AppStyle.errorStyle(context),
                          ),
                        ),
                      const SizedBox(height: 15),
                      BlocProvider(
                        create: (context) => ValidatorOnChanged(),
                        child: BlocBuilder<ValidatorOnChanged, String>(
                          builder: (context, state) {
                            return AddFormField(
                              isRequired: true,
                              onPrefixClick: () async {
                                if (context.read<CheckMobileNumberBloc>().state
                                            is! Progress &&
                                        !(context
                                                .read<CheckMobileNumberBloc>()
                                                .state
                                                .getData()
                                                ?.success ??
                                            false) ||
                                    (context
                                            .read<CheckMobileNumberBloc>()
                                            .state
                                            .getData()
                                            ?.status ==
                                        200)) {
                                  showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                      padding: const EdgeInsets.all(10),
                                      bottomSheetHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    useSafeArea: true,
                                    context: context,
                                    showPhoneCode: true,
                                    showSearch: true,
                                    onSelect: (Country country) {
                                      setState(
                                        () {
                                          phoneCode = country;

                                          context
                                                  .read<AddForeignerVisitor>()
                                                  .mobileNumberCountryCode =
                                              phoneCode?.phoneCode;
                                          String? newMobilew =
                                              '+${phoneCode?.phoneCode} $mobileNumber';
                                          context
                                              .read<ValidatorOnChanged>()
                                              .validateForeginMobile(
                                                  newMobilew, context);
                                          if (!isCheckingMobileNumber &&
                                              context
                                                      .read<
                                                          CheckMobileNumberBloc>()
                                                      .state
                                                      .getData()
                                                      ?.status ==
                                                  200) {
                                            isCheckingMobileNumber = true;
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                              isEnable: (context
                                          .read<CheckMobileNumberBloc>()
                                          .state is! Progress &&
                                      !(context
                                              .read<CheckMobileNumberBloc>()
                                              .state
                                              .getData()
                                              ?.success ??
                                          false) ||
                                  (context
                                          .read<CheckMobileNumberBloc>()
                                          .state
                                          .getData()
                                          ?.status ==
                                      200)),
                              countryCode: phoneCode?.phoneCode ?? '0',
                              isMobileNumber: true,
                              errorMsg: state,
                              hintText: "Enter Your Mobile Number",
                              label: "Mobile No.",
                              keyboardType: TextInputType.number,
                              maxLength: 30,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              validator: (value) {
                                String? newMobilew =
                                    '+${selectedCountry?.phoneCode} $value';
                                if (value?.isEmpty ?? false) {
                                  return 'Please enter Mobile Number';
                                } else if (!(newMobilew.startsWith('+'))) {
                                  return 'Please select country code';
                                } else if (!RegExp(
                                        r'^[+]{1}(?:[0-9\-\\(\\)\\/.]\s?){6,15}[0-9]{1}$')
                                    .hasMatch(newMobilew)) {
                                  return 'Please enter valid Mobile Number';
                                }
                                return null;
                              },
                              onChanged: (mobileNo) {
                                mobileNumber = mobileNo;
                                String? newMobilew = phoneCode != null
                                    ? '+${phoneCode?.phoneCode} $mobileNo'
                                    : mobileNo;
                                context
                                    .read<ValidatorOnChanged>()
                                    .validateForeginMobile(newMobilew, context);

                                context
                                    .read<AddForeignerVisitor>()
                                    .mobileNumber = mobileNo;
                                FormErrorBuilder.validateFormAndShowErrors(
                                    context);
                                if (!isCheckingMobileNumber &&
                                    context
                                            .read<CheckMobileNumberBloc>()
                                            .state
                                            .getData()
                                            ?.status ==
                                        200) {
                                  setState(() {
                                    isCheckingMobileNumber = true;
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: context
                                    .read<CheckMobileNumberBloc>()
                                    .state
                                    .getData()
                                    ?.status ==
                                201
                            ? 0
                            : 10,
                      ),
                      if (context.read<CheckMobileNumberBloc>().state
                                  is! Progress &&
                              !(context
                                      .read<CheckMobileNumberBloc>()
                                      .state
                                      .getData()
                                      ?.success ??
                                  false) ||
                          isCheckingMobileNumber)
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CheckMobileNumberBuilder(
                            appError: (v) {
                              if (v) {
                                setState(() {});
                              }
                            },
                            onSearch: () {
                              FocusScope.of(context).unfocus();
                              if (FormErrorBuilder.validateFormAndShowErrors(
                                      context) &&
                                  phoneCode != null) {
                                if (countryName.isNullOrEmpty()) {
                                  errorMsgCountry = "Please select country";
                                  setState(() {});
                                  return;
                                } else {
                                  errorMsgCountry = "";
                                }
                                context
                                    .read<CheckMobileNumberBloc>()
                                    .checkMobileNumber(
                                      mobileNo: mobileNumber ?? '',
                                    );
                              } else {
                                if (countryName.isNullOrEmpty()) {
                                  errorMsgCountry = "Please select country";
                                  setState(() {});
                                } else {
                                  errorMsgCountry = "";
                                  setState(() {});
                                }
                              }
                            },
                            onSuccess: () {
                              setState(() {
                                isCheckingMobileNumber = false;
                              });
                            },
                            error: (error) {
                              AppActionDialog.showActionDialog(
                                image: "$icons_path/ErrorIcon.png",
                                context: context,
                                title: "Error occurred",
                                subtitle: error
                                        .toLowerCase()
                                        .contains("exception")
                                    ? "Something went wrong please\ntry again"
                                    : error,
                                child: DotsProgressButton(
                                  text: "Try Again",
                                  isRectangularBorder: true,
                                  buttonBackgroundColor:
                                      const Color(0xffF04646),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                showLeftSideButton: false,
                              );
                            },
                          ),
                        ),
                      checkMobileFunction(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// new added passportIssue section
  Widget passportIssueCountryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldLabel(
          label: 'Passport Issuing Country',
          isRequired: true,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.061,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        passportcountryName ??
                            'Select Passport Issuing Country',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down_sharp,
                        size: 20, color: Colors.black),
                  ],
                ),
              ),
            ),
            onTap: () {
              showCountryPicker(
                countryListTheme: CountryListThemeData(
                  padding: const EdgeInsets.all(10),
                  bottomSheetHeight: MediaQuery.of(context).size.height / 2,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                useSafeArea: true,
                context: context,
                showPhoneCode: true,
                showSearch: true,
                onSelect: (Country country) {
                  setState(
                    () {
                      // passportcountryName = country.displayNameNoCountryCode;
                      // context.read<AddForeignerVisitor>().passportcountyCode = country.phoneCode;
                      // context.read<AddForeignerVisitor>().passportcountryName = passportcountryName;
                      // int index = (counties.indexWhere((element) =>
                      //         element['maj4'] ==
                      //         context.read<AddForeignerVisitor>().passportcountyCode)) +
                      //     1;
                      // context.read<AddForeignerVisitor>().passportcountryFk = index.toString();
                      // // setState(() {
                      // // errorMsgPassportCountry = "";
                      // // });
                    },
                  );
                },
              );
            }),
        errorMsgPassportCountry.isNullOrEmpty()
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMsgPassportCountry!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget passportExpiryDate() {
    return DateTimeField(
      minYear: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      initialValue: dateTimeFromString(
        context.read<AddForeignerVisitor>().passportExpiryDate,
      ),
      setValue: (date) {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime currentDate = DateTime.now();
        if (date != null) {
          if (isSameDate(date, currentDate)) {
            context.read<AddForeignerVisitor>().passportExpiryDate = null;
            passPortExpiryNull = true;
          } else {
            context.read<AddForeignerVisitor>().passportExpiryDate =
                DateFormat('yyyy-MM-dd').format(date);
            passPortExpiryNull = false;
          }
          setState(() {});
        }
      },
      isEnabled: context.watch<AddForeignerVisitorBloc>().state is Progress
          ? false
          : true,
      isRequired: true,
      isReadOnly: false,
      label: 'Valid Through',
      value: dateTimeFromString(
        context.watch<AddForeignerVisitor>().passportExpiryDate,
      ),
    );
  }

  Widget checkMobileFunction() {
    final state = context.watch<CheckMobileNumberBloc>().state;
    if (state is Success &&
        state.getData()?.status == 200 &&
        !isCheckingMobileNumber) {
      return Container(
        decoration: BoxDecoration(
            color: textFeildFillColor,
            border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                Image.asset('$icons_path/avatar.png').image,
                          ),
                        ),
                        Positioned.fill(
                          child: (!(context
                                      .read<CheckMobileNumberBloc>()
                                      .state
                                      .getData()
                                      ?.mobileResponseData
                                      ?.profilePhoto
                                      .isNullOrEmpty() ??
                                  false))
                              ? Image.network(
                                  !(context
                                              .read<CheckMobileNumberBloc>()
                                              .state
                                              .getData()
                                              ?.mobileResponseData
                                              ?.profilePhoto
                                              .isNullOrEmpty() ??
                                          false)
                                      ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.profilePhoto}'
                                      : '',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  '$icons_path/avatar.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (!(context
                          .read<CheckMobileNumberBloc>()
                          .state
                          .getData()
                          ?.mobileResponseData
                          ?.qrImage
                          ?.isNullOrEmpty() ??
                      false))
                    QRCodeWidget(
                      size: appSize(context: context, unit: 10) / 4,
                      qrImage:
                          '${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.qrImage}',
                      showShareButton: true,
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                capitalizedString(context
                        .read<CheckMobileNumberBloc>()
                        .state
                        .getData()
                        ?.mobileResponseData
                        ?.fullName ??
                    "N/A"),
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Passport No. ${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.visitorPassportNumber ?? "Not Available"}',
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'DOB : ${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.dob != null ? AppFunctions.formatDate(context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.dob ?? DateTime.now().toString()) : 'N/A'}',
                style: AppStyle.bodyMedium(context),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
    } else if (state is Success && state.getData()?.status == 201) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///title and fullName
          BlocProvider(
            create: (context) => ValidatorOnChanged(),
            child: BlocBuilder<ValidatorOnChanged, String>(
              builder: (context, state) {
                return TitleAndFirstNameWidget(
                  isItEnabled:
                      context.watch<AddForeignerVisitorBloc>().state is Progress
                          ? false
                          : true,
                  isEnable:
                      context.watch<AddForeignerVisitorBloc>().state is Progress
                          ? false
                          : true,
                  state: state,
                  onChanged: (name) {
                    String? fullName;
                    if (name.isNotEmpty) {
                      firstNameNotValid = false;
                      fullName = name.trimLeft();
                      fullName = name.trimRight();
                    }
                    context.read<ValidatorOnChanged>().validateFullName(
                          fullName ?? '',
                        );
                    context.read<AddForeignerVisitor>().fullName = fullName;
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
                      } else if (spaceCount >= 1 && spaceCount <= 3) {
                        firstNameNotValid = false;
                      } else if (spaceCount > 3) {
                        firstNameNotValid = true;
                        setState(() {});
                      }
                    }
                    return null;
                  },
                  focusNode: focusNodeFullName,
                  isTitleNull: isTitleNull,
                  isFirstNameNotValid: firstNameNotValid,
                  onTap: (title) {
                    if (title.value != 0) {
                      context.read<AddForeignerVisitor>().titleFk = title.value;
                      context.read<AddForeignerVisitor>().title = title.label;
                      setState(() {
                        isTitleNull = false;
                      });
                    } else {
                      context.read<AddForeignerVisitor>().titleFk = null;
                      context.read<AddForeignerVisitor>().title = null;
                      setState(() {
                        isTitleNull = true;
                      });
                    }
                  },
                  isUpdate: true,
                  titles: context.watch<TitlesBloc>().state.getData()?.data,
                  // isItEnabled: true,
                );
              },
            ),
          ),
          // passportIssueCountryWidget(),
          if (context.read<CheckMobileNumberBloc>().state.getData()?.status ==
              201)
            const SizedBox(
              height: 5,
            ),

          ///documents
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: BlocProvider(
                  create: (context) => ValidatorOnChanged(),
                  child: BlocBuilder<ValidatorOnChanged, String>(
                    builder: (context, state) {
                      return AddFormField(
                        isEnable: context.watch<AddForeignerVisitorBloc>().state
                                is Progress
                            ? false
                            : true,
                        errorMsg: state,
                        isRequired: true,
                        maxLength: 30,
                        maxLines: 1,
                        hintText: 'Enter Your Passport Number',
                        label: 'Passport Number',
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Z0-9]')),
                        ],
                        keyboardType: TextInputType.text,
                        onChanged: (passport) {
                          context.read<AddForeignerVisitor>().passportNumber =
                              passport;
                          FormErrorBuilder.validateFormAndShowErrors(context);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            fileError = true;
                            setState(() {});
                            return 'Please enter Passport Number';
                          }
                          fileError = false;
                          setState(() {});
                          return null;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    passportExpiryDate(),
                    if (passPortExpiryNull)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 10),
                        child: Text(
                          "Please select Passport Expiry Date",
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
                child: BlocProvider(
                  create: (context) => ValidatorOnChanged(),
                  child: BlocBuilder<ValidatorOnChanged, String>(
                    builder: (context, state) => AddFormField(
                      isEnable: context.watch<AddForeignerVisitorBloc>().state
                              is Progress
                          ? false
                          : true,
                      errorMsg: state,
                      isRequired: true,
                      hintText: 'Enter Your Visa Number',
                      label: 'Visa Number',
                      maxLength: 30,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                      ],
                      onChanged: (visa) {
                        context.read<AddForeignerVisitor>().visaNumber = visa;
                        FormErrorBuilder.validateFormAndShowErrors(context);
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
                      minYear: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      initialValue: dateTimeFromString(
                        context.watch<AddForeignerVisitor>().visaExpiryDate,
                      ),
                      setValue: (date) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (date != null) {
                          if (isSameDate(date, DateTime.now())) {
                            context.read<AddForeignerVisitor>().visaExpiryDate =
                                null;
                            visaExpiryNull = true;
                          } else {
                            context.read<AddForeignerVisitor>().visaExpiryDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            visaExpiryNull = false;
                          }
                          setState(() {});
                        }
                      },
                      isReadOnly: false,
                      isEnabled: context.watch<AddForeignerVisitorBloc>().state
                              is Progress
                          ? false
                          : true,
                      isRequired: true,
                      label: 'Valid Through',
                      value: dateTimeFromString(
                          context.watch<AddForeignerVisitor>().visaExpiryDate),
                    ),
                    if (visaExpiryNull)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 10),
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
                    GenderDropdown(
                      isIsEnable: context.watch<AddForeignerVisitorBloc>().state
                              is Progress
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
                      maxYear: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      initialValue: dateTimeFromString(
                        context.watch<AddForeignerVisitor>().dateOfBirth,
                      ),
                      setValue: (date) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (date != null) {
                          context.read<AddForeignerVisitor>().dateOfBirth =
                              DateFormat('yyyy-MM-dd').format(date);
                          dobNull = false;
                          setState(() {});
                        }
                      },
                      isReadOnly: false,
                      isDOB: true,
                      isEnabled: context.watch<AddForeignerVisitorBloc>().state
                              is Progress
                          ? false
                          : true,
                      label: 'DOB',
                      value: dateTimeFromString(
                        context.watch<AddForeignerVisitor>().dateOfBirth,
                      ),
                    ),
                    if (dobNull)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 10),
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
          const SizedBox(
            height: 10,
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
                      label: 'Blood Group',
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: BloodGrpDropDown(
                        isIsEnable: context
                                .watch<AddForeignerVisitorBloc>()
                                .state is Progress
                            ? false
                            : true,
                        isBloodAGrpNull: bloodGroupNull,
                        bloodGrps:
                            context.watch<BloodGrpBloc>().state.getData()?.data,
                      ),
                    ),
                  ],
                ),
              ),
              if (businessType != "1,2" && _selectedValue != null)
                const SizedBox(
                  width: 10,
                ),
              if (businessType != "1,2" && _selectedValue != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormFieldLabel(
                        label:
                            _selectedValue == 1 ? 'Room No.' : 'Car / Bike No.',
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AddFormField(
                        maxLines: 1,
                        isRequired: true,
                        isEnable: context.watch<AddForeignerVisitorBloc>().state
                                is Progress
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
                          context.read<AddForeignerVisitor>().roomNo = value;
                          FormErrorBuilder.validateFormAndShowErrors(context);
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const FormFieldLabel(
            label: 'Reason To Visit',
            isRequired: true,
          ),
          const SizedBox(
            height: 5,
          ),
          ReasonBuilder(
            isIsEnable:
                context.watch<AddForeignerVisitorBloc>().state is Progress
                    ? false
                    : true,
            reasons:
                context.watch<ReasonToVisitBloc>().state.getData()?.data ?? [],
            reasonIsNull: reasonIsNull,
            onReasonChange: () {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {});
              FormErrorBuilder.validateFormAndShowErrors(context);
            },
          ),
          if (context.watch<AddForeignerVisitor>().reason == "Other")
            AddFormField(
              isRequired: true,
              isEnable:
                  context.watch<AddForeignerVisitorBloc>().state is Progress
                      ? false
                      : true,
              hintText: "Enter Reason",
              onChanged: (value) {
                context.read<AddForeignerVisitor>().otherReason = value;
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
                      activeColor: context.read<AddForeignerVisitorBloc>().state
                              is Progress
                          ? gray_color
                          : primary_color,
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _selectedValue = value!;
                          businessTypeIsNull = false;
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
                      activeColor: context.read<AddForeignerVisitorBloc>().state
                              is Progress
                          ? gray_color
                          : primary_color,
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _selectedValue = value!;
                          businessTypeIsNull = false;
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
          if (businessType == "1,2" && _selectedValue != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FormFieldLabel(
                    isRequired: true,
                    label: _selectedValue == 1 ? 'Room No.' : 'Car / Bike No.',
                  ),
                ),
                AddFormField(
                  maxLines: 1,
                  isRequired: true,
                  isEnable:
                      context.watch<AddForeignerVisitorBloc>().state is Progress
                          ? false
                          : true,
                  hintText:
                      'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                  ],
                  onChanged: (value) {
                    context.read<AddForeignerVisitor>().roomNo = value;
                    FormErrorBuilder.validateFormAndShowErrors(context);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please Enter ${_selectedValue == 1 ? 'Room' : 'Car / Bike'} No.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          BlocProvider(
            create: (context) => ValidatorOnChanged(),
            child: BlocBuilder<ValidatorOnChanged, String>(
              builder: (context, state) {
                return AddFormField(
                  isRequired: true,
                  isEnable: (context.watch<AddForeignerVisitorBloc>().state
                          is Progress)
                      ? false
                      : true,
                  maxLength: 50,
                  errorMsg: state,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  hintText: 'Enter your Email Id',
                  label: 'Email Id',
                  onChanged: (email) {
                    context.read<ValidatorOnChanged>().validateEmail(email);
                    context.read<AddForeignerVisitor>().email = email;
                    FormErrorBuilder.validateFormAndShowErrors(context);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      if (EmailValidator.validate(value ?? '') == false) {
                        return 'Email address is invalid';
                      }
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          ///documents photos
          UploadVisitorDocuments(
            isEnable: context.watch<AddForeignerVisitorBloc>().state is Progress
                ? false
                : true,
            passportPhoto: passportPhoto,
            passportPhoto2: passportPhoto2,
            visaPhoto: visaPhoto,
            passportPhotoMsg: passportPhotoMsg,
            visaPhotoMsg: visaPhotoMsg,
            onPassportPhotoChanged: (image, msg) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                passportPhoto = image;
                passportPhotoMsg = msg;
              });
            },
            onPassport2PhotoChanged: (image, msg) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                passportPhoto2 = image;
              });
            },
            onVisaPhotoChanged: (image, msg) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                visaPhoto = image;
                visaPhotoMsg = msg;
              });
            },
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AddForeignerVisitorBuilder(
              appError: (v) {
                if (v) {
                  setState(() {});
                }
              },
              onAddVisitorPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                print("selectValue ----------->");
                print(_selectedValue);
                checkFirstNameIsNull();
                // if (passportcountryName.isNullOrEmpty()) {
                //   errorMsgPassportCountry = "Please select passport issuing country";
                //   setState(() {});
                // } else {
                //   errorMsgPassportCountry = "";
                //   setState(() {});
                // }
                setState(() {
                  if (passportPhoto?.path == null ||
                      (passportPhoto?.path.isEmpty ?? false)) {
                    passportPhotoMsg = true;
                  } else {
                    passportPhotoMsg = false;
                  }
                  if (visaPhoto?.path == null ||
                      (visaPhoto?.path.isEmpty ?? false)) {
                    visaPhotoMsg = true;
                  } else {
                    visaPhotoMsg = false;
                  }
                  if (context.read<AddForeignerVisitor>().reasonFk == null) {
                    reasonIsNull = true;
                  } else {
                    reasonIsNull = false;
                  }
                  if (context.read<AddForeignerVisitor>().dateOfBirth == null) {
                    dobNull = true;
                  } else {
                    dobNull = false;
                  }
                  if (context.read<AddForeignerVisitor>().passportExpiryDate ==
                      null) {
                    passPortExpiryNull = true;
                  } else {
                    passPortExpiryNull = false;
                  }
                  if (context.read<AddForeignerVisitor>().visaExpiryDate ==
                      null) {
                    visaExpiryNull = true;
                  } else {
                    visaExpiryNull = false;
                  }
                  if (context.read<AddForeignerVisitor>().gender == null) {
                    genderNull = true;
                  } else {
                    genderNull = false;
                  }
                  if (context.read<AddForeignerVisitor>().bloodGrpFk == null) {
                    bloodGroupNull = true;
                  } else {
                    bloodGroupNull = false;
                  }
                  if (businessType == "1,2" && _selectedValue == null) {
                    businessTypeIsNull = true;
                  } else {
                    businessTypeIsNull = false;
                  }
                });

                if (FormErrorBuilder.validateFormAndShowErrors(context) &&
                    !checkFirstNameIsNull() &&
                    // errorMsgPassportCountry == '' &&
                    !passportPhotoMsg &&
                    !visaPhotoMsg &&
                    !reasonIsNull &&
                    !dobNull &&
                    !passPortExpiryNull &&
                    !visaExpiryNull &&
                    !genderNull &&
                    !bloodGroupNull &&
                    !businessTypeIsNull) {
                  context.read<AddForeignerVisitor>().businessType =
                      _selectedValue;
                  context
                      .read<AddForeignerVisitorBloc>()
                      .addForeignerVisitorManually(
                        passportFirstPhoto: passportPhoto ?? XFile(''),
                        passportLastPhoto: passportPhoto2 ?? XFile(''),
                        profilePhoto: profilePhoto ?? XFile(''),
                        visaPhoto: visaPhoto ?? XFile(''),
                        foreignerVisitor:
                            context.read<AddForeignerVisitor>().toJson,
                      );
                }
              },
              onSuccess: () {
                if (_selectedValue == 2) {
                  print("test-------------->");
                  print(
                      context.read<AddForeignerVisitorBloc>().state.getData());
                  print(context
                      .read<AddForeignerVisitorBloc>()
                      .state
                      .getData()
                      ?.foreignerData
                      ?.id);
                  Navigator.pushReplacement(
                    context,
                    goToRoute(
                      MultiProvider(
                        providers: [
                          Provider<GlobalKey<FormBuilderState>>(
                            create: (_) => GlobalKey<FormBuilderState>(),
                          ),

                          BlocProvider(
                            create: (_) => VisitorDocumentBloc(),
                          ),
                          // Add other providers if needed
                        ],
                        child: AadharPhotoScreen(
                            isForeigner: true,
                            visitorId: context
                                .read<AddForeignerVisitorBloc>()
                                .state
                                .getData()
                                ?.foreignerData
                                ?.visitorFk),
                      ), // Replace with the actual screen you want to navigate to
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    goToRoute(
                      const SuccessAppScreen(
                        showBackButton: false,
                        img: '$icons_path/Group.png',
                        title: 'Congratulations!',
                        subtitle: "Visitor has been added successfully'",
                      ),
                    ),
                  );
                }
              },
              onError: (error) {
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
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
