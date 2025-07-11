import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class FilterSortWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? onTapSort;

  const FilterSortWidget({super.key, this.onTap, this.onTapSort});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: drawer_color1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
                onTap: onTap,
                child: Image.asset(
                  "$icons_path/filter.png",
                  height: sizeHeight(context) / 40,
                  width: sizeHeight(context) / 40,
                  fit: BoxFit.contain,
                )),
          ),
          TextButton(
            onPressed: onTapSort,
            child: Row(
              children: [
                // Icon(CupertinoIcons.sort),
                Image.asset(
                  '$icons_path/switch-vertical.png',
                  height: sizeHeight(context) / 35,
                  width: sizeHeight(context) / 35,
                ),
                const SizedBox(width: 5),
                Text(
                  "Sort List",
                  style: AppStyle.titleSmall(context).copyWith(
                      fontSize: sizeHeight(context) / 50,
                      fontWeight: FontWeight.w500,
                      color: buttonColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
