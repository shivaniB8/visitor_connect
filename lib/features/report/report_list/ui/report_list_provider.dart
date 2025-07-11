import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/Filter/bloc/areaFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/cityFilterBloc.dart';

import 'package:host_visitor_connect/features/Filter/bloc/stateFilterBloc.dart';

import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:provider/provider.dart';

class ReportListProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final ReportListBloc? reportListBloc;
  final GlobalKey<FormBuilderState>? formKey;
  final AgeValidationBloc? ageValidationBloc;
  final StateFilterBloc? stateFilterBloc;
  final VisitorsGroupingBloc? visitorsGroupingBloc;
  final CityFilterBloc? cityFilterBloc;
  final AreaFilterBloc? areaFilterBloc;
  final ValidatorOnChanged? validatorOnChanged;

  const ReportListProvider(
      {Key? key,
      required this.child,
      this.init,
      this.reportListBloc,
      this.formKey,
      this.ageValidationBloc,
      this.stateFilterBloc,
      this.visitorsGroupingBloc,
      this.cityFilterBloc,
      this.areaFilterBloc,
      this.validatorOnChanged})
      : super(key: key);

  ReportListBloc _getReportListBloc(BuildContext context) {
    return reportListBloc ?? ReportListBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  AgeValidationBloc _ageValidationBloc(BuildContext context) {
    return ageValidationBloc ?? AgeValidationBloc();
  }

  StateFilterBloc _stateFilterBloc(BuildContext context) {
    return stateFilterBloc ?? StateFilterBloc();
  }

  CityFilterBloc _cityFilterBloc(BuildContext context) {
    return cityFilterBloc ?? CityFilterBloc();
  }

  AreaFilterBloc _areaFilterBloc(BuildContext context) {
    return areaFilterBloc ?? AreaFilterBloc();
  }

  VisitorsGroupingBloc _visitorsGroupingBloc(BuildContext context) {
    return visitorsGroupingBloc ?? VisitorsGroupingBloc();
  }

  ValidatorOnChanged _visitorsValidatorOnChanged(BuildContext context) {
    return validatorOnChanged ?? ValidatorOnChanged();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getReportListBloc),
        BlocProvider(create: _ageValidationBloc),
        BlocProvider(create: _stateFilterBloc),
        BlocProvider(create: _visitorsGroupingBloc),
        BlocProvider(create: _areaFilterBloc),
        BlocProvider(create: _cityFilterBloc),
        BlocProvider(create: _visitorsValidatorOnChanged),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
