import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/network/response/add_foreigner_visitor_response.dart';
import 'package:host_visitor_connect/features/visitors/add_visitor/data/repos/add_visitor_repository.dart';
import 'package:image_picker/image_picker.dart';

class AddForeignerVisitorBloc extends Cubit<UiState<AddForeignerVisitorResponse>> {
  final AddVisitorRepository _addVisitorRepository;

  AddForeignerVisitorBloc({AddVisitorRepository? addVisitorRepository})
      : _addVisitorRepository = addVisitorRepository ?? AddVisitorRepository(),
        super(Default());

  Future addForeignerVisitorManually({
    required Map<String, dynamic> foreignerVisitor,
    required XFile passportFirstPhoto,
    required XFile passportLastPhoto,
    required XFile visaPhoto,
    required XFile profilePhoto,
  }) {
    emit(Progress());
    return _addVisitorRepository
        .addForeignerVisitorManually(
            foreignerVisitor: foreignerVisitor,
            passportFirstPhoto: passportFirstPhoto,
            passportLastPhoto: passportLastPhoto,
            profilePhoto: profilePhoto,
            visaPhoto: visaPhoto)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(AddForeignerVisitorResponse addForeignerVisitorResponse) async {
    emit(Success(addForeignerVisitorResponse));
  }

  void _onError(exception) {
    log("on error visitor maually add ? $exception");
    emit(Error(exception as Exception));
  }
}
