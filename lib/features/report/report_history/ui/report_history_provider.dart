import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/report/report_history/bloc/report_history_bloc.dart';
import 'package:provider/provider.dart';

class ReportHistoryProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final ReportHistoryListBloc? reportHistoryListBloc;
  final GlobalKey<FormBuilderState>? formKey;

  const ReportHistoryProvider({
    Key? key,
    required this.child,
    this.init,
    this.reportHistoryListBloc,
    this.formKey,
  }) : super(key: key);

  ReportHistoryListBloc _getVisitorsHistoryListingBloc(BuildContext context) {
    return reportHistoryListBloc ?? ReportHistoryListBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getVisitorsHistoryListingBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
