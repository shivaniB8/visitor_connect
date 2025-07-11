import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class TitleDropDownWidget extends StatefulWidget {
  const TitleDropDownWidget({Key? key}) : super(key: key);

  @override
  State<TitleDropDownWidget> createState() => _TitleDropDownWidgetState();
}

class _TitleDropDownWidgetState extends State<TitleDropDownWidget> {
  List dropDownListData = [
    {"title": "Mr", "value": "1"},
    {"title": "Mrs", "value": "2"},
    {"title": "Miss", "value": "3"},
    {"title": "Dr.", "value": "4"},
    {"title": "Prof.", "value": "4"},
    {"title": "None", "value": "4"},
  ];

  String defaultValue = "";
  String secondDropDown = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(10),
            isDense: true,
            value: defaultValue,
            menuMaxHeight: 200,
            items: [
              const DropdownMenuItem(
                value: "",
                child: Text(
                  "Title",
                  style: text_style_para2,
                ),
              ),
              ...dropDownListData.map<DropdownMenuItem<String>>(
                (data) {
                  return DropdownMenuItem(
                    value: data['value'],
                    child: Text(data['title']),
                  );
                },
              ).toList(),
            ],
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
