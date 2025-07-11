import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaytmPaymentInProcessWidget extends StatelessWidget {
  const PaytmPaymentInProcessWidget(
      {super.key, required this.title, required this.msgLine1, this.msgLine2});

  final String title;
  final String msgLine1;
  final String? msgLine2;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CupertinoActivityIndicator(radius: 20, color: Colors.blue),
              Text(
                title,
                // "Processing...",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size / 70,
                    fontFamily: "open_sans",
                    color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 44),
          Text(msgLine1,
              // "Redirecting you to the payment gateway.\nIt might take few seconds.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size / 100,
                  fontFamily: "open_sans",
                  color: Colors.blue)),
          const SizedBox(height: 12),
          if (msgLine2 != null)
            Text(msgLine2 ?? "",
                // "Please do not press back button or close the application",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size / 100,
                    fontFamily: "open_sans",
                    color: Colors.blue)),
        ],
      ),
    );
  }
}
