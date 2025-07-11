import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/constant/globalVariable.dart';
import 'package:host_visitor_connect/common/custom_widget/navigation_expansion_tile.dart';
import 'package:host_visitor_connect/common/custom_widget/navigation_item.dart';
import 'package:host_visitor_connect/common/enum.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/invoices/ui/account_statement_screen.dart';
import 'package:host_visitor_connect/features/invoices/ui/billing_dashboard_screen.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoice_fragment.dart';
import 'package:host_visitor_connect/features/invoices/ui/invoices_provider.dart';
import 'package:host_visitor_connect/features/invoices/ui/receipts/receipt_fragment.dart';
import 'package:host_visitor_connect/features/invoices/ui/receipts/receipts_provider.dart';
import 'package:host_visitor_connect/features/payment_pateways/razorpay/bloc/razor_pay_payment_bloc.dart';
import 'package:host_visitor_connect/features/police/ui/contact_police_screen.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_accessible_or_not.dart';
import 'package:host_visitor_connect/features/qr/ui/qr_provider.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/modules_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_mobile_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_web_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/bloc/cancelled_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/bloc/closed_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/ui/new_ticket_screen.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users_screen.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/indian_foreginer.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/ui/current_visitors_provider.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/ui/current_visitors_screen.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_listing_provider.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitors_screen.dart';
import 'package:host_visitor_connect/features/wallet/bloc/bar_graph_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>();
    return Drawer(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E2B72),
              Color(0xFF354392),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              _header(context, userDetails),
              Expanded(
                // Specify your desired height here
                child: SingleChildScrollView(child: _content(context, context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, UserDetailsBloc userDetails) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        // color: Colors.transparent,
        gradient: LinearGradient(
          colors: [
            Color(0xFF1E2B72),
            Color(0xFF354392),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: sizeHeight(context) / 18,
            left: sizeHeight(context) / 40,
            right: sizeHeight(context) / 40,
            bottom: sizeHeight(context) / 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.white,
              //     width: 1,
              //   ),
              //   // color: Colors.white, // Border color
              //   shape: BoxShape.circle,
              // ),
              child: CachedNetworkImage(
                height: sizeHeight(context) / 15,
                width: sizeHeight(context) / 15,
                fit: BoxFit.cover,
                imageUrl:
                    '$googlePhotoUrl${getBucketName()}$userPhoto${userDetails.state.getData()?.userPhoto}',
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
                placeholder: (context, url) => Padding(
                  padding: EdgeInsets.all(sizeHeight(context) / 40),
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  color: Colors.white,
                  size: sizeHeight(context) / 15,
                ),
              ),
            ),
            SizedBox(width: sizeHeight(context) / 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizedString(
                        userDetails.state.getData()?.fullName ?? ''),
                    style: AppStyle.titleMedium(context).copyWith(
                        color: primary_text_color, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: sizeHeight(context) / 200),
                  Text(
                    userDetails.state.getData()?.designation ?? "",
                    style: AppStyle.bodySmall(context).copyWith(
                        color: lightWhiteColor, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: sizeHeight(context) / 300),
                  Text(
                    capitalizedString(
                        userDetails.state.getData()?.clientName ?? ""),
                    style: AppStyle.bodySmall(context).copyWith(
                        color: lightWhiteColor, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context, setState) {
    double iconSize = appSize(context: context, unit: 10) / 10;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Dashboard',
              style: AppStyle.bodyMedium(context)
                  .copyWith(color: dashboadrColor, fontSize: 16.sp),
              // Adjust font size as needed
            ),
            leading: Image.asset(
              '$icons_path/dashboard.png',
              height: iconSize,
              width: iconSize,
            ),
          ),
          // SizedBox(height: sizeHeight(context)/70),
          NavigationExpansionTile(
            key: const Key("1"),
            iconPath: '$icons_path/hosts.png',
            height: iconSize,
            width: iconSize,
            title: 'Visitors',
            children: [
              const Divider(
                color: Colors.white,
                thickness: 2, // Set the color to white
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: sizeWidth(context) / 80, right: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    // Background color of the container

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  child: Column(
                    children: [
                      NavigationItem(
                        height: iconSize - 3,
                        width: iconSize - 3,
                        iconPath: '$icons_path/list_user.png',
                        title: 'Current Visitors List',
                        onTap: () {
                          GlobalVariable.selectedCarRental = 0;
                          Navigator.of(context).push(
                            goToRoute(
                              const CurrentVisitorsListingProvider(
                                child: CurrentVisitorsScreen(
                                  searchFilterState:
                                      SearchFilterState.visitorSearch,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Divider(
                          color: dashboadrColor, // Set divider color to white
                          thickness: 1, // Set thickness of the divider line
                        ),
                      ),
                      NavigationItem(
                        iconPath: '$icons_path/list_user.png',
                        height: iconSize - 3,
                        width: iconSize - 3,
                        title: 'Visitors List',
                        onTap: () {
                          GlobalVariable.selectedCarRental = 1;
                          Navigator.of(context).push(
                            goToRoute(
                              const VisitorsListingProvider(
                                child: VisitorsScreen(
                                  searchFilterState:
                                      SearchFilterState.visitorSearch,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Divider(
                          color: dashboadrColor, // Set divider color to white
                          thickness: 1, // Set thickness of the divider line
                        ),
                      ),
                      NavigationItem(
                        iconPath: '$icons_path/add.png',
                        color: Colors.white,
                        height: iconSize - 3,
                        width: iconSize - 3,
                        title: 'Add Visitor',
                        onTap: () {
                          Navigator.of(context).push(
                            goToRoute(
                              const IndianForeignerVisitor(),
                            ),
                          );
                        },
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //   child: Divider(
                      //     color: dashboadrColor, // Set divider color to white
                      //     thickness: 1, // Set thickness of the divider line
                      //   ),
                      // ),
                      // NavigationItem(
                      //   iconPath: '$icons_path/permission_set.png',
                      //   height: iconSize - 3,
                      //   width: iconSize - 3,
                      //   title: 'Report Visitor',
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       goToRoute(
                      //         const ReportListProvider(
                      //           child: ReportScreen(
                      //             searchFilterState:
                      //                 SearchFilterState.reportListSearch,
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              // Background color of the container

              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            ),
            child: Column(
              children: [
                NavigationItem(
                  iconPath: '$images_path/qr-code.png',
                  color: dashboadrColor,
                  height: iconSize,
                  width: iconSize,
                  title: 'Scan QR',
                  titleStyle: const TextStyle(
                    color: dashboadrColor, // Custom title color

                    fontWeight: FontWeight.w400, // Custom title font weight
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      goToRoute(
                        const QrScannerProvider(
                          child: QrAccessibleOrNot(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (context.read<UserDetailsBloc>().state.getData()?.isShowUser ==
                  2 ||
              context.read<UserDetailsBloc>().state.getData()?.isShowUser == 1)
            Column(
              children: [
                const SizedBox(height: 20),
                NavigationExpansionTile(
                  key: const Key("2"),
                  iconPath: '$icons_path/user.png',
                  color: dashboadrColor,
                  title: 'Users',
                  children: [
                    const Divider(
                      color: Colors.white,
                      thickness: 2, // Set the color to white
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth(context) / 80, right: 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          // Background color of the container

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            NavigationItem(
                              iconPath: '$icons_path/list_user.png',
                              title: 'List Users',
                              onTap: () {
                                Navigator.of(context).push(
                                  goToRoute(
                                    const VisitorsListingProvider(
                                      child: UsersScreen(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          // const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              // Background color of the container

              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            ),
            child: Column(
              children: [
                NavigationItem(
                  iconPath: '$icons_path/police.png',
                  color: dashboadrColor,
                  height: iconSize,
                  width: iconSize,
                  title: 'Contact Police',
                  titleStyle: const TextStyle(
                    color: dashboadrColor, // Custom title color

                    fontWeight: FontWeight.w400, // Custom title font weight
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      goToRoute(
                        const ContactPoliceScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              // Background color of the container
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            ),
            child: Column(
              children: [
                NavigationItem(
                  iconPath: '$icons_path/wallet.png',
                  title: 'Wallet',
                  color: dashboadrColor,
                  height: iconSize,
                  width: iconSize,
                  titleStyle: const TextStyle(
                    color: dashboadrColor, // Custom title color
                    fontWeight: FontWeight.w400, // Custom title font weight
                  ),
                  onTap: () {
                    context.read<UserDetailsBloc>().userDetails();
                    Navigator.of(context).push(
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
                  },
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          _billing(context, iconSize),
          NavigationExpansionTile(
            key: const Key("4"),
            // key: const Key("6"),
            // initiallyExpanded: selectedTile == 1,

            iconPath: '$icons_path/support_ticket.png',
            height: iconSize,
            width: iconSize,
            title: 'Support',
            children: [
              const Divider(
                color: Colors.white,
                thickness: 2, // Set the color to white
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: sizeWidth(context) / 80, right: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    // Background color of the container

                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  child: Column(
                    children: [
                      NavigationItem(
                        iconPath: '$icons_path/visitors.png',
                        color: Colors.white,
                        height: iconSize - 3,
                        width: iconSize - 3,
                        title: 'Manage Tickets',
                        onTap: () {
                          Navigator.of(context).push(
                            goToRoute(
                              MultiProvider(
                                providers: [
                                  BlocProvider(
                                    create: (_) => NewTicketBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => ClosedTicketBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => CancelledTicketBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => OpenTicketBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => UsersListMobileBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => UsersListWebBloc(),
                                  ),
                                  BlocProvider(
                                    create: (_) => ModulesBloc(),
                                  ),
                                ],
                                child: const NewTicketScreen(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billing(context, iconSize) => NavigationExpansionTile(
        key: const Key("3"),
        // key: const Key("6"),
        // initiallyExpanded: selectedTile == 1,

        iconPath: '$icons_path/billing.png',
        height: iconSize,
        width: iconSize,
        title: 'Billing',
        children: [
          const Divider(
            color: Colors.white,
            thickness: 2, // Set the color to white
          ),
          Padding(
            padding: EdgeInsets.only(left: sizeWidth(context) / 80, right: 0),
            child: Container(
              decoration: const BoxDecoration(
                // Background color of the container

                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              child: Column(
                children: [
                  NavigationItem(
                    iconPath: '$icons_path/dashboard.png',
                    height: iconSize - 3,
                    width: iconSize - 3,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.of(context).push(
                        goToRoute(BlocProvider(
                          create: (_) => UserDetailsBloc(),
                          child: const BillingDashboardScreen(),
                        )),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Divider(
                      color: dashboadrColor, // Set divider color to white
                      thickness: 1, // Set thickness of the divider line
                    ),
                  ),
                  NavigationItem(
                    height: iconSize - 3,
                    width: iconSize - 3,
                    iconPath: '$icons_path/bill.png',
                    color: Colors.white,
                    title: 'Account Statements',
                    onTap: () {
                      Navigator.of(context).push(
                        goToRoute(MultiBlocProvider(providers: [
                          BlocProvider(
                            create: (_) => HostAccountStatementBloc(),
                          ),
                        ], child: const AccountStatementScreen())),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Divider(
                      color: dashboadrColor, // Set divider color to white
                      thickness: 1, // Set thickness of the divider line
                    ),
                  ),
                  NavigationItem(
                    iconPath: '$icons_path/receipt.png',
                    color: Colors.white,
                    height: iconSize - 3,
                    width: iconSize - 3,
                    title: 'Receipts',
                    onTap: () {
                      Navigator.of(context).push(goToRoute(
                          const ReceiptsProvider(child: ReceiptFragment())));
                      // Navigator.of(context).push(
                      //   goToRoute(
                      //     const VisitorsListingProvider(
                      //       child: VisitorsScreen(
                      //         searchFilterState:
                      //             SearchFilterState.visitorSearch,
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Divider(
                      color: dashboadrColor, // Set divider color to white
                      thickness: 1, // Set thickness of the divider line
                    ),
                  ),
                  NavigationItem(
                    iconPath: '$icons_path/taxes.png',
                    color: Colors.white,
                    height: iconSize - 3,
                    width: iconSize - 3,
                    title: 'Tax Invoices',
                    onTap: () {
                      Navigator.of(context).push(goToRoute(
                          const InvoicesProvider(child: InvoiceFragment())));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
