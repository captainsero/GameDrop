// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a  locale. All the
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
  String get localeName => '';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "codeIsRequired":
            MessageLookupByLibrary.simpleMessage("Code is required"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage(
            "Please confirm your password"),
        "connectionTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please check your internet connection."),
        "emailIsRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "enterValidEgyptianPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Enter a valid Egyptian phone number"),
        "enterValidEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "enterValidPassword": MessageLookupByLibrary.simpleMessage(
            "Password needs uppercase, digit, and special char"),
        "errorMessageGeneric": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again."),
        "idNumberRequired":
            MessageLookupByLibrary.simpleMessage("ID number is required"),
        "invalidCode": MessageLookupByLibrary.simpleMessage("Invalid code"),
        "invalidIdNumber": MessageLookupByLibrary.simpleMessage(
            "Enter a valid 14-digit ID number"),
        "mustBeAtLeast3Characters": MessageLookupByLibrary.simpleMessage(
            "Must be at least 3 characters"),
        "networkError": MessageLookupByLibrary.simpleMessage(
            "Network error. Please check your connection."),
        "noValueKeyFound":
            MessageLookupByLibrary.simpleMessage("No value found for key: "),
        "notFound": MessageLookupByLibrary.simpleMessage(
            "Requested resource not found."),
        "onlyLettersAllowed":
            MessageLookupByLibrary.simpleMessage("Only letters allowed"),
        "paswordNotMatched":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Permission denied"),
        "permissionDeniedForever":
            MessageLookupByLibrary.simpleMessage("Permission denied forever"),
        "requestTimeout": MessageLookupByLibrary.simpleMessage(
            "Request timed out. Please try again."),
        "secureStorageErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Failed to save information securely. Please try again."),
        "serverError": MessageLookupByLibrary.simpleMessage(
            "Server error. Please try again later."),
        "serviceDisabled":
            MessageLookupByLibrary.simpleMessage("Service disabled")
      };
}
