import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/search_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/enum.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/data/network/responses/user_details_response.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoice_fragment.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoices_provider.dart';
import 'package:host_visitor_connect/features/payment_pateways/paytm/bloc/paytm_token_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_order_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_payment_bloc.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/model/add_money.dart';
import 'package:host_visitor_connect/features/payment_pateways/ui/payment_gateway_amount_screen.dart';
import 'package:host_visitor_connect/features/profile/ui/profile_page.dart';
import 'package:host_visitor_connect/features/profile/ui/profile_provider.dart';
import 'package:host_visitor_connect/features/profile/ui/widget/profileHead.dart';
import 'package:provider/provider.dart';

class CustomImageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool? showSettings;
  final bool? showEditIcon;
  final bool? showSearchField;
  final Function()? onSettingsClick;
  final SearchFilterState? searchFilterState;
  final SearchFilterState? searchListState;
  final Function(String)? onSearch;
  final bool? showProfileHeaed;
  final String? searchHint;
  final UserDetailsResponse? userData;
  final bool showBackButton;
  final Function()? onTap;
  final bool? isFromReportScreen;
  final bool? isFromConFormationScreen;
  final bool? isFromVisitorScreen;
  final List<Widget>? actionButton;
  final Function()? onEditIcon;

  const CustomImageAppBar(
      {Key? key,
      required this.title,
      this.actionButton,
      required this.context,
      this.showSettings = true,
      this.showEditIcon = true,
      this.showSearchField = false,
      this.onSettingsClick,
      this.searchFilterState,
      this.onEditIcon,
      this.searchListState,
      this.searchHint,
      this.showProfileHeaed = false,
      this.userData,
      this.onSearch,
      this.isFromVisitorScreen,
      this.showBackButton = true,
      this.onTap,
      this.isFromConFormationScreen,
      this.isFromReportScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = appSize(context: context, unit: 10) / 10;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$icons_path/appBar_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              AppBar(
                toolbarHeight: sizeHeight(context) / 12,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                title: Text(
                  title,
                  style: AppStyle.titleLarge(context)
                      .copyWith(color: primary_text_color),
                ),
                leading: (showBackButton)
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            '$icons_path/Arrow.png',
                            height: iconSize + 4,
                            width: iconSize + 4,
                          ),
                        ),
                      )
                    : null,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: actionButton ??
                    [
                      if (showSettings ?? true)
                        IconButton(
                          onPressed: onSettingsClick,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              '$icons_path/settings.png',
                              height: iconSize + 4,
                              width: iconSize + 4,
                            ),
                          ),
                        ),
                      if (showEditIcon ?? true)
                        IconButton(
                          onPressed: onEditIcon ??
                              () {
                                navigatorKey.currentState?.push(
                                  goToRoute(
                                    const ProfileProvider(
                                      child: ProfilePage(),
                                    ),
                                  ),
                                );
                              },
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              '$icons_path/user_edit.png',
                              height: iconSize + 4,
                              width: iconSize + 4,
                            ),
                          ),
                        ),
                    ],
              ),
              if (showSearchField ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SearchAppBar(
                    onSearch: onSearch,
                    hintText: searchHint,
                    searchFeildBgColor: Colors.transparent,
                  ),
                ),
              if (showProfileHeaed ?? false) ProfileHead(userData: userData)
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(showSearchField == true
      ? sizeHeight(context) / 6.5
      : showProfileHeaed == true
          ? sizeHeight(context) / 3.8
          : sizeHeight(context) / 9);
}

class WalletAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;

  const WalletAppBar({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double spacing = sizeHeight(context) / 100;
    return Stack(
      children: [
        _bg(),
        Column(
          children: [
            _header(),
            SizedBox(height: spacing),
            Table(
              children: [
                TableRow(children: [
                  Column(
                    children: [
                      Text(
                        "Total Wallet Balance",
                        style: AppStyle.titleSmall(context).copyWith(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      Text(
                        "₹ ${(context.watch<UserDetailsBloc>().state.getData()?.liveBalance ?? 0).getReadableCurrencyValue() ?? 0}",
                        style: AppStyle.titleLarge(context).copyWith(
                          color: Colors.white,
                          fontSize: sizeHeight(context) / 33,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Add Money in Wallet",
                          style: AppStyle.titleSmall(context)
                              .copyWith(color: Colors.white, fontSize: 10.sp)),
                      SizedBox(height: spacing / 2),
                      Button(
                        btnHeight: sizeHeight(context) / 22,
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeHeight(context) / 20),
                        isRectangularBorder: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(
                            goToRoute(
                              MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                    create: (_) => AddMoney(),
                                  ),
                                  Provider(
                                    create: (_) =>
                                        GlobalKey<FormBuilderState>(),
                                  ),
                                  BlocProvider(
                                    create: (_) => RazorPayOrderBloc(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<RazorPayPaymentBloc>(),
                                  ),
                                  BlocProvider(
                                    create: (_) => PaytmTokenBloc(),
                                  ),
                                ],
                                child: const PaymentGatewayAmountScreen(),
                              ),
                            ),
                          );
                        },
                        textColor: background_dark_grey,
                        child: Text(
                          "Add Money",
                          style: AppStyle.labelLarge(context),
                        ),
                      )
                    ],
                  ),
                ]),
                TableRow(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12, vertical: spacing + 4),
                      padding: EdgeInsets.symmetric(vertical: spacing + 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white24,
                      ),
                      child: Text(
                        "Add upto 100 visitors",
                        style: AppStyle.labelSmall(context).copyWith(
                          color: primary_text_color,
                          fontSize: sizeHeight(context) / 70,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12, vertical: spacing + 4),
                      padding: EdgeInsets.symmetric(vertical: spacing + 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white24,
                      ),
                      child: Text(
                        "Includes adding visitors",
                        style: AppStyle.labelSmall(context).copyWith(
                          color: primary_text_color,
                          fontSize: sizeHeight(context) / 70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _header() {
    return AppBar(
      toolbarOpacity: 0.8,
      toolbarHeight: sizeHeight(context) / 20,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Image.asset(
          '$icons_path/Arrow.png',
          width: sizeHeight(context) / 30,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Text(
        'Wallet',
        style: AppStyle.titleLarge(context).copyWith(
            fontSize: sizeHeight(context) / 34,
            fontWeight: FontWeight.w500,
            color: primary_text_color),
      ),
      actions: <Widget>[
        // PopupMenuButton<int>(
        //   iconColor: Colors.white,
        //   iconSize: sizeHeight(context) / 34,
        //   onSelected: (item) {},
        //   itemBuilder: (context) => [
        //     PopupMenuItem<int>(
        //         value: 0,
        //         child: _popUpMenuTile(
        //           "Receipts",
        //           CupertinoIcons.doc_text,
        //           () {
        //
        //           },
        //         )),
        //     PopupMenuItem<int>(
        //         value: 1,
        //         child: _popUpMenuTile(
        //             "Tax Invoices", CupertinoIcons.doc_plaintext, () {
        //           // Navigator.of(context).push(goToRoute(
        //           //     const InvoicesProvider(child: InvoiceFragment())));
        //         })),
        //     PopupMenuItem<int>(
        //         value: 2,
        //         child: _popUpMenuTile(
        //             "Monthly Invoices", CupertinoIcons.doc_chart, () {})),
        //   ],
        // ),
      ],
    );
  }

  Widget _popUpMenuTile(String title, IconData icon, Function() onTap) =>
      ListTile(
        onTap: onTap,
        title: Text(title),
        leading: Icon(icon),
      );

  Widget _bg() => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$icons_path/appBar_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(sizeHeight(context) / 4.5);
}
