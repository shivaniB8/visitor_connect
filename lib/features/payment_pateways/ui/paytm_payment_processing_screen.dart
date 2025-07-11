import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_payment_status_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_provider.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen(
      {super.key,
      required this.mid,
      required this.orderId,
      required this.amount,
      required this.token,
      required this.callBackUrl});

  final String mid;
  final String orderId;
  final int amount;
  final String token;
  final String callBackUrl;

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  // final settingsBloc = GetIt.instance.get<SettingsBloc>();

  String? paymentStatus;
  Timer? _timer;

  @override
  void initState() {
    _callTimer();

    print("mid > ${widget.mid}");
    print("orderId > ${widget.orderId}");
    print("amount > ${widget.amount}");
    print("token > ${widget.token}");
    print("callBackUrl > ${widget.callBackUrl}");

    Future.delayed(const Duration(milliseconds: 3000), () async {
      var response = await AllInOneSdk.startTransaction(
          widget.mid,
          //event?.pAYTMMERCHANTID ?? "",
          widget.orderId,
          //event?.pAYTMORDERID ?? "",
          widget.amount.toString(),
          //event?.pAYTMPAYMENTAMOUNT.toString() ?? "",
          widget.token,
          //event?.pAYTMTOKEN ?? "",
          widget.callBackUrl,
          //event?.pAYTMCALLBACKURL ?? "",
          // https://securegw.paytm.in/theia/api/v1/showPaymentPage
          // " https://securegw.paytm.in/theia/api/v1/showPaymentPage",
          // "?ORDER_ID=${event1.pAYTMORDERID}",
          false,
          true);
      print("startTransaction > $response");
    });

    super.initState();
  }

  _callTimer() {
    context
        .read<CheckPaytmPaymentStatusTokenBloc>()
        .generateCheckPaytmPaymentStatusToken(orderId: widget.orderId);
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _timer = timer;
      context
          .read<CheckPaytmPaymentStatusTokenBloc>()
          .generateCheckPaytmPaymentStatusToken(orderId: widget.orderId);
      // settingsBloc.getCandidatePlanStatusStream.listen((event) {
      //   if (event?.success == true) {
      //     print("paymentStatus > ${event?.data?.paymentStatus}");
      //     if (event?.data?.paymentStatus == 3 ||
      //         event?.data?.paymentStatus == 2) {
      //       timer.cancel();
      //     }
      //   }
      // });
      // todo : end timer on success or failure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocConsumer(
          bloc: context.read<CheckPaytmPaymentStatusTokenBloc>(),
          listener: (context, UiState state) {
            // if (state is Success &&
            //     context
            //             .read<CheckPaytmPaymentStatusTokenBloc>()
            //             .state
            //             .getData()
            //             ?.status ==
            //         200) {}
          },
          builder: (context, UiState state) {
            if (state is Success &&
                context
                        .read<CheckPaytmPaymentStatusTokenBloc>()
                        .state
                        .getData()
                        ?.status ==
                    200) {
              /// failure ...
              if (context
                      .read<CheckPaytmPaymentStatusTokenBloc>()
                      .state
                      .getData()
                      ?.data
                      ?.he13 ==
                  3) {
                _timer?.cancel();
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('$images_path/error_lottie.json'),
                      Text(
                        "Transaction Failed",
                        style: AppStyle.titleLarge(context),
                      ),
                      const SizedBox(height: 12),
                      Button(
                        text: "Okay",
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     goToRoute(
                          //         WalletProvider(child: const WalletScreen())),
                          //     (route) => false);
                        },
                      )
                    ],
                  ),
                );
              }

              /// success ...
              if (context
                      .read<CheckPaytmPaymentStatusTokenBloc>()
                      .state
                      .getData()
                      ?.data
                      ?.he13 ==
                  2) {
                _timer?.cancel();
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('$images_path/success_lottie.json'),
                        Text(
                          "Transaction Successful",
                          style: AppStyle.titleLarge(context),
                        ),
                        const SizedBox(height: 12),
                        Button(
                          text: "Okay",
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            // Navigator.of(context).push(goToRoute(
                            //     const WalletProvider(child: WalletScreen())));
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            return Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoadingWidget(),
                      const SizedBox(height: 12),
                      Text("PROCESSING ...",
                          style: AppStyle.titleLarge(context)),
                      Text("Payment Under Process",
                          style: AppStyle.titleMedium(context)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _paymentStatusWidget(img, text) {
    double size = sizeHeight(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(img, width: size / 5),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
          ],
        )
      ],
    );
  }

