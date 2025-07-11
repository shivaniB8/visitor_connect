import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/Filter/bloc/areaFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/cityFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/stateFilterBloc.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/country_list_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/outgoing_call_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/visitors_listing_bloc.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/check_out_model.dart';
import 'package:provider/provider.dart';

class VisitorsListingProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final VisitorsListingBloc? visitorsListingBloc;
  final GlobalKey<FormBuilderState>? formKey;
  final CountryListBloc? countryListBloc;
  final AgeValidationBloc? ageValidationBloc;
  final UsersListingBloc? usersListingBloc;
  final OutgoingCallBloc? outgoingCallBloc;
  final VisitorsGroupingBloc? visitorsGroupingBloc;
  final StateFilterBloc? stateFilterBloc;
  final CityFilterBloc? cityFilterBloc;
  final AreaFilterBloc? areaFilterBloc;
  final ValidatorOnChanged? validatorOnChanged;
  final RentedListingBloc? rentedListingBloc;
  final CheckOutVisitor? checkOutVisitor;

  const VisitorsListingProvider(
      {Key? key,
      required this.child,
      this.init,
      this.visitorsListingBloc,
      this.formKey,
      this.countryListBloc,
      this.ageValidationBloc,
      this.usersListingBloc,
      this.outgoingCallBloc,
      this.visitorsGroupingBloc,
      this.stateFilterBloc,
      this.cityFilterBloc,
      this.areaFilterBloc,
      this.validatorOnChanged,
      this.rentedListingBloc,
      this.checkOutVisitor})
      : super(key: key);

  VisitorsListingBloc _getVisitorsListingBlocBloc(BuildContext context) {
    return visitorsListingBloc ?? VisitorsListingBloc();
  }

  CityFilterBloc _getCityFilterBloc(BuildContext context) {
    return cityFilterBloc ?? CityFilterBloc();
  }

  VisitorsGroupingBloc _getVisitorGroupingBloc(BuildContext context) {
    return visitorsGroupingBloc ?? VisitorsGroupingBloc();
  }

  UsersListingBloc _getUsersListingBlocBloc(BuildContext context) {
    return usersListingBloc ?? UsersListingBloc();
  }

  AreaFilterBloc _getAreaFilterBloc(BuildContext context) {
    return areaFilterBloc ?? AreaFilterBloc();
  }

  CountryListBloc _getCountryBloc(BuildContext context) {
    return countryListBloc ?? CountryListBloc();
  }

  AgeValidationBloc _ageValidationBloc(BuildContext context) {
    return ageValidationBloc ?? AgeValidationBloc();
  }

  StateFilterBloc _ageStateFilterBloc(BuildContext context) {
    return stateFilterBloc ?? StateFilterBloc();
  }

  ValidatorOnChanged _validatorOnChanged(BuildContext context) {
    return validatorOnChanged ?? ValidatorOnChanged();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  RentedListingBloc _rentedListingBloc(BuildContext context) {
    return rentedListingBloc ?? RentedListingBloc();
  }

  CheckOutVisitor _checkOutVisitor(BuildContext context) {
    return checkOutVisitor ?? CheckOutVisitor();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getVisitorsListingBlocBloc),
        BlocProvider(create: _getCountryBloc),
        BlocProvider(create: _getUsersListingBlocBloc),
        BlocProvider(create: _getCityFilterBloc),
        BlocProvider(create: _getVisitorGroupingBloc),
        BlocProvider(create: _ageValidationBloc),
        BlocProvider(create: _ageStateFilterBloc),
        BlocProvider(create: _getAreaFilterBloc),
        BlocProvider(create: _validatorOnChanged),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _rentedListingBloc),
        ChangeNotifierProvider(create: _checkOutVisitor),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
