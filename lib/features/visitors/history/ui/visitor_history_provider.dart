import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitor_history_bloc.dart';
import 'package:provider/provider.dart';

class VisitorsHistoryProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final VisitorsHistoryListingBloc? visitorsHistoryListingBloc;
  final GlobalKey<FormBuilderState>? formKey;

  const VisitorsHistoryProvider({
    Key? key,
    required this.child,
    this.init,
    this.visitorsHistoryListingBloc,
    this.formKey,
  }) : super(key: key);

  VisitorsHistoryListingBloc _getVisitorsHistoryListingBloc(
      BuildContext context) {
    return visitorsHistoryListingBloc ?? VisitorsHistoryListingBloc();
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
