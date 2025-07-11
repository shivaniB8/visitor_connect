// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(fieldName) => "${fieldName} is required";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addVisitor_label_uploadPhoto":
            MessageLookupByLibrary.simpleMessage("Upload Photo"),
        "app_name":
            MessageLookupByLibrary.simpleMessage("Visitors Connect Host"),
        "forgotPasswordScreen_label_forgotPasswordSendPassword":
            MessageLookupByLibrary.simpleMessage(
                "You will receive a message on your Mobile Number"),
        "formField_error_isEmpty": m0,
        "loginPage_label_doNotRememberPassword":
            MessageLookupByLibrary.simpleMessage(
                "Don\'t remember the Password ?"),
        "loginPage_label_enterPassword":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "loginPage_label_enterYourMobileNumber":
            MessageLookupByLibrary.simpleMessage("Enter Mobile Number"),
        "loginPage_label_forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "loginPage_label_mobileNo":
            MessageLookupByLibrary.simpleMessage("Mobile Number"),
        "loginPage_label_password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "login_heading_welcomeMsg": MessageLookupByLibrary.simpleMessage(
            "Welcome Taj Cidade de Goa Horizon"),
        "mobileNoValidation_label_pleaseEnterMobileNumber":
            MessageLookupByLibrary.simpleMessage("Please enter Mobile Number"),
        "mobileNoValidation_label_pleaseEnterValidMobileNumber":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a valid Mobile Number")
      };
}
