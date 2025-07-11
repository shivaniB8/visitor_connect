import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_filters.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_listing_fragment.dart';
import 'package:provider/provider.dart';

class PaymentHistoryWidget extends StatelessWidget {
  const PaymentHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        children: [
          _header(context),
          const Expanded(
            child: WalletListingFragment(),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Account Statement',
            style: AppStyle.headlineSmall(context).copyWith(
              color: background_color,
              fontSize: sizeHeight(context) / 40,
            ),
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     CupertinoIcons.search,
          //     color: primary_color,
          //     size: 20.h,
          //   ),
          // ),
          IconButton(
              onPressed: () {
                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   useSafeArea: true,
                //   enableDrag: true,
                //   backgroundColor: Colors.transparent,
                //   context: context,
                //   builder: (_) {
                //     return MultiProvider(
                //       providers: [
                //         Provider<GlobalKey<FormBuilderState>>(
                //           create: (_) => GlobalKey<FormBuilderState>(),
                //         ),
                //         // BlocProvider.value(
                //         //   value: context.read<WalletListingBloc>(),
                //         // ),
                //       ],
                //       child: const WalletFilters(),
                //     );
                //   },
                // );
              },
              icon: Image.asset("$icons_path/filter_fill.png",
                  width: sizeHeight(context) / 40)
              // Icon(
              //         ,
              //         color: primary_color,
              //         size: sizeHeight(context)/30,
              //       ),
              ),
        ],
      ),
    );
  }

// Widget _historyList(BuildContext context) {
//   return const ;
// }
}
