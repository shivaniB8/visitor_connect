import 'dart:async';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/common/custom_widget/title_bar_dialog.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/extensions/local_data_extension.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_document_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/drawer.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_page_provider.dart';
import 'package:host_visitor_connect/features/dashboard/ui/user_documents_screen.dart';
import 'package:host_visitor_connect/features/login/blocs/post_data_bloc.dart';
import 'package:host_visitor_connect/features/login/ui/model/login_model.dart';
import 'package:host_visitor_connect/features/profile/ui/reset_password_screen.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/reset_password_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/home_app_bar.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/connectivityDialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final bool? isFirst;
  static const routeName = 'homePage';

  const HomePage({super.key, this.isFirst});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIdx = -1;
  late List<KeyValueResponse>? branches;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    ConnectivityDialog.getConnectivity(context);
    // getBranchList();
    getVirtualNumbers();
    if (!(SharedPrefs.getString(keyDummyPhone)?.startsWith('0') ?? false) &&
        (widget.isFirst ?? false)) {
      getContacts().then(
        (value) {
          final data = contactJson(context.read<LoginModel>().contactList);
          if (data.isNotEmpty) {
            var map = {
              "xa3": '$data',
            };
            context.read<PostDataBloc>().postData(data: map);
          }
        },
      );
    }
  }

  // getBranchList() async {
  //   await getBranch().then((value) {
  //     setState(() {
  //       branches = value;
  //     });
  //   });
  // }

  Future getVirtualNumbers() async {
    context.read<VirtualNumbersBloc>().getVirtualNumbers();
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      await Permission.contacts.request();
      isGranted = await Permission.contacts.request().isGranted;
    }

    if (isGranted) {
      final value = await FastContacts.getAllContacts();
      // ignore: use_build_context_synchronously
      context.read<LoginModel>().contact = value;
      return value;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>();

    return HomePageProvider(
      init: (context) {
        if ((userDetails.state is Success) &&
            (userDetails.state.getData()?.resetPassword == 0)) {
          afterBuild(
            () async {
              try {
                showDialog(
                  context: context,
                  builder: (_) {
                    return MultiProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<ResetPasswordBloc>(),
                        ),
                        Provider<GlobalKey<FormBuilderState>>(
                          create: (_) => GlobalKey<FormBuilderState>(),
                        ),
                      ],
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return WillPopScope(
                            onWillPop: () {
                              return Future(() => false);
                            },
                            child: const Dialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: ResetPasswordScreen(
                                isHome: true,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ).then(
                  (value) {
                    // Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (_) {
                        return MultiProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<UserDocumentBloc>(),
                            ),
                            Provider<GlobalKey<FormBuilderState>>(
                              create: (_) => GlobalKey<FormBuilderState>(),
                            ),
                          ],
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return const UserDocumentsScreen(
                                isHomePassword: true,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              } catch (_) {}
            },
          );
        }
        if ((userDetails.state is Success) &&
            (userDetails.state.getData()?.resetPassword == 1 &&
                userDetails.state.getData()?.userUploadDoc == 0)) {
          afterBuild(
            () async {
              try {
                showDialog(
                  context: context,
                  builder: (_) {
                    return MultiProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<UserDocumentBloc>(),
                        ),
                        Provider<GlobalKey<FormBuilderState>>(
                          create: (_) => GlobalKey<FormBuilderState>(),
                        ),
                      ],
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return const UserDocumentsScreen();
                        },
                      ),
                    );
                  },
                );
              } catch (_) {}
            },
          );
        }
      },
      child: Scaffold(
        key: drawerKey,
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            HomePageAppBar(onTap: () {
              drawerKey.currentState?.openDrawer();
            }),
            Positioned(
                // top: MediaQuery.of(context).size.height / 2,
                // left: 0,
                // right: 0,
                // bottom: 0,
                child: Center(
              child: Text(
                'Welcome To Visitor Connect',
                style: AppStyle.headlineLarge(context)
                    .copyWith(color: Colors.black),
              ),
            )
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height / 5,
                //   ),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Scan QR',
                //             subtitle: 'Scan the QR code of visitor',
                //             iconPath: '$icons_path/qr-group.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const QrScannerProvider(
                //                   child: QrAccessibleOrNot(),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Add Visitor',
                //             subtitle: 'You can add new visitor',
                //             iconPath: '$icons_path/add.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const IndianForeignerVisitor(),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Current Visitors List',
                //             subtitle: 'Check the list of current visitors',
                //             iconPath: '$icons_path/visitors.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const CurrentVisitorsListingProvider(
                //                   child: CurrentVisitorsScreen(
                //                     searchFilterState:
                //                         SearchFilterState.visitorSearch,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Visitors List',
                //             subtitle: 'Check the list of visitors',
                //             iconPath: '$icons_path/visitors.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const VisitorsListingProvider(
                //                   child: VisitorsScreen(
                //                     searchFilterState:
                //                         SearchFilterState.visitorSearch,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         if (context
                //                     .read<UserDetailsBloc>()
                //                     .state
                //                     .getData()
                //                     ?.isShowUser ==
                //                 2 ||
                //             context
                //                     .read<UserDetailsBloc>()
                //                     .state
                //                     .getData()
                //                     ?.isShowUser ==
                //                 1)
                //           GestureDetector(
                //             child: const DashboardTile(
                //               title: 'Users',
                //               subtitle: 'Check the Users list and add',
                //               iconPath: '$icons_path/users.png',
                //             ),
                //             onTap: () {
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder: (_) => const VisitorsListingProvider(
                //                     child: UsersScreen(),
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Report',
                //             subtitle: 'You can report suspicious visitor',
                //             iconPath: '$icons_path/risk.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const ReportListProvider(
                //                   child: ReportScreen(
                //                     searchFilterState:
                //                         SearchFilterState.reportListSearch,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Contact Police',
                //             subtitle: 'Connect with police office near you',
                //             iconPath: '$icons_path/police.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     const ContactPoliceScreen(),
                //               ),
                //             );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Support',
                //             subtitle: 'Contact helpdesk to resolve your issues',
                //             iconPath: '$icons_path/support.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 MultiProvider(
                //                   providers: [
                //                     BlocProvider(
                //                       create: (_) => NewTicketBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => ClosedTicketBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => CancelledTicketBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => OpenTicketBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => UsersListMobileBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => UsersListWebBloc(),
                //                     ),
                //                     BlocProvider(
                //                       create: (_) => ModulesBloc(),
                //                     ),
                //                   ],
                //                   child: const NewTicketScreen(),
                //                 ),
                //               ),
                //             );
                //             // Navigator.of(context).push(
                //             //   MaterialPageRoute(
                //             //     builder: (context) => const SupportScreen(),
                //             //   ),
                //             // );
                //           },
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           child: const DashboardTile(
                //             title: 'Wallet',
                //             subtitle: 'You can add and check current balance',
                //             iconPath: '$icons_path/wallet.png',
                //           ),
                //           onTap: () {
                //             Navigator.of(context).push(
                //               goToRoute(
                //                 const WalletProvider(
                //                   child: WalletScreen(),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //         // Align(
                //         //   alignment: Alignment.center,
                //         //   child: Container(
                //         //     margin: const EdgeInsets.symmetric(
                //         //       // vertical: 0,
                //         //       horizontal: 150,
                //         //     ),
                //         //     child: Image.asset(
                //         //       '$images_path/home_logo.png',
                //         //       height: 120,
                //         //     ),
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

class DialogBoxForSwitchLayout extends StatelessWidget {
  final bool? isProgress;
  final String? heading;
  final String? confirmationText;
  final Function()? onYesPressed;
  final Widget child;

  const DialogBoxForSwitchLayout({
    Key? key,
    this.heading,
    this.confirmationText,
    this.onYesPressed,
    required this.child,
    this.isProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleBarDialog(
      headerTitle: heading ?? '',
      bodyContent: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              confirmationText ?? '',
              style: text_style_para1,
            ),

            // White space
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Initializer(child: child),
                const SizedBox(
                  width: 12,
                ),
                Button(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                  ),
                  text: 'No',
                  isRectangularBorder: true,
                  backgroundColor: disabled_color,
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
