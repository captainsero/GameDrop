import '../../core/constants/validators_constants.dart';
import '../../core/errors/validation_error.dart';

abstract class AppTextFieldValidator {
  // ✅ Email validation
  static ValidationError? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationError.emailRequired;
    }

    final email = value.trim();
    final emailRegex = RegExp(ValidatorsConstants.regExpValidateEmail);

    if (!emailRegex.hasMatch(email)) {
      return ValidationError.invalidEmail;
    }

    return null;
  }

  // ✅ Password validation
  static ValidationError? validatePassword(String? value) {
    final passRegex = RegExp(ValidatorsConstants.regExpValidatePassword);
    if (value == null || !passRegex.hasMatch(value)) {
      return ValidationError.invalidPassword;
    }
    return null;
  }

  // ✅ Confirm Password
  static ValidationError? validateConfirmPassword(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return ValidationError.confirmPasswordRequired;
    }
    if (value != password) {
      return ValidationError.passwordsDoNotMatch;
    }
    return null;
  }

  // ✅ OTP validation
  static ValidationError? validateOtpCode(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.otpRequired;
    }
    if (value.length != 6) {
      return ValidationError.invalidOtp;
    }
    return null;
  }

  // ✅ Egyptian phone
  static ValidationError? validatePhone(String? value) {
    final phoneRegex = RegExp(ValidatorsConstants.regExpValidatePhone);
    if (value == null || !phoneRegex.hasMatch(value)) {
      return ValidationError.invalidEgyptianPhone;
    }
    return null;
  }

  // ✅ Name validation
  static ValidationError? validateName(String? value) {
    if (value == null || value.length < 3) {
      return ValidationError.nameTooShort;
    }
    if (!RegExp(ValidatorsConstants.regExpValidateName).hasMatch(value)) {
      return ValidationError.nameOnlyLetters;
    }
    return null;
  }

  static ValidationError? validateNid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ValidationError.idNumberRequired;
    }
    final nidRegex = RegExp(ValidatorsConstants.regExpValidateNid);
    if (!nidRegex.hasMatch(value.trim())) {
      return ValidationError.enterIdNumber;
    }
    return null;
  }
}
