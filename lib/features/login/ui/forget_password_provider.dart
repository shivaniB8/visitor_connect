import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/features/login/blocs/forgot_password_bloc.dart';
import 'package:provider/provider.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';

class ForgetPasswordProviders extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final GlobalKey<FormBuilderState>? formKey;
  final ForgotPasswordBloc? forgotPasswordBloc;

  const ForgetPasswordProviders({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
    this.forgotPasswordBloc,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  ForgotPasswordBloc _getForgotPassword(BuildContext context) {
    return forgotPasswordBloc ?? ForgotPasswordBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
        BlocProvider(create: _getForgotPassword),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}





