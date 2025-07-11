import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/enum.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/create_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/modules_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_mobile_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/users_list_web_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/bloc/cancelled_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/cancelled_tickets/ui/cancelled_ticket_fragment.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/bloc/closed_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/closed_tickets/ui/closed_ticket_fragment.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/bloc/new_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/new_tickets/ui/new_ticket_fragment.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/bloc/open_ticket_bloc.dart';
import 'package:host_visitor_connect/features/support_ticket/open_ticket/ui/open_ticket_fragment.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/create_new_ticket_dialog.dart';
import 'package:host_visitor_connect/features/support_ticket/ui/support_ticket_filter.dart';
import 'package:provider/provider.dart';

class NewTicketScreen extends StatefulWidget {
  // final FiltersModel? filterModel;
  final bool? filterApplied;
  final int initialIndex;
  final String searchedValue;
  final bool? clearSearchText;
  final int? currentOpenedTab;
  final SearchFilterState? searchFilterState;

  const NewTicketScreen({
    super.key,
    this.clearSearchText,
    // this.filterModel,
    this.initialIndex = 0,
    this.searchedValue = '',
    this.filterApplied,
    this.currentOpenedTab,
    this.searchFilterState,
  });

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Manage Tickets',
        context: context,
        showSearchField: false,
        showEditIcon: false,
        showSettings: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              SizedBox(height: appSize(context: context, unit: 10) / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: Icon(CupertinoIcons.add,
                        size: appSize(context: context, unit: 10) / 9),
                    style: AppStyle.bodyMedium(context).copyWith(
                      color: Colors.white,
                    ),
                    btnHeight: appSize(context: context, unit: 10) / 6,
                    isRectangularBorder: true,
                    onPressed: () {
                      context.read<UsersListMobileBloc>().getUsersMobileList();
                      context.read<UsersListWebBloc>().getUsersWebList();
                      context.read<ModulesBloc>().getModules();
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MultiProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<UsersListWebBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<NewTicketBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<UsersListMobileBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<ModulesBloc>(),
                              ),
                              BlocProvider(
                                create: (_) => CreateTicketBloc(),
                              ),
                              ChangeNotifierProvider(
                                create: (_) => CreateTicket(),
                              )
                            ],
                            child: const CreateNewTicketDialog(),
                          );
                        },
                      );
                    },
                    text: 'Create New Ticket',
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return MultiProvider(
                            providers: [
                              Provider<GlobalKey<FormBuilderState>>(
                                create: (_) => GlobalKey<FormBuilderState>(),
                              ),
                              BlocProvider.value(
                                value: context.read<NewTicketBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<OpenTicketBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<ClosedTicketBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<CancelledTicketBloc>(),
                              ),
                            ],
                            child: SupportTicketFilter(
                              currentTab: _tabController.index,
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: buttonColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset("$icons_path/filter.png",
                            width: appSize(context: context, unit: 10) / 10),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: appSize(context: context, unit: 10) / 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomButton(
                      changeColor: (value) {
                        if (value) {
                          setState(() {});
                        }
                      },
                      label: 'New Ticket',
                      tabIndex: 0,
                      tabController: _tabController,
                    ),
                    CustomButton(
                      changeColor: (value) {
                        if (value) {
                          setState(() {});
                        }
                      },
                      label: 'Open Ticket',
                      tabIndex: 1,
                      tabController: _tabController,
                    ),
                    CustomButton(
                      changeColor: (value) {
                        if (value) {
                          setState(() {});
                        }
                      },
                      label: 'Closed Ticket',
                      tabIndex: 2,
                      tabController: _tabController,
                    ),
                    CustomButton(
                      changeColor: (value) {
                        if (value) {
                          setState(() {});
                        }
                      },
                      label: 'Cancelled Ticket',
                      tabIndex: 3,
                      tabController: _tabController,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    NewTicketFragment(),
                    OpenTicketFragment(),
                    ClosedTicketFragment(),
                    CancelledTicketFragment(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String label;
  final int tabIndex;
  final TabController tabController;
  final Function(bool)? changeColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.tabIndex,
    required this.tabController,
    this.changeColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color color = background_grey_color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Button(
        btnHeight: appSize(context: context, unit: 10) / 6,
        buttonType: widget.tabIndex == widget.tabController.index
            ? ButtonType.solid
            : ButtonType.stroked,
        isRectangularBorder: true,
        borderColor: background_dark_grey,
        backgroundColor:
            widget.tabIndex == widget.tabController.index ? Colors.grey : color,
        onPressed: () {
          widget.changeColor?.call(true);

          widget.tabController.animateTo(widget.tabIndex);
        },
        child: Text(
          widget.label,
          style: AppStyle.bodyLarge(context).copyWith(
              fontSize: appSize(context: context, unit: 10) / 16,
              color: Colors.black.withOpacity(0.7)),
        ),
      ),
    );
  }
}
