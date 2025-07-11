import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/date_time_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:host_visitor_connect/features/qr/data/network/responses/qr_scanner_data_response.dart';
import 'package:host_visitor_connect/features/rentals/bloc/driving_licence_bloc.dart';
import 'package:host_visitor_connect/features/rentals/ui/driving_licence_builder.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/driving_licence_details.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';

class DrivingLicenseForm extends StatefulWidget {
  final QrScannerDataResponse? visitor;
  final Visitor? visitorData;
  final OtpGenerationResponse? otpGenerationResponse;
  final int? id;
  final String? name;
  final bool? isForeigner;
  final bool? isOldVisitor;
  final bool? visitorAlreadyExists;
  final bool? showBackButton;
  final bool? isFromQR;
  final int? businessType;

  const DrivingLicenseForm({
    super.key,
    this.visitor,
    this.otpGenerationResponse,
    this.id,
    this.visitorData,
    this.isForeigner,
    this.name,
    this.isOldVisitor,
    this.visitorAlreadyExists,
    this.showBackButton,
    this.isFromQR,
    this.businessType,
  });

  @override
  State<DrivingLicenseForm> createState() => _DrivingLicenseFormState();
}

class _DrivingLicenseFormState extends State<DrivingLicenseForm> {
  DateTime? dateOfBirth = DateTime(
      DateTime.now().year - 16, DateTime.now().month, DateTime.now().day);
  String? drivingLicenceNo;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomImageAppBar(
        title: 'Verify Driving Licence',
        context: context,
        showSettings: false,
        showEditIcon: false,
        showBackButton: widget.showBackButton ?? true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
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
                BlocProvider(
                  create: (context) => ValidatorOnChanged(),
                  child: BlocBuilder<ValidatorOnChanged, String>(
                    builder: (context, state) {
                      return AddFormField(
                        textCapitalization: TextCapitalization.characters,
                        isEnable: (context.watch<DrivingLicenseBloc>().state
                                is Progress)
                            ? false
                            : true,
                        isRequired: true,
                        errorMsg: state,
                        hintText: 'Enter Driving Licence number',
                        label: 'Driving Licence Number',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter driving licence number';
                          }
                          return null;
                        },
                        onChanged: (licenceNo) {
                          drivingLicenceNo = licenceNo;
                        },
                      );
                    },
                  ),
                ),
                DateTimeField(
                  isDOB: true,
                  maxYear: dateOfBirth,
                  initialValue: dateOfBirth,
                  setValue: (date) {
                    if (date != null) {
                      dateOfBirth = date;
                      setState(() {});
                    }
                  },
                  isEnabled:
                      context.read<DrivingLicenseBloc>().state is! Progress,
                  isRequired: true,
                  isReadOnly: false,
                  label: 'Date Of Birth',
                  // value: dateOfBirth,
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DrivingLicenceBuilder(
                    onGetData: () {
                      print("upload driving licence");
                      print(widget.id);
                      if (FormErrorBuilder.validateFormAndShowErrors(context)) {
                        context.read<DrivingLicenseBloc>().drivingLicence(
                              name: widget.name ?? '',
                              id: widget.id ?? 0,
                              dob: dateOfBirth.toString(),
                              licenceNo: drivingLicenceNo ?? '',
                            );
                      }
                    },
                    onSuccess: () {
                      Navigator.push(
                        context,
                        goToRoute(
                          BlocProvider.value(
                            value: context.read<QrScannerBloc>(),
                            child: DrivingLicenceDetails(
                              businessType: widget.businessType,
                              isFromQr: widget.isFromQR,
                              licenceData: context
                                  .read<DrivingLicenseBloc>()
                                  .state
                                  .getData()
                                  ?.data,
                              isOldVisitor: (widget.isOldVisitor),
                              // visitor: widget.visitor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (!(errorMsg.isNullOrEmpty()) &&
                    context.read<DrivingLicenseBloc>().state is! Progress &&
                    context
                            .read<DrivingLicenseBloc>()
                            .state
                            .getData()
                            ?.status !=
                        200)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.red.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          errorMsg ?? '',
                          style: AppStyle.errorStyle(context),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
