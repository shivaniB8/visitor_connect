import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/country_list_bloc.dart';
import 'package:provider/provider.dart';

class UsersProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  // final UsersListingBloc? usersListingBloc;
  final GlobalKey<FormBuilderState>? formKey;
  final CountryListBloc? countryListBloc;
  final AgeValidationBloc? ageValidationBloc;

  const UsersProvider({
    Key? key,
    required this.child,
    this.init,
    // this.usersListingBloc,
    this.formKey,
    this.countryListBloc,
    this.ageValidationBloc,
  }) : super(key: key);

  // UsersListingBloc _getUsersBlocBloc(BuildContext context) {
  //   return usersListingBloc ?? UsersListingBloc();
  // }

  CountryListBloc _getCountryBloc(BuildContext context) {
    return countryListBloc ?? CountryListBloc();
  }

  AgeValidationBloc _ageValidationBloc(BuildContext context) {
    return ageValidationBloc ?? AgeValidationBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // BlocProvider(create: _getUsersBlocBloc),
        BlocProvider(create: _getCountryBloc),
        BlocProvider(create: _ageValidationBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
