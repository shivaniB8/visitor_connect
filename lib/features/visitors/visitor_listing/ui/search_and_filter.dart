// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';
// import 'package:host_visitor_connect/common/enum.dart';
// import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
// import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
// import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
// import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/model/filter_model.dart';
// import 'package:host_visitor_connect/features/visitors/visitor_listing/ui/list_filter.dart';
// import 'package:provider/provider.dart';
//
// class SearchAndFilterWidget extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final FiltersModel? filtersModel;
//   final int currentOpenedTab;
//   final String? searchedValue;
//   final SearchFilterState searchFilterState;
//
//   const SearchAndFilterWidget({
//     super.key,
//     this.controller,
//     this.hintText,
//     required this.searchFilterState,
//     this.filtersModel,
//     this.currentOpenedTab = 0,
//     this.searchedValue,
//   });
//
//   @override
//   State<SearchAndFilterWidget> createState() => _SearchAndFilterWidgetState();
// }
//
// class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
//   bool clearSearchText = false;
//   FocusNode? focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//     clearSearchText = false;
//     widget.controller?.text = widget.searchedValue ?? '';
//   }
//
//   void clearSearch() {
//     FocusScope.of(context).unfocus();
//     widget.controller?.clear();
//     setState(() => clearSearchText = false);
//     switch (widget.searchFilterState) {
//       case SearchFilterState.visitorSearch:
//         context.read<VisitorsGroupingBloc>().getVisitorsGrouping(
//             filters: FiltersModel(searchTerm: widget.controller?.text));
//         break;
//       case SearchFilterState.reportSearch:
//         context.read<ReportListBloc>().getReportList(
//             filters: FiltersModel(searchTerm: widget.controller?.text));
//         break;
//       default:
//     }
//   }
//
//   void searchVoter() {
//     FocusScope.of(context).unfocus();
//     clearSearchText = true;
//     switch (widget.searchFilterState) {
//       case SearchFilterState.visitorSearch:
//         context.read<VisitorsGroupingBloc>().getVisitorsGrouping(
//             filters: FiltersModel(searchTerm: widget.controller?.text));
//         break;
//       case SearchFilterState.reportSearch:
//         context.read<ReportListBloc>().getReportList(
//             filters: FiltersModel(searchTerm: widget.controller?.text));
//         break;
//       default:
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: false,
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       onTapOutside: (event) {
//                         FocusScope.of(context).unfocus();
//                       },
//                       controller: widget.controller,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: widget.hintText,
//                         hintStyle: const TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                       onChanged: (value) {
//                         if (value.isEmpty) {
//                           setState(() => clearSearchText = false);
//                         }
//                       },
//                       onSubmitted: (value) {
//                         if (!(widget.controller?.text.isNullOrEmpty() ??
//                             false)) {
//                           searchVoter();
//                         }
//                       },
//                     ),
//                   ),
//                   InkWell(
//                       onTap: () {
//                         if (!(widget.controller?.text.isNullOrEmpty() ??
//                             false)) {
//                           if (clearSearchText) {
//                             clearSearch();
//                           } else {
//                             searchVoter();
//                           }
//                         }
//                       },
//                       child: (clearSearchText)
//                           ? const Icon(Icons.close)
//                           : const Icon(Icons.search)),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           InkWell(
//             onTap: () {
//               showModalBottomSheet(
//                 isScrollControlled: true,
//                 useSafeArea: true,
//                 enableDrag: true,
//                 backgroundColor: Colors.transparent,
//                 context: context,
//                 builder: (_) {
//                   return MultiProvider(
//                     providers: [
//                       Provider<GlobalKey<FormBuilderState>>(
//                           create: (_) => GlobalKey<FormBuilderState>()),
//                       providerFuntion(),
//                       BlocProvider.value(
//                           value: context.read<AgeValidationBloc>()),
//                     ],
//                     child: VisitorsFilter(
//                       searchFilterState: widget.searchFilterState,
//                       currentTab: widget.currentOpenedTab,
//                     ),
//                   );
//                 },
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8.0),
//               child: const Icon(
//                 Icons.filter_alt_outlined,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   providerFuntion() {
//     switch (widget.searchFilterState) {
//       case SearchFilterState.visitorSearch:
//         return BlocProvider.value(value: context.read<VisitorsGroupingBloc>());
//       case SearchFilterState.reportSearch:
//         return BlocProvider.value(value: context.read<ReportListBloc>());
//       default:
//     }
//   }
// }
