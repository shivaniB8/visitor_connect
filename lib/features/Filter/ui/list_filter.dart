import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:host_visitor_connect/common/blocs/validator_bloc.dart';

import 'package:host_visitor_connect/common/custom_widget/button.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/add_form_field.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_error.dart';
import 'package:host_visitor_connect/common/custom_widget/fields/form_field_label.dart';
import 'package:host_visitor_connect/common/custom_widget/widget/filter_header.dart';
import 'package:host_visitor_connect/common/enum.dart';

import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';
import 'package:host_visitor_connect/features/Filter/bloc/areaFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/cityFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/bloc/stateFilterBloc.dart';
import 'package:host_visitor_connect/features/Filter/ui/widgets/select_field.dart';
import 'package:host_visitor_connect/features/rent/rented_listing/bloc/rented_listing_bloc.dart';
import 'package:host_visitor_connect/features/report/report_list/bloc/report_list_bloc.dart';
import 'package:host_visitor_connect/features/visitors/current_visitors/bloc/current_visitors_grouping_bloc.dart';
import 'package:host_visitor_connect/features/visitors/history/bloc/visitors_grouping_bloc.dart';
import 'package:provider/provider.dart';
import '../data/network/responses/filter_model.dart';

class ListFilter extends StatefulWidget {
  final int currentTab;
  final bool? isFromRent;
  final bool? isFromReport;
  final bool? isFromVisitor;
  final bool? isFromCurrentVisitor;

  final SearchFilterState searchFilterState;

  const ListFilter({
    super.key,
    this.isFromRent,
    this.isFromReport,
    this.isFromVisitor,
    this.currentTab = 0,
    this.isFromCurrentVisitor,
    required this.searchFilterState,
  });

  @override
  State<ListFilter> createState() => _ListFilterState();
}

class _ListFilterState extends State<ListFilter> {
  TextEditingController? aadharController;
  TextEditingController? visaNumberController;
  TextEditingController? age1Controller;
  TextEditingController? age2Controller;
  TextEditingController? ageController;

  final double _currentSliderValue = 1;
  final double _currentSliderValue2 = 100;

  List<int>? selectedGenderType = [];
  final focusNodeAge1 = FocusNode();
  final focusNodeAge2 = FocusNode();
  bool hasFocus = false;
  RangeValues _currentRangeValues = RangeValues(0, 0);
  int startValue = 0;
  int endValue = 0;

  @override
  void initState() {
    context.read<StateFilterBloc>().getState();

    super.initState();
    age1Controller = TextEditingController();
    age2Controller = TextEditingController();
    ageController = TextEditingController();
    aadharController = TextEditingController();

    visaNumberController = TextEditingController();

    focusNodeAge2.addListener(() {
      setState(() {
        hasFocus = focusNodeAge2.hasFocus;
      });
    });

    focusNodeAge1.addListener(() {
      setState(() {
        hasFocus = focusNodeAge1.hasFocus;
      });
    });
  }

