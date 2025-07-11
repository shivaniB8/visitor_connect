import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';

class ListItemWallet extends StatelessWidget {
  final int index;
  final Wallet? wallet;

  const ListItemWallet({super.key, required this.index, this.wallet});

  @override
  Widget build(BuildContext context) {
    return _historyListTile(context, wallet);
  }

  Widget _historyListTile(BuildContext context, Wallet? wallet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12)),
        child: ListTile(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // tileColor: Colors.grey.withOpacity(.2),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          // tileColor: Colors.green,
          title: Text(
              wallet?.creditDate
                      ?.replaceAll("-", "/")
                      .split("/")
                      .reversed
                      .join("/") ??
                  wallet?.debitDate
                      ?.replaceAll("-", "/")
                      .split("/")
                      .reversed
                      .join("/") ??
                  "N/A",
              style: AppStyle.titleMedium(context).copyWith(
                  fontSize: appSize(context: context, unit: 10) / 18,
                  fontWeight: FontWeight.w600)),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Credit",
                        style: AppStyle.labelLarge(context).copyWith(
                            fontSize: appSize(context: context, unit: 10) / 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                    Text("Debit",
                        style: AppStyle.labelLarge(context).copyWith(
                            fontSize: appSize(context: context, unit: 10) / 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        (wallet?.creditAmount == null ||
                                wallet?.creditAmount == 0)
                            ? "N/A"
                            : "+ ${wallet?.creditAmount}",
                        style: AppStyle.titleLarge(context).copyWith(
                            color: (wallet?.creditAmount == null ||
                                    wallet?.creditAmount == 0)
                                ? Colors.black
                                : Colors.green,
                            fontSize:
                                appSize(context: context, unit: 10) / 14)),
                    Text(
                        (wallet?.debitAmount == null ||
                                wallet?.debitAmount == 0)
                            ? "N/A"
                            : "- ${wallet?.debitAmount}",
                        style: AppStyle.titleLarge(context).copyWith(
                            color: (wallet?.debitAmount == null ||
                                    wallet?.debitAmount == 0)
                                ? Colors.black
                                : Colors.redAccent,
                            fontSize: appSize(context: context, unit: 10) / 14))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
