import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/filter_header.dart';
import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/Filter/data/network/responses/filter_model.dart';
import 'package:host_visitor_connect/features/users/users_listing/bloc/users_listing_bloc.dart';

class UserFilter extends StatefulWidget {
  const UserFilter({
    super.key,
  });

  @override
  State<UserFilter> createState() => _UserFilterState();
}

class _UserFilterState extends State<UserFilter> {
  final List<KeyValueResponse> filters = [
    KeyValueResponse(value: 1, label: "Active"),
    KeyValueResponse(value: 2, label: "Temporary Suspended"),
    KeyValueResponse(value: 3, label: "Permanently Suspended"),
  ];

  int? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 0,
      ),
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeader(
              title: 'User Filter',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const FormFieldLabel(
                  label: 'User Status',
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: filters.map((filter) {
                    return FilterChip(
                        label: Text(filter.label ?? '',
                            style: AppStyle.bodyLarge(context).copyWith(
                                color: filterTextColor,
                                fontWeight: FontWeight.w400)),
                        selected: selectedStatus == filter.value,
                        backgroundColor: filterInactiveColor,
                        checkmarkColor: filterTextColor,
                        side: const BorderSide(
                            width: 0, color: filterInactiveColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedStatus = filter.value;
                            } else {
                              selectedStatus = null;
                            }
                          });
                        });
                  }).toList(),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Button(
                      borderColor: profileTextColor,
                      isRectangularBorder: true,
                      buttonType: ButtonType.stroked,
                      onPressed: () {
                        context.read<UsersListingBloc>().getUsersListing();
                        Navigator.pop(context);
                      },
                      child: Text('Clear All',
                          style: AppStyle.buttonStyle(context)
                              .copyWith(color: profileTextColor)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Button(
                      isRectangularBorder: true,
                      buttonType: ButtonType.solid,
                      onPressed: () {
                        context.read<UsersListingBloc>().getUsersListing(
                            filters: FiltersModel(userStatus: selectedStatus));
                        Navigator.pop(context);
                      },
                      child:
                          Text('Apply', style: AppStyle.buttonStyle(context)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
