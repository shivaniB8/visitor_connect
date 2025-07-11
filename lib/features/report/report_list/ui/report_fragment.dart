import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/ui/reported_visitor_list_builder.dart';

class ReportFragment extends StatefulWidget {
  const ReportFragment({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportFragment> createState() => ReportFragmentState();
}

class ReportFragmentState extends State<ReportFragment>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<ReportListBloc>().getReportList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const ReportedVisitorListBuilder();
  }

  @override
  bool get wantKeepAlive => true;
}
