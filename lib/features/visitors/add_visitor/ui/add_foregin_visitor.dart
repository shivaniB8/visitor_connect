import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/constant/constant_data.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_time_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/custom_widget/title_full_name.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/upload_image.dart';
import 'package:host_visitor_connect/common/utils/app_function.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/add_foreigner_visitor_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/check_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/foreigner_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/add_foreigner_visitor_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/check_mobile_number_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/gender_dropdown.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/second_form_provider.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/add_visitor_second_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'model/add_indian_visitor.dart';

class AddForeignVisitor extends StatefulWidget {
  final Visitor? visitor;
  final String? mobileNumber;
  final bool? visitorAlreadyExists;
  final ForeignerData? foreignerData;
  final bool? isForeigner;
  final bool? isForeigners;

  const AddForeignVisitor(
      {super.key,
      this.isForeigner,
      this.visitorAlreadyExists,
      this.isForeigners,
      this.visitor,
      this.mobileNumber,
      this.foreignerData});

  @override
  State<AddForeignVisitor> createState() => _AddForeignVisitorState();
}

class _AddForeignVisitorState extends State<AddForeignVisitor> {
  String? mobileNumber;
  String? countryName;
  String? passportcountryName;
  String? countryFk;
  Country? selectedCountry;
  String? errorMsg;
  String? errorMsgCountry;
  String? errorMsgPassportCountry;
  bool fileError = false;
  final focusNodeFullName = FocusNode();
  bool isTitleNull = false;
  bool firstNameNotValid = false;
  XFile? passportPhoto;
  bool? passportPhotoMsg;

  @override
  void initState() {
    context.read<TitlesBloc>().getTitles();
    context.read<AddForeignerVisitor>().dateOfBirth = DateTime.now().toString();
    context.read<AddForeignerVisitor>().passportExpiryDate =
        DateTime.now().toString();

    super.initState();
  }

