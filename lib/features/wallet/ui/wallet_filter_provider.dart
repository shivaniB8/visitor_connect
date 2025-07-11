// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:host_visitor_connect/common/custom_widget/initializer.dart';
// import 'package:provider/provider.dart';
//
// class WalletFilterProvider extends StatelessWidget {
//   final Widget child;
//   final Function(BuildContext)? init;
//   final GlobalKey<FormBuilderState>? formKey;
//   final WalletListingBloc? walletListingBloc;
//   const WalletFilterProvider(
//       {super.key,
//       required this.child,
//       this.init,
//       this.formKey,
//       this.walletListingBloc});
//
//   GlobalKey<FormBuilderState> _getFormKey(BuildContext context) {
//     return formKey ?? GlobalKey<FormBuilderState>();
//   }
//
//   WalletListingBloc _getWalletListingBloc(BuildContext context) {
//     return walletListingBloc ?? WalletListingBloc();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<GlobalKey<FormBuilderState>>(create: _getFormKey),
//         BlocProvider(create: _getWalletListingBloc),
//       ],
//       child: Initializer(
//         init: init,
//         child: child,
//       ),
//     );
//   }
// }
