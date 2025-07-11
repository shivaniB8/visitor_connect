// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Visitors Connect Host`
  String get app_name {
    return Intl.message(
      'Visitors Connect Host',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Taj Cidade de Goa Horizon`
  String get login_heading_welcomeMsg {
    return Intl.message(
      'Welcome Taj Cidade de Goa Horizon',
      name: 'login_heading_welcomeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get loginPage_label_enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'loginPage_label_enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPage_label_password {
    return Intl.message(
      'Password',
      name: 'loginPage_label_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Mobile Number`
  String get loginPage_label_enterYourMobileNumber {
    return Intl.message(
      'Enter Mobile Number',
      name: 'loginPage_label_enterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get loginPage_label_mobileNo {
    return Intl.message(
      'Mobile Number',
      name: 'loginPage_label_mobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Don't remember the Password ?`
  String get loginPage_label_doNotRememberPassword {
    return Intl.message(
      'Don\'t remember the Password ?',
      name: 'loginPage_label_doNotRememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get loginPage_label_forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'loginPage_label_forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get addVisitor_label_uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'addVisitor_label_uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `You will receive a message on your Mobile Number`
  String get forgotPasswordScreen_label_forgotPasswordSendPassword {
    return Intl.message(
      'You will receive a message on your Mobile Number',
      name: 'forgotPasswordScreen_label_forgotPasswordSendPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Mobile Number`
  String get mobileNoValidation_label_pleaseEnterMobileNumber {
    return Intl.message(
      'Please enter Mobile Number',
      name: 'mobileNoValidation_label_pleaseEnterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid Mobile Number`
  String get mobileNoValidation_label_pleaseEnterValidMobileNumber {
    return Intl.message(
      'Please enter a valid Mobile Number',
      name: 'mobileNoValidation_label_pleaseEnterValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `{fieldName} is required`
  String formField_error_isEmpty(Object fieldName) {
    return Intl.message(
      '$fieldName is required',
      name: 'formField_error_isEmpty',
      desc: '',
      args: [fieldName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
