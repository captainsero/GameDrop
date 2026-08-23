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
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
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

  /// `Request timed out. Please check your internet connection.`
  String get connectionTimeout {
    return Intl.message(
      'Request timed out. Please check your internet connection.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Server error. Please try again later.`
  String get serverError {
    return Intl.message(
      'Server error. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Requested resource not found.`
  String get notFound {
    return Intl.message(
      'Requested resource not found.',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorMessageGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorMessageGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your connection.`
  String get networkError {
    return Intl.message(
      'Network error. Please check your connection.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out. Please try again.`
  String get requestTimeout {
    return Intl.message(
      'Request timed out. Please try again.',
      name: 'requestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save information securely. Please try again.`
  String get secureStorageErrorMessage {
    return Intl.message(
      'Failed to save information securely. Please try again.',
      name: 'secureStorageErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No value found for key: `
  String get noValueKeyFound {
    return Intl.message(
      'No value found for key: ',
      name: 'noValueKeyFound',
      desc: '',
      args: [],
    );
  }

  /// `Service disabled`
  String get serviceDisabled {
    return Intl.message(
      'Service disabled',
      name: 'serviceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied forever`
  String get permissionDeniedForever {
    return Intl.message(
      'Permission denied forever',
      name: 'permissionDeniedForever',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get paswordNotMatched {
    return Intl.message(
      'Passwords do not match',
      name: 'paswordNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeIsRequired {
    return Intl.message(
      'Code is required',
      name: 'codeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Egyptian phone number`
  String get enterValidEgyptianPhoneNumber {
    return Intl.message(
      'Enter a valid Egyptian phone number',
      name: 'enterValidEgyptianPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 3 characters`
  String get mustBeAtLeast3Characters {
    return Intl.message(
      'Must be at least 3 characters',
      name: 'mustBeAtLeast3Characters',
      desc: '',
      args: [],
    );
  }

  /// `Only letters allowed`
  String get onlyLettersAllowed {
    return Intl.message(
      'Only letters allowed',
      name: 'onlyLettersAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password needs uppercase, digit, and special char`
  String get enterValidPassword {
    return Intl.message(
      'Password needs uppercase, digit, and special char',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `ID number is required`
  String get idNumberRequired {
    return Intl.message(
      'ID number is required',
      name: 'idNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 14-digit ID number`
  String get invalidIdNumber {
    return Intl.message(
      'Enter a valid 14-digit ID number',
      name: 'invalidIdNumber',
      desc: '',
      args: [],
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
