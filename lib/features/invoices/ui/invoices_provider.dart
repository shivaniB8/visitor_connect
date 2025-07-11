import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/invoices/bloc/invoices_bloc.dart';
import 'package:provider/provider.dart';

class InvoicesProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final InvoicesBloc? invoicesBloc;

  const InvoicesProvider({
    Key? key,
    required this.child,
    this.init,
    this.invoicesBloc,
  }) : super(key: key);

  InvoicesBloc _getInvoicesBloc(BuildContext context) {
    return invoicesBloc ?? InvoicesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getInvoicesBloc),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
