import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/rentals/bloc/driving_licence_bloc.dart';
import 'package:provider/provider.dart';

class DrivingLicenseProviders extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final DrivingLicenseBloc? drivingLicenseBloc;

  const DrivingLicenseProviders({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.drivingLicenseBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  DrivingLicenseBloc _getDrivingLicenseBloc(BuildContext context) {
    return drivingLicenseBloc ?? DrivingLicenseBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getDrivingLicenseBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
