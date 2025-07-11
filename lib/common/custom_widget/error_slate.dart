import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';

import '../res/styles.dart';

class ErrorSlate extends StatelessWidget {
  final bool isUpdate;
  const ErrorSlate({Key? key, this.isUpdate = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '$icons_path/fail.png',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please Try Again Later',
                style: AppStyle.titleMedium(context),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  'There is Some error with you can try again after some time',
                  style: AppStyle.headlineSmall(context).copyWith(
                    color: buttonColor,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