  void disposeFilters() {
    age1Controller?.dispose();
    age2Controller?.dispose();
    ageController?.dispose();

    aadharController?.dispose();
    visaNumberController?.dispose();
    focusNodeAge2.dispose();
    focusNodeAge1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 0,
      ),
      height: sizeHeight(context) / 1.2,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: FormBuilder(
        key: context.read<GlobalKey<FormBuilderState>>(),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                FilterHeader(
                  title: (() {
                    if (widget.isFromReport ?? false) {
                      return "Report Filter";
                    } else if (widget.isFromVisitor ?? false) {
                      return "Visitor Filter";
                    } else if (widget.isFromCurrentVisitor ?? false) {
                      return "Current Visitor Filter";
                    }
                    // Default title if none of the conditions match
                    return "Default Filter Title";
                  })(),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.height / 15,
                  bottom: MediaQuery.of(context).size.height / 10,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Age section
                        Text(
                          "Age",
                          style: AppStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: errorDiloagTitle,
                          ),
                        ),
                        SizedBox(height: sizeHeight(context) / 40),
                        Center(
                          child: ageSlider(),
                        ),
                        SizedBox(height: sizeHeight(context) / 40),
                        Text(
                          "Gender",
                          style: AppStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: errorDiloagTitle,
                          ),
                        ),
                        SizedBox(height: sizeHeight(context) / 40),
                        genderSelect(),
                        SizedBox(height: sizeHeight(context) / 40),
                        Text(
                          "Aadhaar & Passport Number",
                          style: AppStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: errorDiloagTitle,
                          ),
                        ),
                        SizedBox(height: sizeHeight(context) / 40),
                        aadharPassportNumber(),
                        SizedBox(height: sizeHeight(context) / 40),
                        Text(
                          "Pincode & Area",
                          style: AppStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: errorDiloagTitle,
                          ),
                        ),
                        SizedBox(height: sizeHeight(context) / 40),
                        MultiProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<StateFilterBloc>(),
                            ),
                            BlocProvider.value(
                              value: context.read<VisitorsGroupingBloc>(),
                            ),
                            BlocProvider.value(
                              value: context.read<CityFilterBloc>(),
                            ),
                            BlocProvider.value(
                              value: context.read<AreaFilterBloc>(),
                            ),
                          ],
                          child: areaSelect(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sizeHeight(context) / 40),
                filterButton()
              ],
            )),
      ),
    );
  }

  Widget ageSlider() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 24,
          top: 0,
          child: Builder(
            builder: (context) {
              Color? containerColor = _currentSliderValue >= startValue
                  ? ageSliderColor
                  : ageSliderInactiveColor;

              return Container(
                width: sizeWidth(context) / 95,
                height: sizeHeight(context) / 38,
                color: containerColor,
              );
            },
          ),
        ),
        Positioned(
          right: 24,
          top: 0,
          child: Builder(
            builder: (context) {
              // Assuming _currentSliderValue2 and end are properly defined elsewhere
              Color containerColor = _currentSliderValue2 == endValue
                  ? ageSliderColor
                  : ageSliderInactiveColor;

              return Container(
                width: sizeWidth(context) / 95,
                height: sizeHeight(context) / 38,
                color: containerColor,
              );
            },
          ),
        ),
        RangeSlider(
          activeColor: ageSliderColor,
          values: _currentRangeValues,
          min: 0,
          max: 100,
          divisions: 100,
          labels: RangeLabels(
            _currentRangeValues.start.toInt().toString(),
            _currentRangeValues.end.toInt().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              startValue = values.start.toInt();
              endValue = values.end.toInt();
            });
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(25, sizeWidth(context) / 11, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                startValue.toStringAsFixed(0),
                style: AppStyle.bodyLarge(context)
                    .copyWith(color: errorDiloagSubtitle),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(sizeWidth(context) / 1.2,
              sizeWidth(context) / 11, sizeWidth(context) / 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                endValue.toStringAsFixed(0),
                style: AppStyle.bodyLarge(context)
                    .copyWith(color: errorDiloagSubtitle),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget filterButton() {
    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Button(
                borderColor: profileTextColor,
                isRectangularBorder: true,
                buttonType: ButtonType.stroked,
                onPressed: () {
                  if (widget.isFromVisitor ?? false) {
                    context.read<VisitorsGroupingBloc>().getVisitorsGrouping();
                  } else if (widget.isFromReport ?? false) {
                    context.read<ReportListBloc>().getReportList();
                  } else if (widget.isFromCurrentVisitor ?? false) {
                    context
                        .read<CurrentVisitorsGroupingBloc>()
                        .currentVisitorsGrouping();
                  } else if (widget.isFromRent ?? false) {
                    context.read<RentedListingBloc>().rentedListing();
                  }
                  Navigator.pop(context);
                },
                child: Text('Clear All',
                    style: AppStyle.buttonStyle(context)
                        .copyWith(color: profileTextColor)),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Button(
                isRectangularBorder: true,
                buttonType: ButtonType.solid,
                onPressed: () {
                  if (FormErrorBuilder.validateFormAndShowErrors(context)) {
                    applyFilters();
                  }
                },
                child: Text('Apply', style: AppStyle.buttonStyle(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  applyFilters() {
    if (widget.isFromVisitor ?? false) {
      context.read<VisitorsGroupingBloc>().getVisitorsGrouping(
          filters: FiltersModel(
              visaNumber: visaNumberController?.text,
              genderFilter: selectedGenderType,
              aadharNo: aadharController?.text,
              pincodeFilter: context.read<FiltersModel>().pinCode,
              agemax: endValue.toString(),
              agemin: startValue.toString(),
              stateFk: context.read<FiltersModel>().stateFk,
              cityFk: context.read<FiltersModel>().cityFk,
              areaFk: context.read<FiltersModel>().areaFk));
    } else if (widget.isFromReport ?? false) {
      context.read<ReportListBloc>().getReportList(
            filters: FiltersModel(
              visaNumber: visaNumberController?.text,
              genderFilter: selectedGenderType,
              aadharNo: aadharController?.text,
              pincodeFilter: context.read<FiltersModel>().pinCode,
              agemax: endValue.toString(),
              agemin: startValue.toString(),
              stateFk: context.read<FiltersModel>().stateFk,
              cityFk: context.read<FiltersModel>().cityFk,
              areaFk: context.read<FiltersModel>().areaFk,
            ),
          );
    } else if (widget.isFromCurrentVisitor ?? false) {
      context.read<CurrentVisitorsGroupingBloc>().currentVisitorsGrouping(
            filters: FiltersModel(
              visaNumber: visaNumberController?.text,
              genderFilter: selectedGenderType,
              aadharNo: aadharController?.text,
              pincodeFilter: context.read<FiltersModel>().pinCode,
              agemax: endValue.toString(),
              agemin: startValue.toString(),
              stateFk: context.read<FiltersModel>().stateFk,
              cityFk: context.read<FiltersModel>().cityFk,
              areaFk: context.read<FiltersModel>().areaFk,
            ),
          );
    } else if (widget.isFromRent ?? false) {
      context.read<RentedListingBloc>().rentedListing(
            filters: FiltersModel(
              visaNumber: visaNumberController?.text,
              genderFilter: selectedGenderType,
              aadharNo: aadharController?.text,
              pincodeFilter: context.read<FiltersModel>().pinCode,
              agemax: endValue.toString(),
              agemin: startValue.toString(),
              stateFk: context.read<FiltersModel>().stateFk,
              cityFk: context.read<FiltersModel>().cityFk,
              areaFk: context.read<FiltersModel>().areaFk,
            ),
          );
    }
    Navigator.pop(context);
  }

  Widget aadharPassportNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldLabel(
                isFromFilter: true,
                label: 'Aadhaar Number',
                style: AppStyle.titleSmall(context)
                    .copyWith(color: foreignerTextLabelColor),
              ),
              SizedBox(height: sizeHeight(context) / 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AddFormField(
                    key: const Key('aadhar'),
                    controller: aadharController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Aadhaar Number',
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          12), // Limits to 12 characters
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,12}$')), // Allows only digits
                    ],
                    onChanged: (aadharNo) {
                      context
                          .read<ValidatorOnChanged>()
                          .validateAadhar(aadharNo);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // Optional field logic: If value is null or empty, no validation error shown
                        return null; // No error message if field is empty or not required
                      }

                      // Apply validation if the field has a value
                      if (!RegExp(r'^[2-9][0-9]{3}[0-9]{4}[0-9]{4}$')
                          .hasMatch(value.replaceAll(" ", ""))) {
                        return 'Please enter valid Aadhaar No';
                      }

                      return null; // Return null if validation passes
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: sizeWidth(context) / 80),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldLabel(
                isFromFilter: true,
                label: 'Visa Number',
                style: AppStyle.titleSmall(context)
                    .copyWith(color: foreignerTextLabelColor),
              ),
              SizedBox(height: sizeHeight(context) / 80),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AddFormField(
                    controller: visaNumberController,
                    hintText: 'Enter Visa Number',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget genderSelect() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [1, 2, 3].map((int filter) {
        String label;

        // Assign label and text color based on filter value
        switch (filter) {
          case 1:
            label = 'Male';
            break;
          case 2:
            label = 'Female';
            break;
          case 3:
            label = 'Other';
            break;
          default:
            label = 'Unknown';
        }

        return FilterChip(
          label: Text(
            label,
            style: AppStyle.bodyLarge(context).copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          selected: selectedGenderType?.contains(filter) ?? false,
          backgroundColor: filterInactiveColor,
          side: const BorderSide(width: 0, color: filterInactiveColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                selectedGenderType?.add(filter);
              } else {
                selectedGenderType?.remove(filter);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget areaSelect() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldLabel(
                isFromFilter: true,
                label: 'State',
                style: AppStyle.titleSmall(context)
                    .copyWith(color: foreignerTextLabelColor),
              ),
              SizedBox(height: sizeHeight(context) / 80),
              SelectField(
                errorMsg: "",
                title: "State",
                style:
                    AppStyle.bodyMedium(context).copyWith(color: Colors.black),
                hintText:
                    context.read<FiltersModel>().stateValue ?? "Select State",
                items: context.watch<StateFilterBloc>().state.getData()?.data ??
                    [],
                displaySearchField: true,
                onTap: () {
                  setState(() {});
                },
                onSelect: (v) {
                  context.read<FiltersModel>().stateFk = v?.value;
                  context.read<FiltersModel>().stateValue = v?.label;
                  context.read<FiltersModel>().cityFk = null;
                  context.read<FiltersModel>().cityValue = null;
                  context.read<FiltersModel>().areaFk = null;
                  context.read<FiltersModel>().areaValue = null;
                  context.read<CityFilterBloc>().getCity(
                      stateValue: context.read<FiltersModel>().stateFk);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              Row(children: [
                FormFieldLabel(
                  isFromFilter: true,
                  label: 'City',
                  style: AppStyle.titleSmall(context)
                      .copyWith(color: foreignerTextLabelColor),
                ),
                SizedBox(width: sizeHeight(context) / 8),
                FormFieldLabel(
                  isFromFilter: true,
                  label: 'Area',
                  style: AppStyle.titleSmall(context)
                      .copyWith(color: foreignerTextLabelColor),
                ),
                SizedBox(width: sizeHeight(context) / 9),
                FormFieldLabel(
                  isFromFilter: true,
                  label: 'Pincode',
                  style: AppStyle.titleSmall(context)
                      .copyWith(color: foreignerTextLabelColor),
                ),
              ]),
              SizedBox(height: sizeHeight(context) / 60),
              Row(
                children: [
                  Expanded(
                    child: SelectField(
                      errorMsg: "",
                      title: "City",
                      hintText: context.read<FiltersModel>().cityValue ??
                          "Select City",
                      items: context
                              .watch<CityFilterBloc>()
                              .state
                              .getData()
                              ?.data ??
                          [],
                      displaySearchField: true,
                      onTap: () {
                        setState(() {});
                      },
                      onSelect: (v) {
                        context.read<FiltersModel>().cityFk = v?.value;
                        context.read<FiltersModel>().cityValue = v?.label;
                        context.read<FiltersModel>().areaFk = null;
                        context.read<FiltersModel>().areaValue = null;
                        context.read<AreaFilterBloc>().getArea(
                            cityValue: context.read<FiltersModel>().cityFk);
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: sizeHeight(context) / 50),
                  Expanded(
                    child: SelectField(
                      errorMsg: "",
                      title: "Area",
                      hintText: context.read<FiltersModel>().areaValue ??
                          "Select Area",
                      style: AppStyle.bodyMedium(context)
                          .copyWith(color: Colors.black),
                      items: context
                              .watch<AreaFilterBloc>()
                              .state
                              .getData()
                              ?.data ??
                          [],
                      displaySearchField: true,
                      onTap: () {
                        setState(() {});
                      },
                      onSelect: (v) {
                        context.read<FiltersModel>().areaFk = v?.value;
                        context.read<FiltersModel>().areaValue = v?.label;
                        context.read<FiltersModel>().pinCode = v?.pinCode;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: sizeHeight(context) / 50),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AddFormField(
                        keyboardType: TextInputType.number,
                        isReadOnly: true,
                        hintText: context.read<FiltersModel>().pinCode ?? '-',
                        style: AppStyle.bodyLarge(context)
                            .copyWith(color: errorDiloagSubtitle),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