  bool checkFirstNameIsNull() {
    if (context.read<AddForeignerVisitor>().titleFk == null) {
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
    return Scaffold(
      body: Stack(
        children: [
          const TitleBar(title: 'Add Visitor'),
          Positioned(
            top: 180,
            left: 0.1,
            right: 0.1,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 25,
                  right: 25,
                  bottom: 15,
                ),
                child: FormBuilder(
                  key: context.read<GlobalKey<FormBuilderState>>(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormFieldLabel(
                          label: 'Country',
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
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      countryName ?? 'Select Country',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: (context
                                                      .read<
                                                          CheckMobileNumberBloc>()
                                                      .state is! Progress &&
                                                  !(context
                                                          .read<
                                                              CheckMobileNumberBloc>()
                                                          .state
                                                          .getData()
                                                          ?.success ??
                                                      false))
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 20,
                                    color: (context
                                                .read<CheckMobileNumberBloc>()
                                                .state is! Progress &&
                                            !(context
                                                    .read<
                                                        CheckMobileNumberBloc>()
                                                    .state
                                                    .getData()
                                                    ?.success ??
                                                false))
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ],
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
                                    false)) {
                              showCountryPicker(
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
                                          .countryName = countryName;

                                      int index = (counties.indexWhere(
                                              (element) =>
                                                  element['maj4'] ==
                                                  context
                                                      .read<
                                                          AddForeignerVisitor>()
                                                      .countyCode)) +
                                          1;
                                      context
                                          .read<AddForeignerVisitor>()
                                          .countryFk = index.toString();
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                        errorMsgCountry.isNullOrEmpty()
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  errorMsgCountry!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                        const SizedBox(
                          height: 25,
                        ),
                        BlocProvider(
                          create: (context) => ValidatorOnChanged(),
                          child: BlocBuilder<ValidatorOnChanged, String>(
                            builder: (context, state) {
                              return AddFormField(
                                countryCode: selectedCountry?.phoneCode ?? '0',
                                isEnable: context
                                        .read<CheckMobileNumberBloc>()
                                        .state is! Progress &&
                                    !(context
                                            .read<CheckMobileNumberBloc>()
                                            .state
                                            .getData()
                                            ?.success ??
                                        false),
                                errorMsg: state,
                                isMobileNumber: true,
                                hintText: S
                                    .of(context)
                                    .loginPage_label_enterYourMobileNumber,
                                label: S.of(context).loginPage_label_mobileNo,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (context
                                          .read<CheckMobileNumberBloc>()
                                          .state is! Progress &&
                                      !(context
                                              .read<CheckMobileNumberBloc>()
                                              .state
                                              .getData()
                                              ?.success ??
                                          false)) {
                                    if ((value?.isEmpty ?? false) ||
                                        value == null) {
                                      return 'Please enter Mobile Number';
                                    } else if (!RegExp(
                                            r'^[+]{1}(?:[0-9\-\\(\\)\\/.]\s?){6,15}[0-9]{1}$')
                                        .hasMatch(
                                            "+${selectedCountry?.phoneCode} $value")) {
                                      return 'Please enter valid Mobile Number';
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                onChanged: (mobileNo) {
                                  mobileNumber = mobileNo;
                                  String? newMobilew =
                                      '+${selectedCountry?.phoneCode} $mobileNo';
                                  context
                                      .read<ValidatorOnChanged>()
                                      .validateForeginMobile(
                                          newMobilew, context);

                                  context
                                      .read<AddForeignerVisitor>()
                                      .mobileNumber = mobileNo;
                                },
                              );
                            },
                          ),
                        ),
                        if (context
                                .read<CheckMobileNumberBloc>()
                                .state
                                .getData()
                                ?.status ==
                            200)
                          const SizedBox(
                            height: 5,
                          ),
                        if (context.read<CheckMobileNumberBloc>().state
                                is! Progress &&
                            !(context
                                    .read<CheckMobileNumberBloc>()
                                    .state
                                    .getData()
                                    ?.success ??
                                false))
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: CheckMobileNumberBuilder(
                              onSearch: () {
                                if (FormErrorBuilder.validateFormAndShowErrors(
                                    context)) {
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
                                setState(() {});
                              },
                              error: (error) {
                                setState(
                                  () {
                                    errorMsg = error;
                                  },
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
                ),
              ),
            ),
          ),
        ],
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
                      passportcountryName = country.displayNameNoCountryCode;
                      context.read<AddForeignerVisitor>().passportcountyCode =
                          country.phoneCode;
                      context.read<AddForeignerVisitor>().passportcountryName =
                          passportcountryName;
                      int index = (counties.indexWhere((element) =>
                              element['maj4'] ==
                              context
                                  .read<AddForeignerVisitor>()
                                  .passportcountyCode)) +
                          1;
                      context.read<AddForeignerVisitor>().passportcountryFk =
                          index.toString();
                      // setState(() {
                      // errorMsgPassportCountry = "";
                      // });
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
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      initialValue: dateTimeFromString(
        context.read<AddForeignerVisitor>().passportExpiryDate,
      ),
      setValue: (date) {
        // Get the current date
        DateTime currentDate = DateTime.now();
        if (date != null) {
          // Check if the selected date is after the current date
          if (date.isBefore(currentDate)) {
            // Perform validation action here, such as showing an error message
            // For example, you can use a scaffold key to show a SnackBar
            errorMsg = 'Selected date cannot be after the current date';
          } else {
            // Set the dateOfBirth only if it's valid
            context.read<AddForeignerVisitor>().passportExpiryDate =
                date.toString();
            setState(() {});
          }
        }
      },
      isEnabled: context.read<AddForeignerVisitorBloc>().state is! Progress,
      isRequired: true,
      isReadOnly: false,
      label: ' Passport Expiry Date',
      value: dateTimeFromString(
        context.read<AddForeignerVisitor>().passportExpiryDate,
      ),
    );
  }

  //
  Widget checkMobileFunction() {
    final state = context.watch<CheckMobileNumberBloc>().state;
    if (state is Progress) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is Success && state.getData()?.status == 200) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.2)),
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
                                        Image.asset('$icons_path/avatar.png')
                                            .image,
                                  ),
                                ),
                                Positioned.fill(
                                  child: (!(context
                                                  .read<CheckMobileNumberBloc>()
                                                  .state
                                                  .getData()
                                                  ?.mobileResponseData
                                                  ?.aadharPhoto
                                                  .isNullOrEmpty() ??
                                              false) ||
                                          !(context
                                                  .read<CheckMobileNumberBloc>()
                                                  .state
                                                  .getData()
                                                  ?.mobileResponseData
                                                  ?.profilePhoto
                                                  .isNullOrEmpty() ??
                                              false))
                                      ? Image.network(
                                          !(context
                                                      .read<
                                                          CheckMobileNumberBloc>()
                                                      .state
                                                      .getData()
                                                      ?.mobileResponseData
                                                      ?.profilePhoto
                                                      .isNullOrEmpty() ??
                                                  false)
                                              ? '$googlePhotoUrl${getBucketName()}$voterPhotoFolder${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.profilePhoto}'
                                              : '$googlePhotoUrl${getBucketName()}$visitorAadharFolder${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.aadharPhoto}',
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
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return TitleBarDialog(
                                      headerTitle: 'Scan the QR code',
                                      bodyContent: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                'You can scan the QR code here',
                                                style: text_style_title11,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            if (!(context
                                                    .read<
                                                        CheckMobileNumberBloc>()
                                                    .state
                                                    .getData()
                                                    ?.mobileResponseData
                                                    ?.qrImage
                                                    .isNullOrEmpty() ??
                                                false))
                                              CachedNetworkImage(
                                                imageUrl:
                                                    '$googlePhotoUrl${getBucketName()}$qrCodeFolder${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.qrImage}',
                                                fit: BoxFit.cover,
                                                // width: MediaQuery.of(context).size.width / 34,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                placeholder: (context, url) =>
                                                    SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            6,
                                                        child: Center(
                                                          child: context
                                                                      .read<
                                                                          CheckMobileNumberBloc>()
                                                                      .state
                                                                      .getData()
                                                                      ?.mobileResponseData
                                                                      ?.qrImage
                                                                      ?.isNotEmpty ??
                                                                  false
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : const Text(
                                                                  "No QR Image",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                        )),
                                              ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: SizedBox(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Button(
                                                  text: 'Share QR',
                                                  onPressed: () {
                                                    AppFunctions.shareQRImage(
                                                        '$googlePhotoUrl${getBucketName()}$qrCodeFolder${context.read<CheckMobileNumberBloc>().state.getData()?.mobileResponseData?.qrImage}');
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: ExactAssetImage(
                                            '$images_path/qr-code.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      // Clip it cleanly.
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.0),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Click to check QR',
                                    style: text_style_title11,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!(widget.isForeigner ?? false))
                        Text(
                          capitalizedString(context
                                  .read<CheckMobileNumberBloc>()
                                  .state
                                  .getData()
                                  ?.mobileResponseData
                                  ?.fullName ??
                              "Not Available"),
                          style:
                              text_style_title4.copyWith(color: Colors.black),
                        ),
                      if ((widget.isForeigner ?? false))
                        Text(
                          capitalizedString(context
                                  .read<CheckMobileNumberBloc>()
                                  .state
                                  .getData()
                                  ?.mobileResponseData
                                  ?.fullName ??
                              "Not Available"),
                          style:
                              text_style_title4.copyWith(color: Colors.black),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!(widget.isForeigner ?? false))
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Passport No', style: text_style_para1),
                              const TextSpan(
                                  text: ': ', style: text_style_para1),
                              TextSpan(
                                text: context
                                        .read<CheckMobileNumberBloc>()
                                        .state
                                        .getData()
                                        ?.mobileResponseData
                                        ?.visitorPassportNumber ??
                                    "Not Available",
                                style: text_style_title13,
                              ),
                            ],
                          ),
                        ),
                      if ((widget.isForeigner ?? false))
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Passport No', style: text_style_para1),
                              const TextSpan(
                                  text: ': ', style: text_style_para1),
                              TextSpan(
                                text: context
                                        .read<CheckMobileNumberBloc>()
                                        .state
                                        .getData()
                                        ?.mobileResponseData
                                        ?.visitorPassportNumber ??
                                    "Not Available",
                                style: text_style_title13,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!(widget.isForeigner ?? false))
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Dob: ',
                                style: text_style_para1,
                              ),
                              TextSpan(
                                text: context
                                        .read<CheckMobileNumberBloc>()
                                        .state
                                        .getData()
                                        ?.mobileResponseData
                                        ?.dob ??
                                    "Not Available",
                                style: text_style_title13,
                              ),
                            ],
                          ),
                        ),
                      if ((widget.isForeigner ?? false))
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Date of Birth: ',
                                  style: text_style_para1),
                              TextSpan(
                                text: capitalizedString(context
                                        .read<CheckMobileNumberBloc>()
                                        .state
                                        .getData()
                                        ?.mobileResponseData
                                        ?.dob ??
                                    "Not Available"
                                        'Not Available'),
                                style: text_style_title13,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!(widget.isForeigner ?? false))
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Address: ', style: text_style_para1),
                              TextSpan(
                                text: capitalizedString(context
                                        .read<CheckMobileNumberBloc>()
                                        .state
                                        .getData()
                                        ?.mobileResponseData
                                        ?.address ??
                                    "Not Available"),
                                style: text_style_title13,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Button(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      goToRoute(
                        SecondFormProvider(
                          child: AddVisitorSecondScreen(
                            visitorType: 2,
                            isUpdateForeigner: true,
                            mobileResponseData: context
                                .read<CheckMobileNumberBloc>()
                                .state
                                .getData()
                                ?.mobileResponseData,
                          ),
                        ),
                      ),
                    );
                  },
                  isRectangularBorder: true,
                ),
              )
            ],
          ),
        ),
      );
    } else if (state is Success && state.getData()?.status == 201) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    context.read<AddForeignerVisitor>().titleFk = title.value;
                    context.read<AddForeignerVisitor>().title = title.label;
                  },
                  isUpdate: true,
                  titles: context.read<TitlesBloc>().state.getData()?.data,
                  // isItEnabled: true,
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          passportIssueCountryWidget(),
          if (context.read<CheckMobileNumberBloc>().state.getData()?.status ==
              201)
            const SizedBox(
              height: 5,
            ),
          BlocProvider(
            create: (context) => ValidatorOnChanged(),
            child: BlocBuilder<ValidatorOnChanged, String>(
              builder: (context, state) {
                return AddFormField(
                  isEnable:
                      context.watch<AddForeignerVisitorBloc>().state is Progress
                          ? false
                          : true,
                  errorMsg: state,
                  isRequired: true,
                  maxLength: 30,
                  hintText: 'Enter Your Passport Number',
                  label: 'Passport Number',
                  keyboardType: TextInputType.text,
                  onChanged: (passport) {
                    context.read<AddForeignerVisitor>().passportNumber =
                        passport;
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
          if (fileError)
            const SizedBox(
              height: 15,
            ),
          passportExpiryDate(),
          const SizedBox(
            height: 25,
          ),
          DateTimeField(
            maxYear: DateTime.now().add(const Duration(days: 1)),
            initialValue: dateTimeFromString(
              context.read<AddForeignerVisitor>().dateOfBirth,
            ),
            setValue: (date) {
              // Get the current date
              DateTime currentDate = DateTime.now();
              if (date != null) {
                // Check if the selected date is after the current date
                if (date.isAfter(currentDate)) {
                  // Perform validation action here, such as showing an error message
                  // For example, you can use a scaffold key to show a SnackBar
                  errorMsg = 'Selected date cannot be after the current date';
                } else {
                  // Set the dateOfBirth only if it's valid
                  context.read<AddForeignerVisitor>().dateOfBirth =
                      date.toString();
                  setState(() {});
                }
              }
            },
            isRequired: true,
            isReadOnly: false,
            label: 'Date Of Birth',
            value: dateTimeFromString(
              context.read<AddForeignerVisitor>().dateOfBirth,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          BlocProvider(
            create: (context) => ValidatorOnChanged(),
            child: BlocBuilder<ValidatorOnChanged, String>(
              builder: (context, state) {
                return AddFormField(
                  isEnable: (context.watch<AddForeignerVisitorBloc>().state
                          is Progress)
                      ? false
                      : true,
                  maxLength: 50,
                  errorMsg: state,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your Email Id',
                  label: 'Email Id',
                  onChanged: (email) {
                    context.read<ValidatorOnChanged>().validateEmail(email);
                    context.read<AddForeignerVisitor>().email = email;
                  },
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
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
            height: 10,
          ),
          const FormFieldLabel(
            label: 'Gender',
          ),
          const SizedBox(
            height: 5,
          ),
          GenderDropdown(
            isGenderNull: false,
            genders: [
              KeyValueResponse(value: 1, label: 'Male'),
              KeyValueResponse(value: 2, label: 'Female'),
              KeyValueResponse(value: 3, label: 'Other'),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          UploadImage(
            isEnable: context.watch<AddForeignerVisitorBloc>().state is Progress
                ? false
                : true,
            onImageSelected: (image) {
              setState(() {
                passportPhoto = image;
              });
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (passportPhoto?.path.isNotEmpty ?? false)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: appSize(context: context, unit: 10),
                    child: (passportPhoto?.name.contains(".png") ?? false) ||
                            (passportPhoto?.name.contains(".jpg") ?? false) ||
                            (passportPhoto?.name.contains(".jpeg") ?? false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.file(
                              File(
                                passportPhoto?.path ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                if (passportPhoto == null)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: appSize(context: context, unit: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Image.asset(
                        '$icons_path/doc1.png',
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Upload Passport Photo',
                      style: text_style_title4.copyWith(color: buttonColor),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                if (passportPhotoMsg ?? false)
                  const Text(
                    'Please select Passport Photo',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: AddForeignerVisitorBuilder(
              onAddVisitorPressed: () {
                checkFirstNameIsNull();
                if (FormErrorBuilder.validateFormAndShowErrors(context) &&
                    !checkFirstNameIsNull()) {
                  if (passportcountryName.isNullOrEmpty()) {
                    errorMsgPassportCountry =
                        "Please select passport issuing country";
                    setState(() {});
                    return;
                  } else {
                    errorMsgPassportCountry = "";
                    setState(() {});
                  }
                  if (!((passportPhoto?.path.isEmpty ?? false) ||
                      passportPhoto?.path == null)) {
                    // context
                    //     .read<AddForeignerVisitorBloc>()
                    //     .addForeignerVisitorManually(
                    //       passportPhoto: passportPhoto ?? XFile(''),
                    //       foreignerVisitor:
                    //           context.read<AddForeignerVisitor>().toJson,
                    //     );
                  } else {
                    setState(() {
                      passportPhotoMsg = true;
                    });
                  }
                } else {
                  if (passportcountryName.isNullOrEmpty()) {
                    errorMsgPassportCountry =
                        "Please select passport issuing country";
                    setState(() {});
                  } else {
                    errorMsgPassportCountry = "";
                    setState(() {});
                  }
                  if (passportPhoto?.path == null ||
                      (passportPhoto?.path.isEmpty ?? false)) {
                    setState(() {
                      passportPhotoMsg = true;
                    });
                  } else {
                    setState(() {
                      passportPhotoMsg = false;
                    });
                  }
                }
              },
              onSuccess: () {
                Navigator.push(
                  context,
                  goToRoute(
                    SecondFormProvider(
                      child: AddVisitorSecondScreen(
                        visitorType: 2,
                        foreignerData: context
                            .read<AddForeignerVisitorBloc>()
                            .state
                            .getData()
                            ?.foreignerData,
                      ),
                    ),
                  ),
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
