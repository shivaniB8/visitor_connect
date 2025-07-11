import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_payment_status_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_token_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_order_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_payment_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/model/add_money.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/paytm_builder.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/paytm_payment_processing_screen.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/razor_pay_order_builder.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:provider/provider.dart';

class PaymentGatewayAmountScreen extends StatefulWidget {
  const PaymentGatewayAmountScreen({super.key});

  @override
  State<PaymentGatewayAmountScreen> createState() =>
      _PaymentGatewayAmountScreenState();
}

class _PaymentGatewayAmountScreenState
    extends State<PaymentGatewayAmountScreen> {
  bool stepOneCompleted = false;
  bool stepTwoCompleted = false;
  bool stepThreeCompleted = false;

  bool stepTwoStarted = false;
  bool stepThreeStarted = false;

  int selectedIndex = -1;
  bool showErrorMsg = false;

  bool isChecked = false;

  List<Map<String, String>> paymentGateways = [
    {"key": 'razorpay.png', "value": 'Razorpay Payment'},
    {"key": 'paytm.png', "value": 'Paytm Payment'},
    {"key": 'razorpay.png', "value": 'Razorpay Payment'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomImageAppBar(
          title: 'Payment Gateway',
          context: context,
          showSettings: false,
          showEditIcon: false),
      body: Column(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.3),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  stepWidget(
                    stepCompleted: stepOneCompleted,
                    boxTitle: '1',
                    subText: 'Amount Details',
                    color: buttonColor,
                  ),
                  stepWidget(
                    stepCompleted: stepTwoCompleted,
                    boxTitle: '2',
                    subText: 'Payment Method',
                    color: stepTwoStarted ? buttonColor : disabled_color,
                  ),
                  stepWidget(
                    stepCompleted: stepThreeCompleted,
                    boxTitle: '3',
                    subText: 'Confirmation',
                    color: stepThreeStarted ? buttonColor : disabled_color,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          if (stepOneCompleted == false)
            Expanded(
              child: amountWidget(
                changeStep: (value) {
                  if (true) {
                    setState(() {
                      stepOneCompleted = true;
                      stepTwoStarted = true;
                    });
                  }
                },
              ),
            ),
          if (stepOneCompleted && !stepTwoCompleted)
            Expanded(
              child: paymentMethod(
                showError: () {
                  setState(() {
                    showErrorMsg = true;
                  });
                },
                changeStep: (value) {
                  if (true) {
                    setState(() {
                      stepOneCompleted = true;
                      stepTwoCompleted = true;
                      stepThreeStarted = true;
                    });
                  }
                },
              ),
            ),
          if (stepTwoCompleted)
            Expanded(
              child: confirmationWidget(),
            ),
        ],
      ),
    );
  }

  Widget stepWidget({
    required String boxTitle,
    required String subText,
    required Color color,
    required bool stepCompleted,
  }) {
    double fontSize = appSize(context: context, unit: 10) / 20;
    return Column(
      children: [
        Container(
          height: sizeHeight(context) / 22,
          width: sizeHeight(context) / 22,
          decoration: BoxDecoration(
            color: stepCompleted
                ? lightBlueAccentColor
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: stepCompleted
                ? Border.all(color: Colors.white, width: 2)
                : Border.all(color: color),
          ),
          child: Center(
            child: stepCompleted
                ? Icon(
                    Icons.check_circle,
                    color: buttonColor,
                    size: sizeHeight(context) / 40,
                  )
                : Text(
                    boxTitle,
                    style: AppStyle.bodyMedium(context)
                        .copyWith(color: color, fontSize: fontSize),
                  ),
          ),
        ),
        SizedBox(height: sizeHeight(context) / 100),
        Text(
          subText,
          style: AppStyle.bodyMedium(context)
              .copyWith(color: color, fontSize: fontSize),
        ),
      ],
    );
  }

  void selectContainer(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget amountWidget({required Function(bool) changeStep}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: FormBuilder(
        key: context.read<GlobalKey<FormBuilderState>>(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textFeild(
                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'Enter Amount';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<AddMoney>().amount = value;
                  },
                  label: 'Amount',
                  hintText: 'Enter Amount',
                  textInputType: TextInputType.number),
              SizedBox(height: sizeHeight(context) / 30),
              // textFeild(
              //   validator: (value) {
              //     if (value.isNullOrEmpty()) {
              //       return 'Enter Reason';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     context.read<AddMoney>().reason = value;
              //   },
              //   label: 'Reason',
              //   hintText: 'Type Reason',
              //   textInputType: TextInputType.text,
              // ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DotsProgressButton(
                  padding:
                      EdgeInsets.symmetric(vertical: sizeHeight(context) / 90),
                  isRectangularBorder: true,
                  expanded: true,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Proceed',
                        style: AppStyle.headlineSmall(context).copyWith(
                            color: Colors.white,
                            fontSize: appSize(context: context, unit: 10) / 12),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        '$icons_path/arrow_forward.png',
                        width: appSize(context: context, unit: 10) / 10,
                      ),
                      const Spacer(),
                    ],
                  ),
                  onPressed: () async {
                    if (FormErrorBuilder.validateFormAndShowErrors(context)) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await Future.delayed(const Duration(milliseconds: 1000));
                      changeStep.call(true);
                    }
                  },
                ),
              ),
              // SizedBox(
              //   height: sizeHeight(context) / 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentMethod(
      {Function(bool)? changeStep, required Function() showError}) {
    double fontSize = appSize(context: context, unit: 10) / 13;
    double imgSize = appSize(context: context, unit: 10) / 5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            paymentGateways.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  selectContainer(index);
                  context.read<AddMoney>().paymentMode = index + 1;
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedIndex == index
                            ? buttonColor
                            : Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        if (selectedIndex == index)
                          BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                          )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black54.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          '$images_path/${paymentGateways[index]['key']}',
                          width: imgSize,
                          height: imgSize,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${paymentGateways[index]['value']}',
                        style: AppStyle.headlineMedium(context)
                            .copyWith(color: buttonColor, fontSize: fontSize),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // const Spacer(),
          if (showErrorMsg)
            Text(
              'Please Select One Payment Method',
              textAlign: TextAlign.start,
              style: AppStyle.headlineSmall(context).copyWith(
                  color: Colors.red, fontSize: sizeHeight(context) / 55),
            ),
          // if (showErrorMsg)
          //   const SizedBox(
          //     height: 10,
          //   ),
          SizedBox(height: sizeHeight(context) / 20),
          DotsProgressButton(
            isRectangularBorder: true,
            expanded: true,
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Proceed',
                  style: AppStyle.headlineSmall(context)
                      .copyWith(color: Colors.white, fontSize: fontSize),
                ),
                const SizedBox(width: 12),
                Image.asset(
                  '$icons_path/arrow_forward.png',
                  height: imgSize - 20,
                  width: imgSize - 20,
                ),
                const Spacer()
              ],
            ),
            onPressed: () {
              if (!(selectedIndex != -1 && !(selectedIndex > 2))) {
                showError.call();
              }

              if (selectedIndex != -1 && !(selectedIndex > 2)) {
                // if (FormErrorBuilder.validateFormAndShowErrors(context)) {
                changeStep?.call(true);
              }
              // }
            },
          ),
          // SizedBox(
          //   height: imgSize,
          // ),
        ],
      ),
    );
  }

  Widget confirmationWidget() {
    double fontSize = appSize(context: context, unit: 10) / 16;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Amount :',
                    style: AppStyle.titleLarge(context)
                        .copyWith(color: buttonColor, fontSize: fontSize),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      '₹ ${context.read<AddMoney>().amount}.00',
                      style: AppStyle.headlineMedium(context)
                          .copyWith(color: buttonColor, fontSize: fontSize + 5),
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeHeight(context) / 40),
              Row(
                children: [
                  Text(
                    'Payment Mode :',
                    style: AppStyle.titleLarge(context)
                        .copyWith(color: buttonColor, fontSize: fontSize),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    context.read<AddMoney>().paymentMode.paymentMode(),
                    style: AppStyle.headlineMedium(context)
                        .copyWith(color: buttonColor, fontSize: fontSize + 5),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        // const Spacer(),
        Row(
          children: [
            Checkbox(
              value: isChecked,
              checkColor: Colors.white,
              activeColor: buttonColor,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Are you sure you want to proceed with payment',
                style:
                    AppStyle.titleLarge(context).copyWith(fontSize: fontSize),
              ),
            ),
          ],
        ),
        SizedBox(height: sizeHeight(context) / 40),
        context.read<AddMoney>().paymentMode == 2
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PaytmBuilder(
                  onPressed: () {
                    context.read<PaytmTokenBloc>().generatePaytmToken(
                        hostId: SharedPrefs.getInt(keyHostFk) ?? 0,
                        amount:
                            int.tryParse(context.read<AddMoney>().amount) ?? 0);
                  },
                  onSuccess: () {
                    print('object');
                    print(context.read<AddMoney>().paymentMode);
                    String paytmToken = context
                            .read<PaytmTokenBloc>()
                            .state
                            .getData()
                            ?.paytoken ??
                        "";
                    String orderId = context
                            .read<PaytmTokenBloc>()
                            .state
                            .getData()
                            ?.orderId ??
                        "";
                    String mid = context
                            .read<PaytmTokenBloc>()
                            .state
                            .getData()
                            ?.response
                            ?.body
                            ?.mid ??
                        "";
                    int amount = context
                            .read<PaytmTokenBloc>()
                            .state
                            .getData()
                            ?.response
                            ?.body
                            ?.txnAmount
                            ?.value ??
                        0;
                    String callBackUrl = context
                            .read<PaytmTokenBloc>()
                            .state
                            .getData()
                            ?.response
                            ?.body
                            ?.callbackUrl ??
                        "";
                    Navigator.of(context).push(goToRoute(MultiProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => CheckPaytmPaymentStatusTokenBloc(),
                          ),
                        ],
                        child: PaymentProcessingScreen(
                            mid: mid,
                            orderId: orderId,
                            amount: amount,
                            token: paytmToken,
                            callBackUrl: callBackUrl))));
                  },
                ),
              )
            : context.read<AddMoney>().paymentMode == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RazorPayOrderBuilder(
                      onSuccess: () {
                        Razorpay razorpay = Razorpay();
                        var options = {
                          'key': GlobalVariable.RAZOR_PAY_KEY,
                          'amount':
                              (int.tryParse(context.read<AddMoney>().amount) ??
                                      0) *
                                  100,
                          'name': "Visitor Connect",
                          'currency': "INR",
                          'retry': {'enabled': true, 'max_count': 1},
                          'order_id': context
                              .read<RazorPayOrderBloc>()
                              .state
                              .getData()
                              ?.records
                              ?.orderId,
                          'send_sms_hash': true,
                          'prefill': {
                            'contact': '8080227727',
                            'email': 'test@razorpay.com'
                          }
                        };
                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                            showPaymentFailedDialog);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            showPaymentSuccessDialog);

                        razorpay.open(options);
                      },
                      onPressed: () {
                        context.read<RazorPayOrderBloc>().createOrderRazorpay(
                              amount: int.tryParse(
                                      context.read<AddMoney>().amount) ??
                                  0,
                              reason: context.read<AddMoney>().reason,
                            );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
        SizedBox(
          height: sizeHeight(context) / 20,
        ),
      ],
    );
  }

  void showPaymentFailedDialog(PaymentFailureResponse response) {
    print(response.code);
    print(response.error);
    print(response.message);
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    context
        .read<RazorPayPaymentBloc>()
        .razorpayPayment(transactionId: '')
        .then((value) => context.read<UserDetailsBloc>().userDetails());
    showStatusDialog(
      context,
      buttonName: 'Try Again',
      color: buttonColor,
      title: 'Payment Failed',
      imageName: 'error_lottie.json',
      subtitle: 'There is some error with payment',
      paymentId: response.error?["metadata"]?["payment_id"] ?? "FAILED",
      buttonTextColor: buttonColor,
    );
  }

  void showPaymentSuccessDialog(PaymentSuccessResponse response) async {
    // print(response.paymentId);
    print("razorpayY data >> ${response.data}");
    print("razorpayY signature >> ${response.signature}");
    print("razorpayY paymentId >> ${response.paymentId}");
    print("razorpayY orderId >> ${response.orderId}");

    // await Future.delayed(const Duration(milliseconds: 6000));
    // Timer.periodic(const Duration(seconds: 5), (timer) {
    //   if (mounted) {
    //     print("timer $timer");
    context
        .read<RazorPayPaymentBloc>()
        .razorpayPayment(transactionId: response.paymentId ?? '');
    // .then((value) {
    // context.read<UserDetailsBloc>().userDetails();
    // });
    // }
    // });

    /*

    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showStatusDialog(
      context,
      color: Colors.green,
      title: 'Payment successful',
      subtitle: 'Payment Verified',
      imageName: 'success_lottie.json',
      buttonName: 'Done',
      paymentId: response.paymentId ?? "",
      buttonTextColor: Colors.green,
    );
  }

  void showStatusDialog(
    BuildContext context, {
    required final Color color,
    required String title,
    required String subtitle,
    required String imageName,
    required String buttonName,
    required Color buttonTextColor,
    required String paymentId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          elevation: 10,
          backgroundColor: color,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('$images_path/$imageName'),
                Text(
                  title,
                  style: text_style_title15.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  subtitle,
                  style: text_style_title13.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    ).then(
      (value) => Navigator.of(context).pop(),
    );
  }

  // {"success":true,"status":200,"message":"Order id generated successfully","record":{"error":{"code":"BAD_REQUEST_ERROR","description":"Order amount less than minimum amount allowed","metadata":[],"reason":"NA","source":"order","step":"NA"}}}

  Widget textFeild({
    TextInputType? textInputType,
    required String hintText,
    required String label,
    String? Function(String?)? validator,
    required void Function(String)? onChanged,
  }) {
    double fontSize = appSize(context: context, unit: 10) / 14;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.titleMedium(context)
              .copyWith(color: Colors.black54, fontSize: fontSize),
        ),
        SizedBox(height: sizeHeight(context) / 70),
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          textAlign: TextAlign.start,
          keyboardType: textInputType ?? TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            counter: const Offstage(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            counterText: "",
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: buttonColor,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(width: 1.5, color: buttonColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: buttonColor,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: buttonColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1.5,
                color: buttonColor,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(width: 1.5, color: buttonColor),
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle: AppStyle.titleLarge(context).copyWith(
                fontSize: fontSize + 2,
                color: buttonColor,
                fontWeight: FontWeight.w400),
          ),
          style: AppStyle.titleMedium(context).copyWith(
              fontSize: fontSize + 2,
              color: buttonColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
