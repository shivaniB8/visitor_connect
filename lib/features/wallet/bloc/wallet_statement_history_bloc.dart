import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/extensions/future_extensions.dart';
import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/wallet_statement_listing_response.dart';
import 'package:host_visitor_connect/features/wallet/data/repos/wallet_repository.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet_filters_model.dart';

class WalletStatementHistoryBloc extends Cubit<UiState<List<Wallet>>> {
  PageResponse<WalletStatementListingResponse>? _currentPageResponse;
  final WalletRepository _walletRepository;
  List<Wallet> wallet = [];
  late Completer refreshCompleter;
  WalletFiltersModel? filter;

  WalletStatementHistoryBloc({
    WalletRepository? walletRepository,
  })  : _walletRepository = walletRepository ?? WalletRepository(),
        super(Default());

  Future walletStatementHistoryListing({
    int pageNo = 0,
    bool isRefreshingList = false,
    required String? date,
    required int? transactionType,
    required int? hostId,
    required bool? fromWallet,
    WalletFiltersModel? walletFiltersModel,
  }) {
    filter = walletFiltersModel;
    emit(Progress());
    if (pageNo == 0 || isRefreshingList) {
      wallet.clear();
    }
    if (isRefreshingList) {
      refreshCompleter = Completer();
    }
    return _walletRepository
        .walletStatementHistoryListing(
          fromWallet: fromWallet ?? false,
          transactionType: transactionType ?? 0,
          hostId: hostId ?? 0,
          date: date ?? "",
          pageNo: pageNo,
          walletFiltersModel: walletFiltersModel,
        )
        .then(_onSuccess)
        .handleError(_onError)
        .whenComplete(() {
      if (isRefreshingList) {
        refreshCompleter.complete();
      }
    });
  }

  void _onSuccess(PageResponse<WalletStatementListingResponse>? pageResponse) {
    pageResponse?.content?.forEach((walletStatementListingResponse) {
      wallet.add(Wallet.fromApiResponse(walletStatementListingResponse));
    });
    print('wallet $wallet');
    _currentPageResponse = pageResponse;
    emit(Success(wallet));
  }

  void _onError(exception) {
    emit(Error(exception as Exception));
  }

  void getNextPageOfWalletStatementHistory({
    required String date,
    required int transactionType,
    required int hostId,
    required bool fromWallet,
  }) {
    if (canLoadMorePages()) {
      walletStatementHistoryListing(
        fromWallet: fromWallet,
        transactionType: transactionType,
        hostId: hostId,
        date: date,
        pageNo: (_currentPageResponse?.pageNo ?? 0) + 1,
        walletFiltersModel: filter,
      );
    }
  }

  bool canLoadMorePages() {
    return state is! Progress && !(_currentPageResponse?.isLast ?? false);
  }

  void refreshWallet({
    bool isRefreshingList = false,
    required String date,
    required int transactionType,
    required int hostId,
    required bool fromWallet,
  }) {
    wallet.clear();
    walletStatementHistoryListing(
      fromWallet: fromWallet,
      date: date,
      transactionType: transactionType,
      hostId: hostId,
      isRefreshingList: isRefreshingList,
    );
  }
}
