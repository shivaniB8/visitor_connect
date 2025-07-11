import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';

import 'package:host_visitor_connect/common/utils/route_generator.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/report_visitor_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'list_item_report.dart';
import 'model/report.dart';

class ReportListing extends StatefulWidget {
  final List<Report> reports;
  final bool? isUsers;
  final FiltersModel? filtersModel;
  const ReportListing(
      {Key? key, required this.reports, this.isUsers, this.filtersModel})
      : super(key: key);

  @override
  State<ReportListing> createState() => _ReportListingState();
}

class _ReportListingState extends State<ReportListing> {
  late ReportListBloc _reportListBloc;
  late ScrollController _visitorListScrollController;
  List<Report>? reports;

  void _listenToListScroll() {
    final scrollOffset = _visitorListScrollController.offset;
    final scrollPosition = _visitorListScrollController.position;

    // checking scroll offset & position
    if (!scrollPosition.outOfRange) {
      if (scrollOffset >= scrollPosition.maxScrollExtent) {
        //reached bottom
        //commented api call as pagination not added in backend
        _reportListBloc.getNextPageOfReports(
          filtersModel: widget.filtersModel,
        );
      }
    }
  }

  @override
  void initState() {
    _reportListBloc = context.read<ReportListBloc>();
    _visitorListScrollController = ScrollController();
    sorting();
    _visitorListScrollController.addListener(_listenToListScroll);
    super.initState();
  }

  @override
  void dispose() {
    _visitorListScrollController.removeListener(_listenToListScroll);
    _visitorListScrollController.dispose();
    super.dispose();
  }

  sorting() {
    if (_reportListBloc.isSort == true) {
      reports = widget.reports.reversed.toList();
    } else {
      reports = widget.reports.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        key: const PageStorageKey('listViewKey'),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        controller: _visitorListScrollController,
        itemCount: (widget.reports.length) + 1,
        itemBuilder: (context, index) {
          if (index < (reports?.length ?? 1)) {
            return MultiProvider(
              providers: [
                BlocProvider(
                  create: (context) => OutgoingCallBloc(),
                ),
              ],
              child: GestureDetector(
                child: ListItemReport(
                  report: reports?[index],
                  fullName: reports?[index].visitorFkValue,
                  reportBy: reports?[index].reportedUserName,
                  reportOn: reports?[index].timeReported,
                  reportDetails: reports?[index].reportDetails,
                  reportReason: reports?[index].reasonValue,
                  visitorFk: reports?[index].visitorFk,
                  gender: reports?[index].gender,
                  age: reports?[index].age,
                  aadharPhoto: reports?[index].aadharPhoto,
                  visitorPhoto: reports?[index].visitorPhoto,
                  roomNo: reports?[index].roomNo,
                  isReportHistory: false,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    goToRoute(
                      MultiProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => OutgoingCallBloc(),
                          ),
                        ],
                        child: ReportVisitorDetailsScreen(
                          report: reports?[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return _NextPageLoader();
          }
        },
      ),
    );
  }
}

// Loader for when next page of bookings is being fetched
class _NextPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final voterListingBloc = context.read<ReportListBloc>();

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24, bottom: 70),
        child: Visibility(
          visible: voterListingBloc.state is Progress,
          child: const LoadingWidget(
              // color: primary_color,
              ),
        ),
      ),
    );
  }
}
