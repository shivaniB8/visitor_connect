import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/qr/bloc/qr_scanner_bloc.dart';
import 'package:provider/provider.dart';

class QrScannerProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final QrScannerBloc? qrScannerBloc;

  const QrScannerProvider({
    Key? key,
    required this.child,
    this.init,
    this.qrScannerBloc,
  }) : super(key: key);

  QrScannerBloc _getQrScannerBloc(BuildContext context) {
    return qrScannerBloc ?? QrScannerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getQrScannerBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
