import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/bar_graph_resp.dart';
import 'package:host_visitor_connect/features/wallet/data/repos/wallet_repository.dart';

class BarGraphBloc extends Cubit<UiState<BarGraphResp>> {
  final WalletRepository _walletRepository;

  BarGraphBloc({
    WalletRepository? walletRepository,
  })  : _walletRepository = walletRepository ?? WalletRepository(),
        super(Default());

  Future getBarGraphData() {
    emit(Progress());
    return _walletRepository
        .barGraphRepo()
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(BarGraphResp otpGenerationResponse) async {
    emit(Success(otpGenerationResponse));
  }

  clearState() {
    emit(Default());
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }
}
