// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/authentication_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_action_dilog.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/app_expansion_tile.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/ui/edit_profile_provider.dart';
import 'package:host_visitor_connect/features/login/blocs/logout_bloc.dart';
import 'package:host_visitor_connect/features/profile/bloc/delete_account_bloc.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:host_visitor_connect/features/profile/ui/delete_profile_builder.dart';
import 'package:host_visitor_connect/features/profile/ui/edit_profile.dart';
import 'package:host_visitor_connect/features/profile/ui/logout_profile_builder.dart';
import 'package:host_visitor_connect/features/profile/ui/profile_provider.dart';
import 'package:host_visitor_connect/features/profile/ui/reset_password_screen.dart';
import 'package:host_visitor_connect/features/profile/ui/widget/profileDetails.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<KeyValueResponse>? titlesData;

  @override
  void initState() {
    getTitle();
    super.initState();
  }

  getTitle() async {
    if (titlesData == null) {
      await context.read<TitlesBloc>().getTitles();
      titlesData = context.read<TitlesBloc>().state.getData()?.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<UserDetailsBloc>().state.getData();
    return Scaffold(
        appBar: CustomImageAppBar(
          showProfileHeaed: true,
          title: 'Profile Details',
          context: context,
          userData: userDetails,
          showSettings: false,
          onEditIcon: () async {
            await getTitle();
            if (titlesData != null) {
              Navigator.push(
                context,
                goToRoute(
                  EditProfileProvider(
                    child: EditProfile(
                      titles: titlesData,
                      userDetails: userDetails,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                            top: sizeHeight(context) / 40,
                            left: 15,
                            right: 15,
                            bottom: sizeHeight(context) / 40),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileDetails(
                                userData: userDetails,
                              ),
                              _expoTile("Settings", 1, "Change Password"),
                              _expoTile("Logout", 2, ""),
                              // _expoTile("Delete Profile", 3, ""),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _expoTile(String title, int index, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(top: sizeHeight(context) / 30),
      child: AppExpansionTile(
        backgroundColor: expotileBgColor,
        onExpansionChanged: (value) {
          if (index != 1) switchFunction(index);
        },
        decoration: BoxDecoration(
          color: expotileBgColor,
          borderRadius: BorderRadius.circular(11),
        ),
        iconRotate: index != 1 ? false : true,
        iconColor: profileTileColor,
        showBorders: false,
        title: Text(
          title,
          style: AppStyle.bodyLarge(context)
              .copyWith(color: profileTileColor, fontWeight: FontWeight.w400),
        ),
        children: index != 1
            ? []
            : [
                ListTile(
                  title: Text(
                    subtitle,
                    style: AppStyle.bodySmall(context)
                        .copyWith(color: profileTileColor),
                  ),
                  onTap: () {
                    switchFunction(index);
                  },
                ),
                ListTile(
                  title: Text(
                    "Delete Profile",
                    style: AppStyle.bodySmall(context)
                        .copyWith(color: profileTileColor),
                  ),
                  onTap: () {
                    AppActionDialog.showActionDialog(
                      image: "$icons_path/warning.png",
                      context: context,
                      title: "Delete Profile",
                      subtitle:
                          "Are you sure you want to delete your\n profile, this action cannot be undone.",
                      positiveButtonText: "Delete",
                      child: MultiProvider(
                        providers: [
                          BlocProvider.value(
                              value: context.read<DeleteAccountBloc>()),
                        ],
                        child: DeleteProfileBuilder(
                          onSetAsPrimaryPressed: () {
                            context.read<DeleteAccountBloc>().deleteAccount();
                          },
                        ),
                      ),
                      showLeftSideButton: true,
                      negativeButtonText: "Cancel",
                    );
                  },
                )
              ],
      ),
    );
  }

  void switchFunction(int index) {
    switch (index) {
      case 1:
        Navigator.of(context).push(
          goToRoute(
            const ProfileProvider(
              child: ResetPasswordScreen(),
            ),
          ),
        );
        break;
      case 2:
        AppActionDialog.showActionDialog(
            warning: true,
            image: "$icons_path/warning.png",
            context: context,
            title: "Logout",
            subtitle: "Are you sure you want to logout your profile.",
            positiveButtonText: "Logout",
            child: MultiProvider(
              providers: [
                BlocProvider.value(value: context.read<LogoutBloc>()),
                BlocProvider.value(value: context.read<AuthenticationBloc>()),
              ],
              child: LogoutProfileBuilder(
                onSetAsPrimaryPressed: () {
                  context.read<LogoutBloc>().logout();
                  context.read<AuthenticationBloc>().logout();
                },
              ),
            ),
            showLeftSideButton: true,
            negativeButtonText: "Cancel");
        break;
      default:
    }
  }
}
