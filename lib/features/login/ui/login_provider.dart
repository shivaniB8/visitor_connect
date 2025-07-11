import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/login/blocs/login_with_password_bloc.dart';
import 'package:host_visitor_connect/features/login/blocs/user_login_mobile_number_bloc.dart';
import 'package:host_visitor_connect/features/login/ui/model/user_branch.dart';
import 'package:provider/provider.dart';

class LoginProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final UserBranch? userBranch;
  final UserLoginMobileNumberBloc? loginPhoneBloc;
  final LoginWithPasswordBloc? loginWithPasswordBloc;
  const LoginProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.loginPhoneBloc,
    this.loginWithPasswordBloc,
    this.userBranch,
  }) : super(key: key);

  UserLoginMobileNumberBloc _getLoginPhoneBloc(BuildContext context) {
    return loginPhoneBloc ?? UserLoginMobileNumberBloc();
  }

  LoginWithPasswordBloc _getLoginWithPasswordBloc(BuildContext context) {
    return loginWithPasswordBloc ?? LoginWithPasswordBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  UserBranch _getUserBranch(BuildContext context) {
    return userBranch ?? UserBranch();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getLoginPhoneBloc),
        BlocProvider(create: _getLoginWithPasswordBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        ChangeNotifierProvider(create: _getUserBranch),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
