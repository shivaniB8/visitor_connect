import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/initializer.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/request_otp_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/bloc/visitor_document_bloc.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/otp_generation_response.dart';
import 'package:provider/provider.dart';

class AadharPhotoProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final OtpGenerationResponse? aadharData;
  final VisitorDocumentBloc? visitorDocumentBloc;
  final GlobalKey<FormBuilderState>? formKey;
  final RequestOtpBloc? requestOtpBloc;

  const AadharPhotoProvider({
    Key? key,
    required this.child,
    this.init,
    this.visitorDocumentBloc,
    this.formKey,
    this.aadharData,
    this.requestOtpBloc,
  }) : super(key: key);

  VisitorDocumentBloc _getVisitorDocumentBloc(BuildContext context) {
    return visitorDocumentBloc ?? VisitorDocumentBloc();
  }

  RequestOtpBloc _getRequestOtpBloc(BuildContext context) {
    return requestOtpBloc ?? RequestOtpBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getVisitorDocumentBloc),
        BlocProvider(create: _getRequestOtpBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
