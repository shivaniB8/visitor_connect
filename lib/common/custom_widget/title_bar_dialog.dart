import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:host_visitor_connect/common/res/styles.dart';
import 'package:host_visitor_connect/common/utils/utils.dart';

class TitleBarDialog extends StatelessWidget {
  final Widget bodyContent;
  final String headerTitle;
  final EdgeInsets insetPadding;
  final double? dialogHeight;

  const TitleBarDialog({
    Key? key,
    required this.bodyContent,
    required this.headerTitle,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 60,
    ),
    this.dialogHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: insetPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //..
          _DialogHeader(
            title: headerTitle,
          ),

          // Dialog Body
          _DialogBody(
            dialogHeight: dialogHeight,
            content: bodyContent,
          )
        ],
      ),
    );
  }
}

// Header of dialog.
class _DialogHeader extends StatelessWidget {
  final String title;
  const _DialogHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFEBEDF3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              title,
              style: AppStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

// Body of the Dialog.
class _DialogBody extends StatelessWidget {
  final Widget content;
  final double? dialogHeight;

  const _DialogBody({
    Key? key,
    required this.content,
    this.dialogHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: dialogHeight == 0 ? null : sizeHeight(context) * 0.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: content,
    );
  }
}
