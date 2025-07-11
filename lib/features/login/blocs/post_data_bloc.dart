import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/login/data/repos/login_repository.dart';

class PostDataBloc extends Cubit<UiState> {
  final LoginRepository _loginRepository;

  PostDataBloc({LoginRepository? loginRepository})
      : _loginRepository = loginRepository ?? LoginRepository(),
        super(Default());

  void postData({
    required Map<String, dynamic> data,
  }) {
    emit(Progress());
    _loginRepository
        .postData(data: data)
        .then(_onSuccess)
        .handleError(_onError);
  }

  void _onSuccess(_) {
    emit(Success(true));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
