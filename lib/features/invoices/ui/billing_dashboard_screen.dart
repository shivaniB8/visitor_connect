import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/dots_progress_button.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/invoices/ui/account_statement_screen.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_token_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_order_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_payment_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/model/add_money.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/payment_gateway_amount_screen.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:provider/provider.dart';

class BillingDashboardScreen extends StatefulWidget {
  const BillingDashboardScreen({super.key});

  @override
  State<BillingDashboardScreen> createState() => _BillingDashboardScreenState();
}

class _BillingDashboardScreenState extends State<BillingDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().userDetails();
  }

  @override
  Widget build(BuildContext context) {
    double size = appSize(context: context, unit: 10);
    return Scaffold(
        backgroundColor: background_grey_color,
        appBar: CustomImageAppBar(
          title: "Billing Dashboard",
          context: context,
          showSettings: false,
          showEditIcon: false,
        ),
        body: BlocProvider.value(
            value: context.read<UserDetailsBloc>(),
            child: Column(
              children: [
                _hostDetailsHeaderCard(size),
                _transactionWidget(size)
              ],
            )));
  }

  _transactionWidget(size) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _transactionBtn(
              onPressed: () {
                Navigator.of(context).push(goToRoute(MultiProvider(providers: [
                  ChangeNotifierProvider(
                    create: (_) => AddMoney(),
                  ),
                  Provider(
                    create: (_) => GlobalKey<FormBuilderState>(),
                  ),
                  BlocProvider(
                    create: (_) => RazorPayOrderBloc(),
                  ),
                  BlocProvider(
                    create: (_) => RazorPayPaymentBloc(),
                  ),
                  // BlocProvider.value(
                  //   value: context.read<RazorPayPaymentBloc>(),
                  // ),
                  BlocProvider(
                    create: (_) => PaytmTokenBloc(),
                  ),
                ], child: const PaymentGatewayAmountScreen())));
              },
              text: "Add Funds",
              iconPath: "$icons_path/addfunds.png"),
          const SizedBox(width: 6),
          _transactionBtn(
              onPressed: () {
                Navigator.of(context)
                    .push(goToRoute(MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (_) => HostAccountStatementBloc(),
                  ),
                ], child: const AccountStatementScreen())));
              },
              text: "Account Statements",
              iconPath: "$icons_path/doc.png"),
        ],
      ));

  _transactionBtn(
          {required Function() onPressed,
          required String text,
          required String iconPath}) =>
      Expanded(
        child: DotsProgressButton(
          isProgress: false,
          onPressed: onPressed,
          buttonBackgroundColor: buttonColor,
          expanded: true,
          isRectangularBorder: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const Spacer(),
              Text(text,
                  style: AppStyle.buttonStyle(context).copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: appSize(context: context, unit: 10) / 18)),
              const Spacer(),
              Image.asset(iconPath,
                  width: appSize(context: context, unit: 10) / 10),
            ],
          ),
        ),
      );

  _hostDetailsHeaderCard(size) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _imageWidget(size),
                SizedBox(width: size / 20),
                _balanceWidget(size)
              ],
            ),
            SizedBox(height: size / 20),
            const Divider(color: Colors.black38, height: 0.5),
            SizedBox(height: size / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _gstAddressWidget(
                    size,
                    context.watch<UserDetailsBloc>().state.getData()?.address ??
                        "N/A"),
              ],
            ),
            SizedBox(height: size / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _businessCredentialWidget(
                    size,
                    "GST No.: ${context.watch<UserDetailsBloc>().state.getData()?.gstNumber ?? "N/A"}"
                        .toUpperCase()),
                _businessCredentialWidget(
                    size,
                    "PAN: ${context.watch<UserDetailsBloc>().state.getData()?.panNumber ?? "N/A"}"
                        .toUpperCase()),
              ],
            ),
          ],
        ),
      );

  _imageWidget(size) {
    debugPrint(
        'image >>>> $googlePhotoUrl${getMasterBucketName()}$clientFolder${SharedPrefs.getString(keyClientLogo)}');
    debugPrint(
        'image 1 >>>> $googlePhotoUrl${getBucketName()}$userPhoto${context.watch<UserDetailsBloc>().state.getData()?.userPhoto}');

    return CachedNetworkImage(
      height: size - 100,
      width: size - 50,
      // fit: BoxFit.cover,
      imageUrl:
          '$googlePhotoUrl${getMasterBucketName()}$hostImage${context.watch<UserDetailsBloc>().state.getData()?.hostLogo}',
      // '$googlePhotoUrl${getMasterBucketName()}$clientFolder${SharedPrefs.getString(keyClientLogo)}',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 45),
        height: 50,
        width: 50,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(6)),
        child: Icon(
          Icons.person,
          color: Colors.black54,
          size: size / 2.4,
        ),
      ),
    );
  }

  _balanceWidget(size) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Balance",
                style: AppStyle.titleLarge(context).copyWith(
                    color: text_color,
                    fontSize: size / 14,
                    fontWeight: FontWeight.w500)),
            Text(
                "₹ ${context.watch<UserDetailsBloc>().state.getData()?.liveBalance ?? "0"}",
                style: AppStyle.titleLarge(context).copyWith(
                    fontFamily: "Open Sans",
                    color: primary_color,
                    fontSize: size / 8,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      );

  _gstAddressWidget(size, address) => Container(
        child: Text(address,
            style: AppStyle.titleLarge(context).copyWith(
                color: text_color.withOpacity(.6),
                fontSize: size / 16,
                fontWeight: FontWeight.w500)),
      );

  _businessCredentialWidget(size, text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
            color: background_dark_grey,
            borderRadius: BorderRadius.circular(2)),
        child: Text(text,
            style: AppStyle.titleLarge(context).copyWith(
                color: text_color.withOpacity(.6),
                fontSize: size / 20,
                fontWeight: FontWeight.w500)),
      );
}
