// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
// import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
// import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/indian_visitor_response.dart';
// import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';
//
// class AddIndianVisitorBloc extends Cubit<UiState<IndianVisitorResponse>> {
//   final AddVisitorRepository _addVisitorRepository;
//
//   AddIndianVisitorBloc({AddVisitorRepository? addVisitorRepository})
//       : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
//         super(Default());
//
//   Future addUpdateIndianVisaitorManually({
//     required Map<String, dynamic> indianVisitorData,
//   }) {
//     emit(Progress());
//     return _addVisitorRepository
//         .addUpdateIndianVisitorManually(indianVisitorData: indianVisitorData)
//         .then(_onSuccess)
//         .handleError(_onError);
//   }
//
//   _onSuccess(IndianVisitorResponse indianVisitorResponse) async {
//     emit(Success(indianVisitorResponse));
//   }
//
//   void _onError(exception) {
//     emit(Error(exception as Exception));
//   }
// }
