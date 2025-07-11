import 'package:flutter/material.dart';

import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/Filter/ui/widgets/app_search_text_field.dart';

void showBottomSheetSearch({
  required BuildContext context,
  String? hintText,
  TextEditingController? searchController,
  required ValueNotifier<List<KeyValueResponse>> itemsNotifier,
  TextEditingController? controller,
  bool displaySearchField = false,
  required Function(KeyValueResponse? v) onSelect,
}) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${"select"} $hintText'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancel',
                          style: AppStyle.titleMedium(context),
                        ),
                      ),
                    ],
                  ),
                ),
                // Search TextField
                displaySearchField
                    ? AppSearchTextField(
                        hintText: "${'Search'} $hintText",
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                      )
                    : const SizedBox(height: 16.0),
                // Options List
                Expanded(
                  child: ValueListenableBuilder<List<KeyValueResponse>>(
                    valueListenable: itemsNotifier,
                    builder: (context, items, _) {
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data Found",
                            style: AppStyle.titleLarge(context).copyWith(
                                color: text_color, fontWeight: FontWeight.w500),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index].label;
                          final searchQuery = searchController?.text ?? "";
                          final isMatchSearch = searchQuery.isEmpty ||
                              item!
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase());
                          if (!isMatchSearch) return const SizedBox.shrink();
                          return ListTile(
                            onTap: () {
                              onSelect.call(items[index]);
                              searchController?.clear();
                            },
                            title: Text(
                              item ?? '',
                              style: AppStyle.titleMedium(context),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
