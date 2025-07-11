// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:host_visitor_connect/common/utils/toast_utils.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

/// This method makes sure the {callbackAfterBuild} is called
/// after all the frames are rendered & a state has been
/// successfully built

afterBuild(Function() callbackAfterBuild) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    callbackAfterBuild();
  });
}

showBottomSheet(
  BuildContext context,
  Widget bottomSheetContent, {
  bool? enableDrag,
  bool? isScrollControlled,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled ?? false,
    enableDrag: enableDrag ?? true,

    //builder
    builder: (_) {
      return bottomSheetContent;
    },
  );
}

/// Share file by showing platform specific sharing UI
Future<ShareResult> shareFiles(String path) async {
  return Share.shareWithResult(path).catchError((error, stacktrace) {
    return error;
  });
}

Future<ShareResult> shareText(String text) async {
  return Share.shareWithResult(text).catchError((error, stacktrace) {
    return error;
  });
}

///page route for entity forms that slide from bottom
Route createFormScreenRoute(Widget formScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => formScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(
        CurveTween(curve: Curves.easeInOutCubic),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// DateTime object form string
DateTime? dateTimeFromString(String? dateTimeString) {
  try {
    return DateTime.parse(dateTimeString ?? '');
  } catch (exception) {
    return null;
  }
}

String? formattedDateTimeToString(String? dateTimeString) {
  try {
    return DateFormat('dd MMM yyy')
        .format(dateTimeFromString(dateTimeString) ?? DateTime.now());
  } catch (exception) {
    return null;
  }
}

String? dateTimeToString(DateTime? dateTime) {
  return dateTime?.toString();
}

/// Returns file name without extension from URL
String getFileNameWithoutExtension(String url) {
  return path.basenameWithoutExtension(Uri.parse(url).path);
}

void openFile(BuildContext context, String filePath) async {
  final openResult = await OpenFile.open(filePath);
  if (openResult.type != ResultType.done) {
    if (openResult.type == ResultType.noAppToOpen) {
      ToastUtils().showToast(
        context,
        message: 'No App Found',
      );
    } else {
      ToastUtils().showToast(
        context,
        message: 'Unknown Error',
      );
    }
  }
}

sizeHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

sizeWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
