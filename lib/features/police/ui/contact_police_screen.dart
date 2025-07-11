import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/custom_widget_image_app_bar.dart';

import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';

import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

import 'package:host_visitor_connect/common/utils/utils.dart';

import '../../../common/custom_widget/button.dart';

class ContactPoliceScreen extends StatelessWidget {
  const ContactPoliceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double vertSpacing = appSize(context: context, unit: 10) / 10;
    return Scaffold(
      appBar: CustomImageAppBar(
        showSettings: false,
        showEditIcon: false,
        title: 'Contact Police',
        context: context,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: vertSpacing),
          Container(
            padding: const EdgeInsets.all(5), // Border width
            decoration: BoxDecoration(
              border:
                  Border.all(color: border_color.withOpacity(0.51), width: 5),
              color: Colors.white, // Border color
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipOval(
                child: Image.asset(
                  '$images_path/police.png',
                  fit: BoxFit.fill,
                  width: appSize(context: context, unit: 10) / 2.5,
                ),
              ),
            ),
          ),
          Text(
            'Contact Police',
            style: AppStyle.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: appSize(context: context, unit: 10) / 12),
          ),
          Text(
            "Feel free to contact us, we're \nalways here to help",
            style: AppStyle.titleLarge(context).copyWith(
                fontWeight: FontWeight.w400,
                fontSize: appSize(context: context, unit: 10) / 16),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: vertSpacing),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: light_blue_color),
            child: Row(
              children: [
                Text(
                  'Mapusa Police Station',
                  style: AppStyle.titleLarge(context).copyWith(
                      fontSize: appSize(context: context, unit: 10) / 12),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    '100'.launchCallingApp();
                  },
                  icon: Icon(
                    Icons.call,
                    color: primary_color,
                    size: appSize(context: context, unit: 10) / 8,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // Horizontal and vertical offset
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth()
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Name : ',
                        style: AppStyle.titleLarge(context),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Mr. Raj Rathod',
                        style: AppStyle.titleLarge(context),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Post : ',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: disabled_color,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Assistant sub-inspector, Mapusa \npolice station',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: primary_color,
                        ),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Email : ',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: disabled_color,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'rajdrathod@gmail.com',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: primary_color,
                        ),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        'Address :  ',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: disabled_color,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        'Mapusa – Anjuna Road, Near Fire \nStation Mapusa, Goa, 403507',
                        style: AppStyle.titleMedium(context).copyWith(
                          fontSize: sizeHeight(context) / 60,
                          fontWeight: FontWeight.w500,
                          color: primary_color,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: vertSpacing + 10),
          SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: sizeHeight(context) / 17,
            child: Button(
              isRectangularBorder: true,
              text: 'Get back to Dashboard',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
