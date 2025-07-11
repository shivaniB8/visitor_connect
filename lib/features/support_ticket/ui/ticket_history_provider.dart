import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
import 'package:host_visitor_connect/features/support_ticket/bloc/ticket_history_bloc.dart';
import 'package:provider/provider.dart';

class TicketHistoryProvider extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? init;
  final TicketHistoryBloc? ticketHistoryBloc;
  final GlobalKey<FormBuilderState>? formKey;

  const TicketHistoryProvider({
    Key? key,
    required this.child,
    this.init,
    this.ticketHistoryBloc,
    this.formKey,
  }) : super(key: key);

  TicketHistoryBloc _getTicketHistoryBloc(BuildContext context) {
    return ticketHistoryBloc ?? TicketHistoryBloc();
  }

  GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
    return formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: _getTicketHistoryBloc),
        Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
      ],
      child: Initializer(
        init: init,
        child: child,
      ),
    );
  }
}
