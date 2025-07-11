import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/features/wallet/bloc/wallet_statement_bloc.dart';
import 'package:host_visitor_connect/features/wallet/ui/model/wallet_filters_model.dart';
import 'package:host_visitor_connect/features/wallet/ui/wallet_listing_fragment.dart';
import 'package:intl/intl.dart';

class AccountStatementScreen extends StatefulWidget {
  const AccountStatementScreen({super.key});

  @override
  State<AccountStatementScreen> createState() => _AccountStatementScreenState();
}

class _AccountStatementScreenState extends State<AccountStatementScreen> {
  int monthNameToNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'january':
        return 1;
      case 'february':
        return 2;
      case 'march':
        return 3;
      case 'april':
        return 4;
      case 'may':
        return 5;
      case 'june':
        return 6;
      case 'july':
        return 7;
      case 'august':
        return 8;
      case 'september':
        return 9;
      case 'october':
        return 10;
      case 'november':
        return 11;
      case 'december':
        return 12;
      default:
        return 1; // Default to January if month name is unrecognized
    }
  }

  // String selectedMonth = 'Select Month';
  // String selectedYear = 'Select Year';
  String selectedMonth = DateFormat('MMMM').format(DateTime.now()).toString();
  String selectedYear = DateTime.now().year.toString();
  String _getMonthName(String monthNumber) {
    try {
      int monthIndex = int.parse(monthNumber);
      if (monthIndex >= 1 && monthIndex <= 12) {
        return DateFormat('MMMM').format(DateTime(2024, monthIndex));
      }
    } catch (e) {
      // Handle error or invalid input
    }
    return ''; // Return an empty string or some default value if conversion fails
  }

  void _onFilterChanged(String newMonth, String newYear) {
    setState(() {
      String monthName = _getMonthName(newMonth);

      selectedMonth = monthName.isNotEmpty
          ? monthName
          : DateFormat('MMMM').format(DateTime.now());
      selectedYear =
          newYear.isNotEmpty ? newYear : DateTime.now().year.toString();
    });
  }

  String _selectedMonth = DateFormat('MMMM').format(DateTime.now()).toString();
  String _selectedYear = DateTime.now().year.toString();

  void _handleFilterChange(String month, String year) {
    setState(() {
      _selectedMonth = month;
      _selectedYear = year;
    });
    // Add any additional logic or state updates needed when month or year changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomImageAppBar(
        title: "Account Statements",
        context: context,
        showSettings: false,
        showEditIcon: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff5B77A7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ensures Row only takes necessary width
                  children: [
                    const SizedBox(width: 12),
                    Flexible(
                      fit: FlexFit
                          .loose, // Allows _filterTab to size itself based on content
                      child: FilterTab(
                        initialMonth: _selectedMonth,
                        initialYear: _selectedYear,
                        onPressed: _handleFilterChange,
                      ),
                      // _filterTab(
                      //     selectedMonth, selectedYear, _onFilterChanged),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Replace Expanded with Flexible
          const Flexible(
            // fit: FlexFit
            //     .loose, // Allows WalletListingFragment to size itself based on content
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: WalletListingFragment(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterTab(
    String monthValue,
    String yearValue,
    void Function(String, String) onPressed,
  ) =>
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff173A7F),
              borderRadius:
                  BorderRadius.circular(5), // Adjust the radius as needed
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: DropdownButton<String>(
                value: monthValue,
                icon: const Icon(Icons.keyboard_arrow_down_sharp,
                    color: Colors.white),
                dropdownColor: const Color(0xff173A7F),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.labelLarge?.fontSize ??
                              16 / 13,
                    ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      monthValue = newValue; // Update the selected month
                    });

                    // Convert month name to numeric value
                    int monthNumber = monthNameToNumber(newValue);

                    // Perform your bloc operation or other logic here
                    context
                        .read<HostAccountStatementBloc>()
                        .getHostAccountStatementBloc(
                          walletFiltersModel: WalletFiltersModel(
                            month: monthNumber.toString(),
                            year: yearValue, // Use current yearValue
                          ),
                        );

                    // Call onPressed with updated month and current yearValue
                    onPressed(monthNumber.toString(), yearValue);
                  }
                },
                items: <String>[
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff173A7F),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: DropdownButton<String>(
                value: yearValue,
                icon: const Icon(Icons.keyboard_arrow_down_sharp,
                    color: Colors.white),
                dropdownColor: const Color(0xff173A7F),
                style: AppStyle.labelLarge(context).copyWith(
                  color: Colors.white,
                  fontSize: appSize(context: context, unit: 10) / 13,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      yearValue = newValue; // Update the selected year
                    });
                    int monthNumber = monthNameToNumber(
                        monthValue); // Keep the selected month
                    context
                        .read<HostAccountStatementBloc>()
                        .getHostAccountStatementBloc(
                          walletFiltersModel: WalletFiltersModel(
                            year: newValue,
                            month: monthNumber.toString(),
                          ),
                        );
                    onPressed(monthValue,
                        newValue); // Pass the current monthValue and newValue
                  }
                },
                items: _buildYearDropdownItems(),
              ),
            ),
          ),
        ],
      );

  List<DropdownMenuItem<String>> _buildYearDropdownItems() {
    int currentYear = DateTime.now().year;
    List<String> years = List.generate(
        currentYear - 1970 + 1, (index) => (1970 + index).toString());
    return years.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}

class FilterTab extends StatefulWidget {
  final String initialMonth;
  final String initialYear;
  final void Function(String, String) onPressed;

  FilterTab({
    required this.initialMonth,
    required this.initialYear,
    required this.onPressed,
  });

  @override
  _FilterTabState createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  late String monthValue;
  late String yearValue;

  @override
  void initState() {
    super.initState();
    monthValue = widget.initialMonth;
    yearValue = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff173A7F),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: DropdownButton<String>(
              value: monthValue,
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: Colors.white),
              dropdownColor: const Color(0xff173A7F),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize:
                        Theme.of(context).textTheme.labelLarge?.fontSize ??
                            16 / 13,
                  ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    monthValue = newValue;
                  });
                  int monthNumber = monthNameToNumber(newValue);
                  context
                      .read<HostAccountStatementBloc>()
                      .getHostAccountStatementBloc(
                        walletFiltersModel: WalletFiltersModel(
                          month: monthNumber.toString(),
                          year: yearValue,
                        ),
                      );
                  widget.onPressed(monthNumber.toString(), yearValue);
                }
              },
              items: <String>[
                'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff173A7F),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: DropdownButton<String>(
              value: yearValue,
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: Colors.white),
              dropdownColor: const Color(0xff173A7F),
              style: AppStyle.labelLarge(context).copyWith(
                color: Colors.white,
                fontSize: appSize(context: context, unit: 10) / 13,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    yearValue = newValue;
                  });
                  int monthNumber = monthNameToNumber(monthValue);
                  context
                      .read<HostAccountStatementBloc>()
                      .getHostAccountStatementBloc(
                        walletFiltersModel: WalletFiltersModel(
                          year: newValue,
                          month: monthNumber.toString(),
                        ),
                      );
                  widget.onPressed(monthValue, newValue);
                }
              },
              items: _buildYearDropdownItems(),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildYearDropdownItems() {
    int currentYear = DateTime.now().year;
    List<String> years = List.generate(
        currentYear - 1970 + 1, (index) => (1970 + index).toString());
    return years.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  int monthNameToNumber(String monthName) {
    // Convert month name to its corresponding number (1-based index)
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months.indexOf(monthName) + 1;
  }
}
