import 'package:host_visitor_connect/common/extensions/date_time_extensions.dart';
import 'package:host_visitor_connect/common/extensions/number_extensions.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

extension StringExtensions on String {
  /// checks whether the string contains only positive digits
  bool containsOnlyPositiveDigits() {
    const pattern = r'^\d+$';
    return RegExp(pattern).hasMatch(this);
  }

  bool isOtpValid() {
    return containsOnlyPositiveDigits() && length == 6;
  }

  launchUrl({bool inAppWebview = true}) async {
    final uri = Uri.parse(this);
    if (await ul.canLaunchUrl(uri)) {
      await ul.launchUrl(
        uri,
        mode: inAppWebview
            ? ul.LaunchMode.inAppWebView
            : ul.LaunchMode.externalApplication,
      );
    }
  }

  launchCallingApp() async {
    final uri = Uri.parse('tel:$this');
    if (await ul.canLaunchUrl(uri)) {
      await ul.launchUrl(uri);
    }
  }

  launchMailApp() async {
    final uri = Uri.parse('mailto:$this');
    if (await ul.canLaunchUrl(uri)) {
      await ul.launchUrl(uri);
    }
  }

  /// Add required symbol to strings
  String get toReq {
    return '$this *';
  }

  int getGenderString() {
    if (this == 'Male') {
      return 1;
    } else {
      if (this == 'Female') {
        return 2;
      } else if (this == 'Other') {
        return 3;
      } else {
        return 1;
      }
    }
  }

  /// Removes extra zeros after decimal
  String trimDecimalTrailingZeroes() {
    if (contains('.')) {
      final regex = RegExp(r'([.]*0+)(?!.*\d)');
      return replaceAll(regex, '');
    }
    return this;
  }
}

String stringDateToDate(String dateString) {
  if (dateString.isNotEmpty) {
    final dateTime = DateTime(
        int.parse((dateString.substring(0, 4))),
        int.parse((dateString).substring(6, 7)),
        int.parse((dateString).substring(9, 10)));

    return DateFormat('dd/MM/yyyy').format(dateTime);
  } else {
    return 'Not Available';
  }
}

String convertDateFormatToSlash(String inputDate) {
  if (inputDate.isNullOrEmpty()) {
    return 'Not Available';
  }
  // Define the input and output date formats
  else {
    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    DateFormat outputFormat = DateFormat('dd/MM/yyyy');

    // Parse the input date string to DateTime
    DateTime dateTime = inputFormat.parse(inputDate);
    print("inputFormat >> $inputDate");

    // Format the DateTime to the desired output format
    String outputDate = outputFormat.format(dateTime);

    return outputDate;
  }
}

String timeStampToTime(String? timeStamp) {
  if (timeStamp.isNullOrEmpty()) {
    return 'Not Available';
  }
  final parsedTimeStamp = int.parse(timeStamp ?? '');
  return DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000)
      .formatDate('hh:mm a');
}

String formatTime(String givenTime) {
  if (!(givenTime.isNullOrEmpty())) {
    DateTime dateTime = DateTime.parse(givenTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }
  return 'Not Available';
}

DateTime? dateTimeFromString(String? dateTimeString) {
  try {
    return DateTime.parse(dateTimeString ?? '');
  } catch (exception) {
    return null;
  }
}

String capitalizedString(String string) {
  if (string.isNullOrEmpty()) {
    return 'N/A';
  }

  List<String> words = string.split(' ');
  List<String> capitalizedWords = words.map((word) {
    List<String> subWords = word.split('.');
    List<String> capitalizedSubWords =
        subWords.map((subWord) => capitalize(subWord)).toList();
    return capitalizedSubWords.join('.');
  }).toList();

  return capitalizedWords.join(' ');
}

String capitalize(String word) {
  if (word.isNullOrEmpty()) {
    return '';
  }
  return "${word[0].toUpperCase()}${word.substring(1)}";
}

String timeStampToDateTime(String? timeStamp) {
  if (timeStamp.isNullOrEmpty()) {
    return 'N/A';
  }
  final parsedTimeStamp = int.parse(timeStamp ?? '');
  return DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000)
      .formatDate('dd/MM/yyyy');
}

String convertDate(String? date) {
  if (date.isNullOrEmpty()) {
    return "N/A";
  }
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date ?? "");
  // Format the parsed date to the desired format
  return DateFormat('dd/MM/yyyy').format(parsedDate);
}

String timeStampToDateAndTime(String? timeStamp, {bool? sendAnd}) {
  if (timeStamp.isNullOrEmpty()) {
    return 'N/A';
  }

  final parsedTimeStamp = int.tryParse(timeStamp ?? '');
  if (parsedTimeStamp == null) {
    return 'Invalid timestamp';
  }

  // Convert timestamp to DateTime in UTC
  final dateTime = DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000);

  // Format the DateTime object to show time and date in GMT/UTC
  final gmtFormatter = DateFormat('dd-MM-yyyy hh:mm a', 'en_US');
  final gmtDateTime = gmtFormatter.format(dateTime);

  return gmtDateTime.toLowerCase();
}

