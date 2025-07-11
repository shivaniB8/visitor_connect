// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:host_visitor_connect/common/custom_widget/button.dart';
// import 'package:host_visitor_connect/common/custom_widget/fields/date_filter_field.dart';
// import 'package:host_visitor_connect/common/custom_widget/widget/filter_header.dart';
// import 'package:host_visitor_connect/common/data/network/responses/key_value_response.dart';
// import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
// import 'package:host_visitor_connect/common/res/colors.dart';
// import 'package:host_visitor_connect/common/res/styles.dart';
// import 'package:host_visitor_connect/common/utils/utils.dart' as height;
// import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
//
// import 'model/wallet_filters_model.dart';
//
// class WalletFilters extends StatefulWidget {
//   const WalletFilters({
//     super.key,
//   });
//
//   @override
//   State<WalletFilters> createState() => _DeathReportFiltersState();
// }
//
// class _DeathReportFiltersState extends State<WalletFilters> {
//   final List<KeyValueResponse> transactionTypes = [
//     KeyValueResponse(value: 1, label: 'Debit'),
//     KeyValueResponse(value: 2, label: 'Credit')
//   ];
//   List<KeyValueResponse> searchBranchList = [];
//   KeyValueResponse? selectedTransactionType;
//   String? startDeathDate;
//   String? endDeathDate;
//
//   void clearFilters() {
//     context.read<WalletListingBloc>().getHostAccountStatementBloc();
//     Navigator.pop(context);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.5,
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: 15.0, vertical: height.sizeHeight(context) / 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const FilterHeader(title: "Filter Payment"),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: height.sizeHeight(context) / 30,
//                     ),
//                     Text(
//                       "Transaction Type",
//                       style: AppStyle.titleSmall(context)
//                           .copyWith(color: filterTextColor)
//                           .copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: height.sizeHeight(context) / 200,
//                     ),
//                     Wrap(
//                       spacing: 8.0,
//                       runSpacing: 4.0,
//                       children: transactionTypes.map((filter) {
//                         return FilterChip(
//                             label: Text(filter.label ?? '',
//                                 style: AppStyle.bodyLarge(context).copyWith(
//                                     color: filterTextColor,
//                                     fontWeight: FontWeight.w400)),
//                             selected: selectedTransactionType == filter,
//                             backgroundColor: filterInactiveColor,
//                             checkmarkColor: filterTextColor,
//                             side: const BorderSide(
//                                 width: 0, color: filterInactiveColor),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             onSelected: (isSelected) {
//                               setState(() {
//                                 if (isSelected) {
//                                   selectedTransactionType = filter;
//                                 } else {
//                                   selectedTransactionType = null;
//                                 }
//                               });
//                             });
//                       }).toList(),
//                     ),
//                     SizedBox(
//                       height: height.sizeHeight(context) / 50,
//                     ),
//                     Text(
//                       "Date Range Transaction",
//                       style: AppStyle.titleSmall(context)
//                           .copyWith(color: filterTextColor)
//                           .copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: height.sizeHeight(context) / 70,
//                     ),
//                     dateFilterWidget(),
//                     SizedBox(
//                       height: height.sizeHeight(context) / 200,
//                     ),
//                     if (((endDeathDate?.isNotEmpty ?? false) ||
//                             endDeathDate != null) &&
//                         ((dateTimeFromString(startDeathDate ?? '')
//                                 ?.isAfter(dateTimeFromString(endDeathDate)!)) ??
//                             false))
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Text(
//                           'Start Date should be greater than End Date',
//                           style: AppStyle.errorStyle(context),
//                         ),
//                       ),
//                     SizedBox(
//                       height: height.sizeHeight(context) / 50,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             bottomButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget dateFilterWidget() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _DateTimeField(
//                 key: const Key('startDate'),
//                 fieldName: 'startDate',
//                 hintText: 'Start Date',
//                 onChanged: (startDate) {
//                   if (startDate != null) {
//                     startDeathDate = startDate.toString();
//                   }
//                   setState(() {});
//                 },
//               ),
//               if ((startDeathDate == null ||
//                       (startDeathDate?.isEmpty ?? false)) &&
//                   (endDeathDate?.isNotEmpty ?? false))
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 10),
//                   child: Text(
//                     'Please select Start Date',
//                     style: AppStyle.errorStyle(context),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _DateTimeField(
//                 key: const Key('endDate'),
//                 fieldName: 'endDate',
//                 hintText: 'End Date',
//                 onChanged: (endDate) {
//                   if (endDate != null) {
//                     endDeathDate = endDate.toString();
//                     setState(() {});
//                   }
//                 },
//               ),
//               if ((startDeathDate?.isNotEmpty ?? false) &&
//                       endDeathDate == null ||
//                   (endDeathDate?.isEmpty ?? false))
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 10),
//                   child: Text(
//                     'Please select End Date',
//                     style: AppStyle.errorStyle(context),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bottomButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: Button(
//             borderColor: profileTextColor,
//             isRectangularBorder: true,
//             buttonType: ButtonType.stroked,
//             onPressed: () {
//               clearFilters();
//             },
//             child: Text('Clear All',
//                 style: AppStyle.buttonStyle(context)
//                     .copyWith(color: profileTextColor)),
//           ),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Button(
//             isRectangularBorder: true,
//             buttonType: ButtonType.solid,
//             onPressed: () {
//               if (!((startDeathDate == null ||
//                       (startDeathDate?.isEmpty ?? false)) &&
//                   (endDeathDate?.isNotEmpty ?? false))) {
//                 if (!((startDeathDate?.isNotEmpty ?? false) &&
//                         endDeathDate == null ||
//                     (endDeathDate?.isEmpty ?? false))) {
//                   if (!(((endDeathDate?.isNotEmpty ?? false) ||
//                           endDeathDate != null) &&
//                       ((dateTimeFromString(startDeathDate ?? '')
//                               ?.isAfter(dateTimeFromString(endDeathDate)!)) ??
//                           false))) {
//                     context.read<WalletListingBloc>().getHostAccountStatementBloc(
//                             walletFiltersModel: WalletFiltersModel(
//                           transactionType: selectedTransactionType?.value,
//                           fromDate: (startDeathDate ?? ''),
//                           toDate: (endDeathDate ?? ''),
//                         ));
//
//                     Navigator.pop(context);
//                   }
//                 }
//               }
//             },
//             child: Text('Apply', style: AppStyle.buttonStyle(context)),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _DateTimeField extends StatelessWidget {
//   final String fieldName;
//   final Function(DateTime?)? onChanged;
//   final String? hintText;
//
//   const _DateTimeField({
//     Key? key,
//     required this.fieldName,
//     this.onChanged,
//     this.hintText,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DateTimeFieldFilter(
//       fieldName: fieldName,
//       inputType: InputType.date,
//       onChanged: onChanged,
//       style: AppStyle.bodyMedium(context),
//       lastSelectableDate: DateTime.now(),
//       decoration: form_field_input_decoration.copyWith(
//         fillColor: textFeildFillColor,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderSide:
//               BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintText: hintText,
//         hintStyle: AppStyle.bodyMedium(context)
//             .copyWith(color: filterTextColor, fontWeight: FontWeight.w400),
//         isDense: true,
//         suffixIcon: const Icon(
//           Icons.date_range,
//           size: 20,
//           color: filterTextColor,
//         ),
//       ),
//     );
//   }
// }
