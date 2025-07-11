import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/swipable_visitor.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/visitor_details.dart';
import 'package:provider/provider.dart';
import 'list_item_visitor.dart';

class VisitorsItemList extends StatefulWidget {
  final Room? room;
  final bool? isUsers;
  final FiltersModel? filtersModel;
  final bool? showCheckoutButton;
  final int? visitorsLength;
  final bool? isFromCurrentVisitors;
  final String? businessType;

  const VisitorsItemList({
    Key? key,
    this.room,
    this.isUsers,
    this.filtersModel,
    this.showCheckoutButton,
    this.visitorsLength,
    this.isFromCurrentVisitors,
    this.businessType,
  }) : super(key: key);

  @override
  State<VisitorsItemList> createState() => _VisitorsItemListState();
}

class _VisitorsItemListState extends State<VisitorsItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: 'Visitors List',
        context: context,
        showEditIcon: false,
        showSettings: false,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 15),
        itemCount: widget.room?.visitors?.length,
        itemBuilder: (context, index) {
          final visitorResponse = widget.room?.visitors?[index];
          final visitor =
              convertVisitorDetailsResponseToVisitor(visitorResponse);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                goToRoute(
                  VisitorDetails(
                    businessType: widget.businessType,
                    isFromCurrentVisitors: widget.isFromCurrentVisitors,
                    visitor: visitor,
                  ),
                ),
              );
            },
            child: MultiProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<OutgoingCallBloc>(),
                ),
                ChangeNotifierProvider.value(
                  value: context.read<CheckOutVisitor>(),
                ),
              ],
              child: ListItemVisitor(
                businessType: widget.businessType,
                isFromMainList: false,
                visitorLength: 1,
                isFromCurrentVisitors: widget.isFromCurrentVisitors,
                visitor: visitor,
              ),
            ),
          );
        },
      ),
    );
  }
}
