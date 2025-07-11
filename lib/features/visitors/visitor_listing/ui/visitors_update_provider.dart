import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/visitors_update_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/data/network/responses/update_visitor.dart';
import 'package:provider/provider.dart';

class EditVisitorsProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final UpdateVisitor? updateVisitor;
  final UpdateVisitorsBloc? updateVisitorsBloc;

  const EditVisitorsProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.updateVisitor,
    this.updateVisitorsBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  UpdateVisitor _getVisitorsProfile(BuildContext context) {
    return updateVisitor ?? UpdateVisitor();
  }

  UpdateVisitorsBloc _getUpdateVisitorsBloc(BuildContext context) {
    return updateVisitorsBloc ?? UpdateVisitorsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        Provider(create: _getVisitorsProfile),
        BlocProvider(create: _getUpdateVisitorsBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
