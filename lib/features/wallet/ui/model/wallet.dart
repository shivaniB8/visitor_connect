import 'package:equatable/equatable.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/wallet_statement_listing_response.dart';

class Wallet extends Equatable {
  final dynamic id;
  final int? clientId;
  final int? transactionType;
  final int? creditThrough;
  final double? creditAmount;
  final int? creditStatus;
  final String? creditDate;
  final String? creditTime;
  final double? debitAmount;
  final String? componentName;
  final int? balanceAmount;
  final String? debitDate;
  final String? debitTime;
  final dynamic debitComponentCount;
  final String? debitComponentCharge;
  final int? debitFor;
  final String? heading;
  final int? visitorId;
  final String? visitorName;
  final String? roomNo;
  final int? hostId;

  const Wallet({
    this.visitorId,
    this.visitorName,
    this.roomNo,
    this.id,
    this.clientId,
    this.hostId,
    this.transactionType,
    this.creditThrough,
    this.creditAmount,
    this.creditStatus,
    this.creditDate,
    this.creditTime,
    this.debitAmount,
    this.componentName,
    this.balanceAmount,
    this.debitDate,
    this.debitTime,
    this.debitComponentCount,
    this.debitComponentCharge,
    this.debitFor,
    this.heading,
  });

  factory Wallet.fromApiResponse(
    WalletStatementListingResponse walletStatementListingResponse,
  ) {
    return Wallet(
        id: walletStatementListingResponse.id,
        clientId: walletStatementListingResponse.clientId,
        transactionType: walletStatementListingResponse.transactionType,
        creditThrough: walletStatementListingResponse.creditThrough,
        creditAmount: walletStatementListingResponse.creditAmount,
        creditStatus: walletStatementListingResponse.creditStatus,
        creditDate: walletStatementListingResponse.creditDate,
        creditTime: walletStatementListingResponse.creditTime,
        debitAmount: walletStatementListingResponse.debitAmount,
        componentName: walletStatementListingResponse.componentName,
        balanceAmount: walletStatementListingResponse.balanceAmount,
        debitDate: walletStatementListingResponse.debitDate,
        debitTime: walletStatementListingResponse.debitTime,
        debitComponentCount: walletStatementListingResponse.debitComponentCount,
        debitComponentCharge:
            walletStatementListingResponse.debitComponentCharge,
        debitFor: walletStatementListingResponse.debitFor,
        heading: walletStatementListingResponse.heading,
        hostId: walletStatementListingResponse.hostId,
        visitorId: walletStatementListingResponse.visitorId,
        visitorName: walletStatementListingResponse.visitorName,
        roomNo: walletStatementListingResponse.roomNo);
  }

  @override
  List<Object?> get props => [
        id,
        clientId,
        transactionType,
        creditThrough,
        creditAmount,
        creditStatus,
        creditDate,
        creditTime,
        debitAmount,
        componentName,
        balanceAmount,
        debitDate,
        debitTime,
        hostId,
        debitComponentCount,
        debitComponentCharge,
        debitFor,
        heading,
        visitorId,
        visitorName,
        roomNo
      ];
}
