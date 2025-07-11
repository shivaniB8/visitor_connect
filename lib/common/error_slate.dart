import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/wallet/bloc/bar_graph_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_provider.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_screen.dart';
import 'package:provider/provider.dart';

import '../features/payment_pateways/razorpay/bloc/razor_pay_payment_bloc.dart';

class VoterListingErrorSlate extends StatelessWidget {
  final String? label;
  final String? subTitle;
  final bool takeToWallet;
  final bool shouldGoBack;

  const VoterListingErrorSlate({
    Key? key,
    this.label,
    this.subTitle,
    this.takeToWallet = false,
    this.shouldGoBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IgnorePointer(
          ignoring: shouldGoBack,
          child: InkWell(
            onTap: () {
              if (takeToWallet) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(
                  context,
                  goToRoute(
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => RazorPayPaymentBloc(),
                        ),
                        BlocProvider(
                          create: (_) => HostAccountStatementBloc(),
                        ),
                        BlocProvider(
                          create: (_) => BarGraphBloc(),
                        ),
                        BlocProvider(
                          create: (_) => WalletStatementHistoryBloc(),
                        ),
                      ],
                      child: const WalletScreen(),
                    ),
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      '$icons_path/wrong.png',
                      height: 80.h,
                      width: 80.w,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      label ?? 'Something went Wrong',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.titleLarge(context).copyWith(color: visitorNameColor),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      subTitle ?? 'Visitors Not Found',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.titleSmall(context).copyWith(color: foreignerTextLabelColor),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    // if (voter?.voterCardId?.isNotEmpty ?? false)
                    //   Container(
                    //     height: 140,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: Colors.black12,
                    //       border: Border.all(
                    //         color: Colors.black87.withOpacity(0.2),
                    //       ),
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(10),
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             capitalizedString(
                    //                 voter?.voterName ?? 'Not Available'),
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //             style: text_style_title8.copyWith(
                    //                 color: Colors.black),
                    //           ),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text('Voter Id : ${voter?.voterCardId}'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text('Age : ${voter?.age}'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text(
                    //             'Voter Address : ${capitalizedString(concatenatedValuesOfVoterAddress)}',
                    //             maxLines: 2,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // if (aadharResponse?.aadharNo?.isNotEmpty ?? false)
                    //   Container(
                    //     height: 150,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: Colors.black12,
                    //       border: Border.all(
                    //         color: Colors.black87.withOpacity(0.2),
                    //       ),
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(10),
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             capitalizedString(aadharResponse?.aadharName ??
                    //                 'Not Available'),
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //             style: text_style_title8.copyWith(
                    //                 color: Colors.black),
                    //           ),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text('Aadhar No : ${aadharResponse?.aadharNo}'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text(
                    //               'Gender : ${aadharResponse?.aadharGender?.getGender() ?? 'Unknown'}'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text(
                    //               'Date Of Birth : ${stringDateToDate(aadharResponse?.aadharDateOfBirth?.substring(0, 10) ?? '')}'),
                    //           const SizedBox(
                    //             height: 5,
                    //           ),
                    //           Text(
                    //             'Aadhar Address : ${capitalizedString(aadharResponse?.aadharAddress ?? 'Not Available')}',
                    //             maxLines: 2,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
