import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class FormFieldLabel extends StatelessWidget {
  final String? label;
  final TextStyle? style;
  final bool? isRequired;
  final bool? isFromFilter;

  const FormFieldLabel(
      {Key? key,
      this.label,
      this.isRequired = false,
      this.style,
      this.isFromFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return label != null
        ? RichText(
            overflow: TextOverflow.clip,
            // textAlign: TextAlign.end,
            textDirection: TextDirection.ltr,
            softWrap: true,
            maxLines: 1,
            textScaleFactor: 1,
            text: TextSpan(
              text: label ?? '',
              style:
                  isFromFilter ?? false ? style : AppStyle.bodyMedium(context),
              children: <TextSpan>[
                (isRequired ?? false)
                    ? TextSpan(
                        text: ''.toReq,
                        style: AppStyle.errorStyle(context),
                      )
                    : const TextSpan(
                        text: '',
                      ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