String timeStampToDateAndTimeUTC(String? timeStamp, {bool? sendAnd}) {
  if (timeStamp.isNullOrEmpty()) {
    return 'N/A';
  }

  final parsedTimeStamp = int.tryParse(timeStamp ?? '');
  if (parsedTimeStamp == null) {
    return 'Invalid timestamp';
  }

  // Convert timestamp to DateTime in UTC
  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000, isUtc: true);

  // Format the DateTime object to show time and date in GMT/UTC
  final gmtFormatter = DateFormat('dd-MM-yyyy hh:mm a', 'en_US');
  final gmtDateTime = gmtFormatter.format(dateTime);

  return gmtDateTime.toLowerCase();
}

String timeStampToDateAndTime2(String? timeStamp, {bool? sendAnd}) {
  print('timeStamp $timeStamp');

  if (timeStamp.isNullOrEmpty()) {
    return 'N/A';
  }
  final parsedTimeStamp = int.parse(timeStamp ?? '');
  return DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000)
      .formatDate('dd-MM-yyyy @ hh:mm a')
      .toLowerCase();
}

extension NullableStringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.trim().isEmpty;
  }
}

String? timeStampToDateTimeForRelativeTime(String? timestamp) {
  if ((timestamp?.isNotEmpty ?? false) || timestamp != null) {
    final parsedTimeStamp = int.parse(timestamp ?? '');
    final date = DateTime.fromMillisecondsSinceEpoch(parsedTimeStamp * 1000);
    final value = getTime(date);
    return value;
  }
  return null;
}

String? getTime(time) {
  if (!DateTime.now().difference(time).isNegative) {
    if (DateTime.now().difference(time).inMinutes < 1) {
      return "${DateTime.now().difference(time).inSeconds} second ago";
    } else if (DateTime.now().difference(time).inMinutes < 60) {
      return "${DateTime.now().difference(time).inMinutes} minutes ago";
    } else if (DateTime.now().difference(time).inHours <= 24) {
      return "${DateTime.now().difference(time).inHours} hours ago";
    } else if (DateTime.now().difference(time).inDays / 365 >= 1) {
      return "${(DateTime.now().difference(time).inDays / 365).floor()} years ago";
    } else if ((DateTime.now().difference(time).inDays / 7) >= 4) {
      return "${(DateTime.now().difference(time).inDays / 30).floor()} month ago";
    } else if (DateTime.now().difference(time).inDays < 7) {
      return "${DateTime.now().difference(time).inDays} days ago";
    } else if (DateTime.now().difference(time).inDays >= 7) {
      return "${(((DateTime.now().difference(time).inDays) / 7).floor())} weeks ago";
    }
  }
  return 'Not Available';
}

String? checkOut(int? branchCategory) {
  if (branchCategory == 6) {
    return 'Return';
  } else if (branchCategory == 1 ||
      branchCategory == 2 ||
      branchCategory == 3 ||
      branchCategory == 4 ||
      branchCategory == 5) {
    return 'Checkout';
  } else {
    return 'Checkout';
  }
}

String? checkOutMessage(int? branchCategory) {
  if (branchCategory == 6) {
    return 'Are you sure you want to Return';
  } else if (branchCategory == 1 ||
      branchCategory == 2 ||
      branchCategory == 3 ||
      branchCategory == 4 ||
      branchCategory == 5) {
    return 'Are you sure you want to Checkout';
  } else {
    return 'Are you sure you want to Out';
  }
}

String? visitingFrom(int? branchCategory) {
  if (branchCategory == 6) {
    return 'Rented Date';
  } else if (branchCategory == 1 ||
      branchCategory == 2 ||
      branchCategory == 3 ||
      branchCategory == 4 ||
      branchCategory == 5) {
    return 'Check In';
  } else {
    return 'In Time';
  }
}

String? visitingTill(int? branchCategory) {
  if (branchCategory == 6) {
    return 'Return Date';
  } else if (branchCategory == 1 ||
      branchCategory == 2 ||
      branchCategory == 3 ||
      branchCategory == 4 ||
      branchCategory == 5) {
    return 'Checkout';
  } else {
    return 'Out Time';
  }
}

bool isIndian(int? visitorType) {
  if (visitorType == 1) {
    return true;
  }
  return false;
}

bool isAfterToday(String timestamp) {
  final parsedTimeStamp = int.parse(timestamp);
  return DateTime.now().toUtc().isAfter(
        DateTime.fromMillisecondsSinceEpoch(
          parsedTimeStamp * 1000,
          isUtc: false,
        ).toUtc(),
      );
}

String getMonthInWord(int month, {bool? inFullWords = false}) {
  if (inFullWords == true) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  } else {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}

// String convert24HrTo12HrTime(String? timeStamp) {
//   if (timeStamp.isNullOrEmpty()) {
//     return 'N/A';
//   }
//
//   return timeStamp;
// }
