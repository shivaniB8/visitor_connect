import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class RoomNumber extends StatelessWidget {
  final String? roomNo;
  final String? businessType;

  const RoomNumber({super.key, this.roomNo, this.businessType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${businessType ?? "Room No"}: ${roomNo != null && roomNo != '' ? roomNo : "N/A"}",
            style: AppStyle.bodyMedium(context)
                .copyWith(color: foreignerTextLabelColor, fontSize: sizeHeight(context) / 75),
          ),
        ],
      ),
    );
  }
}
