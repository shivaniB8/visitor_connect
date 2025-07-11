import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final bool? isFromWallet;
  final Function()? onTap;
  const AppBarWidget({
    super.key,
    this.title,
    this.isFromWallet,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200,
            color: background_color,
          ),
          Image.asset(
            '$images_path/lines.png',
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.none,
          ),
          Positioned(
            left: 15,
            top: 70,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title ?? '',
                      style: text_style_title3,
                    ),
                    const Spacer(),
                    if (isFromWallet ?? false)
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              '$icons_path/invoice.png',
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
