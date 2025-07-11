import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function()? btnOnTap;
  final String btnText;

  final Color btnTextColor;
  final Widget? prefixIcon;
  const ButtonWidget({
    super.key,
    this.btnOnTap,
    required this.btnText,
    required this.btnTextColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnOnTap,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 2.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? const SizedBox(),
            const SizedBox(width: 15),
            Text(
              btnText,
              style: TextStyle(
                color: btnTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
