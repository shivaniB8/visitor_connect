import 'package:host_visitor_connect/common/data/network/responses/page_response.dart';
import 'package:host_visitor_connect/features/wallet/data/network/api_services/wallet_api_service.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/bar_graph_resp.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/wallet_statement_listing_response.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet_filters_model.dart';

class WalletRepository {
  final WalletApiService _walletApiService;

  WalletRepository({WalletApiService? walletApiService})
      : _walletApiService = walletApiService ?? WalletApiService();

  Future<PageResponse<WalletStatementListingResponse>>
      hostAccountStatementRepo({
    required int pageNo,
    WalletFiltersModel? walletFiltersModel,
  }) {
    return _walletApiService.hostAccountStatement(
      pageNo: pageNo,
      walletFiltersModel: walletFiltersModel,
    );
  }

  Future<PageResponse<WalletStatementListingResponse>>
      walletStatementHistoryListing({
    required int pageNo,
    WalletFiltersModel? walletFiltersModel,
    required final int transactionType,
    required final int hostId,
    required final String date,
    required final bool fromWallet,
  }) {
    return _walletApiService.walletStatementHistoryListing(
      fromWallet: fromWallet,
      transactionType: transactionType,
      date: date,
      hostId: hostId,
      pageNo: pageNo,
      walletFiltersModel: walletFiltersModel,
    );
  }

  Future<BarGraphResp> barGraphRepo() {
    return _walletApiService.barGraphApi();
  }
}
