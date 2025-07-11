import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/paths.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class TitleBar extends StatelessWidget {
  final String? title;
  final double? height;
  final bool? skip;
  final bool? isBack;
  final bool? goAhead;
  final Function()? onGoNext;
  const TitleBar({
    super.key,
    this.title,
    this.height,
    this.skip = false,
    this.isBack = true,
    this.goAhead,
    this.onGoNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 300,
            color: background_color,
          ),
          Image.asset(
            '$images_path/lines.png',
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.none,
          ),
          Positioned(
            left: 15,
            top: (height != null && height != 0) ? height : 120,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  if (isBack ?? false)
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF232323),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        height: 35,
                        width: 35,
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (isBack ?? false)
                    const SizedBox(
                      width: 20,
                    ),
                  Text(
                    title ?? 'Title',
                    style: text_style_title3,
                  ),
                  const Spacer(),
                  if (goAhead ?? false)
                    GestureDetector(
                      onTap: () {
                        onGoNext?.call();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(
                          child: Row(
                            children: [
                              Text(
                                'Next',
                                style: text_style_title3,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
