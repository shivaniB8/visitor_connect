import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/custom_widget/app_bar_widget/title_bar.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TitleBar(title: 'Support'),
          Positioned(
            top: 180,
            left: 0.1,
            right: 0.1,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 25,
                  right: 25,
                  bottom: 15,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reach out to Help Desk',
                        style: text_style_para1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Help Desk Number: 180022641739',
                                    style: text_style_title13,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      '180022641739'.launchCallingApp();
                                    },
                                    icon: const Icon(
                                      Icons.call,
                                      color: buttonColor,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Email Id : support@samrudhtech.co.in',
                                    style: text_style_title13,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      'support@edynamics.co.in'.launchMailApp();
                                    },
                                    icon: const Icon(
                                      Icons.email,
                                      color: buttonColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'We are always here to help you.',
                          style: text_style_title3.copyWith(color: text_color),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          '24/7 Support.',
                          style: text_style_title3.copyWith(color: text_color),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        '$images_path/support.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'If you need help, please contact us.',
                          style: text_style_title3.copyWith(color: text_color),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
