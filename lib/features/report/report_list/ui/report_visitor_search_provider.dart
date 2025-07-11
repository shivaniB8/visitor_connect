import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_visitor_search_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';

import 'package:provider/provider.dart';

import 'model/search_term.dart';

class ReportDeathProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final ReportVisitorSearchTermBloc? reportVisitorSearchTermBloc;
  final OutgoingCallBloc? outgoingCallBloc;
  final CheckOutVisitor? checkOutVisitor;

  const ReportDeathProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.reportVisitorSearchTermBloc,
    this.outgoingCallBloc,
    this.checkOutVisitor,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  ReportVisitorSearchTermBloc _getReportVisitorSearchTermBloc(BuildContext context) {
    return reportVisitorSearchTermBloc ?? ReportVisitorSearchTermBloc();
  }

  OutgoingCallBloc _getOutgoingCallBloc(BuildContext context) {
    return outgoingCallBloc ?? OutgoingCallBloc();
  }

  CheckOutVisitor _checkOutVisitor(BuildContext context) {
    return checkOutVisitor ?? CheckOutVisitor();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getReportVisitorSearchTermBloc),
        BlocProvider(create: _getOutgoingCallBloc),
        ChangeNotifierProvider(
          create: (_) => ReportSearch(),
        ),
        ChangeNotifierProvider(create: _checkOutVisitor),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
