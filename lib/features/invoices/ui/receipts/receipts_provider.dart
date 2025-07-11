import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/invoices/bloc/invoices_bloc.dart';
import 'package:host_visitor_connect/features/invoices/bloc/receipts_bloc.dart';
import 'package:provider/provider.dart';

class ReceiptsProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final ReceiptsBloc? invoicesBloc;

  const ReceiptsProvider({
    Key? key,
    required this.child,
    this.init,
    this.invoicesBloc,
  }) : super(key: key);

  ReceiptsBloc _getReceiptsBloc(BuildContext context) {
    return invoicesBloc ?? ReceiptsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getReceiptsBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
