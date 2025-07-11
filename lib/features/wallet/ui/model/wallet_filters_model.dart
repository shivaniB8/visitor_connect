class WalletFiltersModel {
  final int? transactionType;
  final String? fromDate;
  final String? toDate;
  final String? month;
  final String? year;

  WalletFiltersModel(
      {this.transactionType,
      this.toDate,
      this.fromDate,
      this.month,
      this.year});
}
