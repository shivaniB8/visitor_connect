import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/aadhar_details_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/mobile_response_data.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/add_visitor_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/otp_verification_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/request_otp_builder.dart';
import 'package:provider/provider.dart';

class AddAadharScreen extends StatefulWidget {
  final MobileResponseData? mobileResponseData;

  const AddAadharScreen({
    super.key,
    this.mobileResponseData,
  });

  @override
  State<AddAadharScreen> createState() => _AddAadharScreenState();
}

class _AddAadharScreenState extends State<AddAadharScreen> {
  String? errorMsg;
  String? aadharNumber;

  @override
  void initState() {
    aadharNumber = widget.mobileResponseData?.aadharNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TitleBar(title: 'Add Aadhar'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider(
                        create: (context) => ValidatorOnChanged(),
                        child: BlocBuilder<ValidatorOnChanged, String>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                BlocProvider(
                                  create: (context) => ValidatorOnChanged(),
                                  child:
                                      BlocBuilder<ValidatorOnChanged, String>(
                                    builder: (context, state) {
                                      return AddFormField(
                                        initialValue: aadharNumber,
                                        isEnable:
                                            (aadharNumber?.isNotEmpty ?? false)
                                                ? false
                                                : true,
                                        errorMsg: state,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'\d|\s'),
                                          ),
                                          AadharInputFormatter(inputLength: 12),
                                        ],
                                        keyboardType: TextInputType.number,
                                        hintText: 'Enter Aadhar No',
                                        label: 'Aadhar No',
                                        onChanged: (aadharNo) {
                                          context
                                              .read<ValidatorOnChanged>()
                                              .validateAadhar(aadharNo);
                                          aadharNumber = aadharNo;
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return 'Please enter Aadhar No';
                                          }
                                          if (!RegExp(
                                                  r'^[2-9][0-9]{3}[0-9]{4}[0-9]{4}$')
                                              .hasMatch(
                                                  value?.replaceAll(" ", "") ??
                                                      '')) {
                                            return 'Please enter valid Aadhar No';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: appSize(context: context, unit: 10) / 4.3,
                        child: RequestOtpBuilder(
                          buttonName: 'Update Aadhaar',
                          onSuccess: () {
                            final aadharData =
                                context.read<RequestOtpBloc>().state.getData();

                            {
                              Navigator.push(
                                context,
                                goToRoute(
                                  MultiProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (_) => AadharDetailsBloc(),
                                      ),
                                      BlocProvider(
                                        create: (_) => RequestOtpBloc(),
                                      ),
                                    ],
                                    child: VerifyOtpScreen(
                                      isOldVisitor: true,
                                      aadharData: aadharData,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          onGenerateOtpPressed: () {
                            context.read<RequestOtpBloc>().requestOtp(
                                  mobileNo:
                                      widget.mobileResponseData?.mobileNumber ??
                                          '',
                                  aadharNo: aadharNumber ?? '',
                                  update: 1,
                                  id: widget.mobileResponseData?.id ?? 0,
                                );
                          },
                          aadharerror: (error) {
                            errorMsg = error;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
