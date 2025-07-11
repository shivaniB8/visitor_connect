import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:host_visitor_connect/common/blank_slate.dart';
import 'package:host_visitor_connect/common/blocs/state_events/ui_state.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/loading.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/wallet/bloc/bar_graph_bloc.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_history_bloc.dart';
import 'package:host_visitor_connect/features/wallet/chart_data/debt_chart_data.dart';
import 'package:host_visitor_connect/features/wallet/data/network/responses/bar_graph_resp.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletScreen extends StatefulWidget {
  final List<Wallet>? wallet;

  const WalletScreen({
    super.key,
    this.wallet,
  });

  static List<DebtChartData> chartData = [
    DebtChartData("M", 25),
    DebtChartData("T", 13),
    DebtChartData("W", 24),
    DebtChartData("T", 15),
    DebtChartData("F", 30),
    DebtChartData("S", 12),
    DebtChartData("S", 18)
  ];

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarGraphBloc>().getBarGraphData();
    context.read<WalletStatementHistoryBloc>().walletStatementHistoryListing(
        fromWallet: true, date: "", transactionType: 1, hostId: null);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: WalletAppBar(context: context),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              _barChart(context),
              _header(context),
              Expanded(
                  child: BlocProvider.value(
                value: context.read<WalletStatementHistoryBloc>(),
                child: BlocConsumer(
                    bloc: context.read<WalletStatementHistoryBloc>(),
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is Progress) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      } else if (state is Success) {
                        return SingleChildScrollView(
                          child: Column(children: [
                            ...context
                                        .read<WalletStatementHistoryBloc>()
                                        .state
                                        .getData()
                                        ?.isNotEmpty ??
                                    false
                                ? List.generate(
                                    context
                                            .read<WalletStatementHistoryBloc>()
                                            .state
                                            .getData()
                                            ?.length ??
                                        0,
                                    (idx) {
                                      return context
                                                  .read<
                                                      WalletStatementHistoryBloc>()
                                                  .state
                                                  .getData()
                                                  ?.isNotEmpty ??
                                              false
                                          ? _expandedListTile(context
                                              .read<
                                                  WalletStatementHistoryBloc>()
                                              .state
                                              .getData()![idx])
                                          : const BlankSlate(
                                              title: 'No Data Found');
                                    },
                                  )
                                : [
                                    const SizedBox(
                                      height: 200,
                                      child: BlankSlate(title: 'No Data Found'),
                                    ),
                                  ],
                          ]),
                        );
                      } else {
                        return Container(
                          height: 50,
                          child: BlankSlate(title: 'No Data Found'),
                        );
                      }
                    }),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _expandedListTile(Wallet wallet) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: card_background_grey_color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTile(
          onTap: () {},
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          leading: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(wallet.debitDate?.split("-").last ?? "N/A",
                  style: AppStyle.titleLarge(context).copyWith(
                      height: 1,
                      color: Colors.black87,
                      fontSize: appSize(context: context, unit: 10) / 14)),
              Text(
                  getMonthInWord(
                      int.tryParse(wallet.debitDate?.split("-")[1] ?? "0") ?? 0,
                      inFullWords: false),
                  style: AppStyle.titleLarge(context).copyWith(
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: appSize(context: context, unit: 10) / 16)),
              Text(wallet.debitDate?.split("-").first ?? "N/A",
                  style: AppStyle.titleLarge(context).copyWith(
                      color: Colors.black87,
                      fontSize: appSize(context: context, unit: 10) / 22)),
            ],
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  wallet.debitAmount != null && wallet.debitAmount != 0
                      ? "₹ ${wallet.debitAmount}"
                      : "N/A",
                  style: AppStyle.titleLarge(context).copyWith(
                      color: Colors.redAccent,
                      fontSize: appSize(context: context, unit: 10) / 12)),
              Text(wallet.debitTime ?? 'N/A',
                  style: AppStyle.titleLarge(context).copyWith(
                      color: Colors.black54,
                      fontSize: appSize(context: context, unit: 10) / 20)),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(capitalizedString(wallet.visitorName?.toString() ?? "N/A"),
                  textAlign: TextAlign.center,
                  style: AppStyle.labelSmall(context).copyWith(
                      fontSize: appSize(context: context, unit: 10) / 18)),
              if (!wallet.roomNo.isNullOrEmpty())
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Room / Vehicle: ",
                          style: AppStyle.labelSmall(context).copyWith(
                              color: text_color.withOpacity(.6),
                              fontSize:
                                  appSize(context: context, unit: 10) / 22)),
                      Text(wallet.roomNo ?? "N/A",
                          style: AppStyle.labelSmall(context).copyWith(
                              color: text_color.withOpacity(.6),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  appSize(context: context, unit: 10) / 20)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );

  Widget _barChart(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff3C3C3C),
            Color(0xff4B4B4B),
          ],
        ),
      ),
      child: BlocConsumer<BarGraphBloc, UiState>(
          bloc: context.read<BarGraphBloc>(),
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Success) {
              Data? data = context.read<BarGraphBloc>().state.getData()?.data;
              return Column(
                children: [
                  Container(
                    // color: Colors.green,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _debtInRs(context,
                            debitAmount: data?.currentMonthDebit),
                        _debtInPercent(context, percent: data?.percentage),
                        _weekWiseDataWidget(context)
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      // color: Colors.yellow,
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 0.1),
                      ),
                    ),
                    height: sizeHeight(context) / 6,
                    child: SfCartesianChart(
                      margin:
                          const EdgeInsets.only(bottom: 6, right: 6, left: 6),
                      plotAreaBorderWidth: 0,
                      borderWidth: 0,
                      primaryXAxis: CategoryAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.none,
                        majorTickLines: const MajorTickLines(width: 0),
                        arrangeByIndex: true,
                        majorGridLines: const MajorGridLines(width: 0),
                        axisLine: const AxisLine(color: Colors.transparent),
                        labelStyle: AppStyle.labelMedium(context)
                            .copyWith(color: Colors.white),
                      ),
                      primaryYAxis: const NumericAxis(
                        axisLine: AxisLine(color: Colors.transparent),
                        isVisible: false,
                        majorGridLines: MajorGridLines(width: 0),
                        // axisLine: AxisLine(width: 0),
                      ),
                      series: <CartesianSeries<DebtChartData, String>>[
                        // Renders column chart
                        ColumnSeries<DebtChartData, String>(
                          width: 0.8,
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xffA3B1CC),
                                Color(0xff7A89DC),
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter),
                          dataSource: [
                            DebtChartData(
                                "M", data?.monday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "T", data?.tuesday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "W", data?.wednesday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "T", data?.thursday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "F", data?.friday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "S", data?.saturday?.f0?.toDouble() ?? 0.0),
                            DebtChartData(
                                "S", data?.sunday?.f0?.toDouble() ?? 0.0)
                          ],
                          xValueMapper: (DebtChartData data, _) => data.x,
                          yValueMapper: (DebtChartData data, _) => data.y,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.auto,
                              textStyle: AppStyle.labelSmall(context).copyWith(
                                  color: Colors.white24,
                                  fontSize:
                                      appSize(context: context, unit: 10) / 20)
                              // labelPosition: ChartDataLabelPosition.
                              // alignment: ChartAlignment.near
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }

            return Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.blueGrey,
              child: Column(
                children: [
                  Container(
                    // color: Colors.green,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _debtInRs(context, debitAmount: 0),
                        _debtInPercent(context, percent: 0),
                        _weekWiseDataWidget(context)
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      // color: Colors.yellow,
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 0.1),
                      ),
                    ),
                    height: sizeHeight(context) / 6,
                    child: SfCartesianChart(
                      margin:
                          const EdgeInsets.only(bottom: 6, right: 6, left: 6),
                      plotAreaBorderWidth: 0,
                      borderWidth: 0,
                      primaryXAxis: CategoryAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.none,
                        majorTickLines: const MajorTickLines(width: 0),
                        arrangeByIndex: true,
                        majorGridLines: const MajorGridLines(width: 0),
                        axisLine: const AxisLine(color: Colors.transparent),
                        labelStyle: AppStyle.labelMedium(context)
                            .copyWith(color: Colors.white),
                      ),
                      primaryYAxis: const NumericAxis(
                        axisLine: AxisLine(color: Colors.transparent),
                        isVisible: false,
                        majorGridLines: MajorGridLines(width: 0),
                        // axisLine: AxisLine(width: 0),
                      ),
                      series: <CartesianSeries<DebtChartData, String>>[
                        // Renders column chart
                        ColumnSeries<DebtChartData, String>(
                            width: 0.8,
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xffA3B1CC),
                                  Color(0xff7A89DC),
                                ],
                                begin: Alignment.center,
                                end: Alignment.bottomCenter),
                            dataSource: WalletScreen.chartData,
                            xValueMapper: (DebtChartData data, _) => data.x,
                            yValueMapper: (DebtChartData data, _) => data.y)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _debtInRs(BuildContext context, {int? debitAmount}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            debitAmount == null
                ? "₹ 0"
                : "₹ ${debitAmount.getReadableCurrencyValue()}",
            style: AppStyle.titleLarge(context).copyWith(
                height: 1.h,
                color: Colors.white,
                fontSize: sizeHeight(context) / 40)),
        SizedBox(height: sizeHeight(context) / 80),
        Text("Monthly Debit",
            style: AppStyle.titleSmall(context).copyWith(
                color: Colors.white, fontSize: sizeHeight(context) / 95)),
      ],
    );
  }

  _debtInPercent(BuildContext context, {int? percent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(percent == null ? "0%" : "$percent%",
            style: AppStyle.titleLarge(context).copyWith(
                height: 1.h,
                color: Colors.white,
                fontSize: sizeHeight(context) / 40)),
        SizedBox(height: sizeHeight(context) / 80),
        Text("Debit more than \nlast month",
            style: AppStyle.titleSmall(context).copyWith(
                color: Colors.white, fontSize: sizeHeight(context) / 95)),
      ],
    );
  }

  _weekWiseDataWidget(BuildContext context) {
    return Button(
      btnHeight: sizeHeight(context) / 24,
      padding: EdgeInsets.symmetric(horizontal: sizeHeight(context) / 28),
      isRectangularBorder: true,
      backgroundColor: Colors.white,
      onPressed: () {},
      textColor: background_dark_grey,
      child: Text(
        "This week",
        style: AppStyle.labelLarge(context)
            .copyWith(color: primary_color, fontSize: sizeHeight(context) / 80),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Account Statement (Debits)',
            style: AppStyle.headlineSmall(context).copyWith(
              color: background_color,
              fontSize: sizeHeight(context) / 40,
            ),
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     CupertinoIcons.search,
          //     color: primary_color,
          //     size: 20.h,
          //   ),
          // ),
          // IconButton(
          //     onPressed: () {
          //       // showModalBottomSheet(
          //       //   isScrollControlled: true,
          //       //   useSafeArea: true,
          //       //   enableDrag: true,
          //       //   backgroundColor: Colors.transparent,
          //       //   context: context,
          //       //   builder: (_) {
          //       //     return MultiProvider(
          //       //       providers: [
          //       //         Provider<GlobalKey<FormBuilderState>>(
          //       //           create: (_) => GlobalKey<FormBuilderState>(),
          //       //         ),
          //       //         // BlocProvider.value(
          //       //         //   value: context.read<WalletListingBloc>(),
          //       //         // ),
          //       //       ],
          //       //       child: const WalletFilters(),
          //       //     );
          //       //   },
          //       // );
          //     },
          //     icon: Image.asset("$icons_path/filter_fill.png",
          //         width: sizeHeight(context) / 40)
          //     // Icon(
          //     //         ,
          //     //         color: primary_color,
          //     //         size: sizeHeight(context)/30,
          //     //       ),
          //     ),
        ],
      ),
    );
  }
}