// Widget _getPaymentStatus() {
//   switch (paymentStatus) {
//     case "PENDING":
//       return _paymentStatusWidget(kPaymentPending, "Payment Pending");
//     case "SUCCESS":
//       return _paymentStatusWidget(kPaymentPending, "Payment Success");
//     case "FAILED":
//       return _paymentStatusWidget(kPaymentPending, "Payment Failed");
//     case "CANCELLED":
//       return _paymentStatusWidget(
//           kPaymentPending, "Payment Cancelled By User");
//     case "EXPIRED":
//       return _paymentStatusWidget(kPaymentPending, "Payment Expired");
//     case "INVALID REQUEST":
//       return _paymentStatusWidget(kPaymentPending, "Invalid Payment Request");
//     default:
//       return _paymentStatusWidget(kPaymentPending, "Payment Pending");
//   }
// }
//
// Future<void> _startTransaction(
//     {required String txnToken,
//     required String mid,
//     required String orderId,
//     required String amount,
//     required String callbackUrl,
//     required bool isStaging,
//     required bool restrictAppInvoke,
//     bool enableAssist = true}) async {
//   if (txnToken.isEmpty) {
//     return;
//   }
//   var sendMap = <String, dynamic>{
//     "mid": mid,
//     "orderId": orderId,
//     "amount": amount,
//     "txnToken": txnToken,
//     "callbackUrl": callbackUrl,
//     "isStaging": isStaging,
//     "restrictAppInvoke": restrictAppInvoke,
//     "enableAssist": enableAssist
//   };
//   print("sendMap > $sendMap");
//   // TODO: navigate to payment processing screen
//
//   Future.delayed(
//     Duration(milliseconds: 1000),
//     () async {
//       print('yahaa aaya');
//       try {
//         print('yahaa bhi aaya');
//         var response = await AllInOneSdk.startTransaction(
//             mid,
//             orderId,
//             amount,
//             txnToken,
//             callbackUrl,
//             isStaging,
//             restrictAppInvoke,
//             enableAssist);
//
//         print("response > $response");
//         // debugPrint(" after response ---------------");
//         //
//         // debugPrint(" processCandidatePlanStatus ---------------");
//
//         // settingsBloc.getCandidatePlanStatusStream.listen((event) {
//         //   if (event.success == true) {
//         //     // TODO: Payment In Process
//         //     if (event.data?.paymentStatus == 0) {
//         //       debugPrint(" Payment In Process ");
//         //     }
//         //
//         //     // TODO: Payment is in Pending
//         //     if (event.data?.paymentStatus == 1) {
//         //       debugPrint(" Payment is in Pending ");
//         //     }
//         //
//         //     // TODO: success
//         //     if (event.data?.paymentStatus == 2) {
//         //       debugPrint(" Payment success");
//         //
//         //       Navigator.of(context).push(goToRoute(const PaymentSuccessScreen()));
//         //     }
//         //
//         //     // TODO: failed
//         //     if (event.data?.paymentStatus == 3) {
//         //       debugPrint(" Payment failed ");
//         //
//         //       Navigator.of(context).push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //     // TODO: cancelled by user
//         //     if (event.data?.paymentStatus == 4) {
//         //       debugPrint(" cancelled by user");
//         //
//         //       Navigator.of(context).push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //     // TODO:/expired
//         //     if (event.data?.paymentStatus == 5) {
//         //       debugPrint(" /expired");
//         //
//         //       Navigator.of(context).push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //
//         //     // TODO: invalid request
//         //     if (event.data?.paymentStatus == 6) {
//         //       debugPrint("invalid request");
//         //       Navigator.of(context).push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //     // TODO: invalid request
//         //     if (event.data?.paymentStatus == 6) {
//         //       debugPrint("invalid request");
//         //
//         //       Navigator.of(context).push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //   }
//         // });
//         ///
//         // response?.then((value) {
//         //   print('he,llo');
//         //   print(value);
//         // });
//         // response.then((value) {
//         //   print("value > $value");
//         //   setState(() {
//         //     result = value.toString();
//         //   });
//         //
//         // });
//         //     .catchError((onError) {
//         //   if (onError is PlatformException) {
//         //     setState(() {
//         //       result = "${onError.message} \n  ${onError.details}";
//         //     });
//         //     if (onError.details["STATUS"] == "TXN_FAILURE") {
//         //       if (!mounted)return;
//         //       Navigator.of(context)
//         //           .push(goToRoute(const PaymentFailureScreen()));
//         //     }
//         //   } else {
//         //     setState(() {
//         //       result = onError.toString();
//         //     });
//         //   }
//         //   print("onError > $onError");
//         // });
//       } catch (err) {
//         // result = err.toString();
//         print("onError err > $err");
//       }
//     },
//   );
// }
}
