import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/authentication_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/login/blocs/logout_bloc.dart';
import 'package:provider/provider.dart';

class LogoutProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final LogoutBloc? logoutBloc;
  final AuthenticationBloc? authenticationBloc;

  const LogoutProvider({
    Key? key,
    required this.child,
    this.init,
    this.logoutBloc,
    this.authenticationBloc,
  }) : super(key: key);

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
        BlocProvider(create: _getAuthenticationBloc),
        BlocProvider(create: _getLogoutBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
