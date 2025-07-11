import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/login/blocs/login_with_password_bloc.dart';
import 'package:provider/provider.dart';
import 'model/user_branch.dart';

class LoginBranchProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final LoginWithPasswordBloc? loginWithPassword;
  final UserBranch? userBranch;

  const LoginBranchProvider({
    Key? key,
    required this.child,
    this.init,
    this.loginWithPassword,
    this.formKey,
    this.userBranch,
  }) : super(key: key);

  UserBranch _getUserBranch(BuildContext context) {
    return userBranch ?? UserBranch();
  }

  LoginWithPasswordBloc _getLoginBloc(BuildContext context) {
    return loginWithPassword ?? LoginWithPasswordBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getLoginBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        ChangeNotifierProvider(
          create: _getUserBranch,
        ),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
