import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/reset_password_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_document_bloc.dart';
import 'package:provider/provider.dart';

class HomePageProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final ResetPasswordBloc? resetPasswordBloc;
  final UserDocumentBloc? userDocumentBloc;
  // final PostDataBloc? postDataBloc;

  const HomePageProvider({
    Key? key,
    required this.child,
    this.init,
    this.resetPasswordBloc,
    this.userDocumentBloc,
    // this.postDataBloc,
  }) : super(key: key);

  ResetPasswordBloc _getResetPasswordBloc(BuildContext context) {
    return resetPasswordBloc ?? ResetPasswordBloc();
  }

  UserDocumentBloc _getUserDocumentBloc(BuildContext context) {
    return userDocumentBloc ?? UserDocumentBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getResetPasswordBloc),
        BlocProvider(create: _getUserDocumentBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
