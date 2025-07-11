import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:provider/provider.dart';

class AadharPhotoProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;

  final GlobalKey<FormBuilderState>? formKey;

  const AadharPhotoProvider({
    Key? key,
    required this.child,
    this.init,
    this.formKey,
  }) : super(key: key);

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
