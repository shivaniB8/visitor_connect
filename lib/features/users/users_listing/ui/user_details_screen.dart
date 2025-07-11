import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/user_details_body.dart';
import 'package:host_visitor_connect/features/users/users_listing/ui/users/user.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';

class UserDetailsScreen extends StatefulWidget {
  final User? user;
  const UserDetailsScreen({
    super.key,
    this.user,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TitleBar(
            title: 'User',
          ),
          Positioned(
            top: 180,
            left: 0.1,
            right: 0.1,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          labelStyle: text_style_para1.copyWith(
                            fontSize: 16.0,
                            color: const Color(0xFFc9c9c9),
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelColor: Colors.black,
                          indicatorWeight: 1,
                          indicator: const UnderlineTabIndicator(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                          ),
                          unselectedLabelStyle: text_style_para1.copyWith(
                            fontSize: 15.0,
                            color: const Color(0xFFc9c9c9),
                            fontWeight: FontWeight.w500,
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              text: 'User',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: BlocProvider(
                                    create: (_) => OutgoingCallBloc(),
                                    child: UserDetailsBody(
                                      user: widget.user,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
