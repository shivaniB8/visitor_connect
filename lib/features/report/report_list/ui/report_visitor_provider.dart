import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_reasons_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';

import 'package:provider/provider.dart';

import 'model/report_visitor.dart';

class ReportVisitorProviders extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final ReportReasonsBloc? reasonsBloc;
  final ReportVisitorBloc? reportVisitorBloc;
  final ReportVisitor? reportVisitor;
  final OutgoingCallBloc? outgoingCallBloc;

  const ReportVisitorProviders({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.reasonsBloc,
    this.reportVisitorBloc,
    this.reportVisitor,
    this.outgoingCallBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  ReportReasonsBloc _getReportReasonsBloc(BuildContext context) {
    return reasonsBloc ?? ReportReasonsBloc();
  }

  ReportVisitor _getReportVisitor(BuildContext context) {
    return reportVisitor ?? ReportVisitor();
  }

  OutgoingCallBloc _getOutgoingCallBloc(BuildContext context) {
    return outgoingCallBloc ?? OutgoingCallBloc();
  }

  ReportVisitorBloc _getReportVisitorBloc(BuildContext context) {
    return reportVisitorBloc ?? ReportVisitorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getReportReasonsBloc),
        BlocProvider(create: _getReportVisitorBloc),
        ChangeNotifierProvider(create: _getReportVisitor),
        BlocProvider(create: _getOutgoingCallBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
