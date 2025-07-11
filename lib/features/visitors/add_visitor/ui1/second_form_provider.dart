import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/initializer.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/update_visitors_info_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui1/model/add_indian_visitor.dart';
import 'package:provider/provider.dart';
import '../bloc/reason_visit_bloc.dart';

class SecondFormProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final UpdateVisitorInfo? updateIndianVisitorInfo;
  final UpdateVisitorInfoBloc? updateVisitorInfoBloc;
  final ReasonToVisitBloc? reasonToVisitBloc;

  const SecondFormProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.updateIndianVisitorInfo,
    this.updateVisitorInfoBloc,
    this.reasonToVisitBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  UpdateVisitorInfo _getAddIndianVisitor(BuildContext context) {
    return updateIndianVisitorInfo ?? UpdateVisitorInfo();
  }

  ReasonToVisitBloc _getReasonToVisitBloc(BuildContext context) {
    return reasonToVisitBloc ?? ReasonToVisitBloc();
  }

  UpdateVisitorInfoBloc _getUpdateVisitorInfoBloc(BuildContext context) {
    return updateVisitorInfoBloc ?? UpdateVisitorInfoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getUpdateVisitorInfoBloc),
        BlocProvider(create: _getReasonToVisitBloc),
        ChangeNotifierProvider(create: _getAddIndianVisitor),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
