import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/authentication_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/reset_password_bloc.dart';
import 'package:host_visitor_connect/features/login/blocs/logout_bloc.dart';
import 'package:host_visitor_connect/features/profile/bloc/delete_account_bloc.dart';
import 'package:host_visitor_connect/features/profile/bloc/titles_bloc.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final ResetPasswordBloc? resetPasswordBloc;
  final TitlesBloc? titlesBloc;
  final LogoutBloc? logoutBloc;
  final AuthenticationBloc? authenticationBloc;
  final DeleteAccountBloc ? deleteAccountBloc;

  const ProfileProvider({
    Key? key,
    required this.child,
    this.init,
    this.resetPasswordBloc,
    this.formKey,
    this.titlesBloc,
    this.logoutBloc,
    this.authenticationBloc,
    this.deleteAccountBloc,
  }) : super(key: key);

  ResetPasswordBloc _getResetPasswordBloc(BuildContext context) {
    return resetPasswordBloc ?? ResetPasswordBloc();
  }

  DeleteAccountBloc _getDeleteAccountBloc(BuildContext context) {
    return deleteAccountBloc ?? DeleteAccountBloc();
  }

  TitlesBloc _getTitlesBloc(BuildContext context) {
    return titlesBloc ?? TitlesBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  LogoutBloc _getLogoutBloc(BuildContext context) {
    return logoutBloc ?? LogoutBloc();
  }

  AuthenticationBloc _getAuthenticationBloc(BuildContext context) {
    return authenticationBloc ?? AuthenticationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getResetPasswordBloc),
        BlocProvider(create: _getTitlesBloc),
        BlocProvider(create: _getAuthenticationBloc),
        BlocProvider(create: _getLogoutBloc),
        BlocProvider(create: _getDeleteAccountBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
