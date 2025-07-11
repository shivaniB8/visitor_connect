import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/add_foreigner_visitor_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/check_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/ui/model/add_indian_visitor.dart';
import 'package:provider/provider.dart';

class AddForeignerVisitorProviders extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final CheckMobileNumberBloc? checkMobileNumberBloc;
  final AddForeignerVisitor? addForeignerVisitor;
  final TitlesBloc? titlesBloc;
  final AddForeignerVisitorBloc? addForeignerVisitorBloc;

  const AddForeignerVisitorProviders({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.checkMobileNumberBloc,
    this.addForeignerVisitor,
    this.titlesBloc,
    this.addForeignerVisitorBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  CheckMobileNumberBloc _getCheckMobileNumberBloc(BuildContext context) {
    return checkMobileNumberBloc ?? CheckMobileNumberBloc();
  }

  TitlesBloc _getTitleBloc(BuildContext context) {
    return titlesBloc ?? TitlesBloc();
  }

  AddForeignerVisitor _getAddForeignerVisitor(BuildContext context) {
    return addForeignerVisitor ?? AddForeignerVisitor();
  }

  AddForeignerVisitorBloc _getAddForeignerVisitorBloc(BuildContext context) {
    return addForeignerVisitorBloc ?? AddForeignerVisitorBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getCheckMobileNumberBloc),
        BlocProvider(create: _getTitleBloc),
        BlocProvider(create: _getAddForeignerVisitorBloc),
        ChangeNotifierProvider(create: _getAddForeignerVisitor),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
