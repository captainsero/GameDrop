import '../../generated/l10n.dart';
import 'validation_error.dart';

extension ValidationErrorLocalization on ValidationError {
  String localize(S l10n) {
    return switch (this) {
      ValidationError.emailRequired => l10n.emailIsRequired,
      ValidationError.invalidEmail => l10n.enterValidEmail,
      ValidationError.invalidPassword => l10n.enterValidPassword,
      ValidationError.confirmPasswordRequired => l10n.confirmPassword,
      ValidationError.passwordsDoNotMatch => l10n.paswordNotMatched,
      ValidationError.otpRequired => l10n.codeIsRequired,
      ValidationError.invalidOtp => l10n.invalidCode,
      ValidationError.invalidEgyptianPhone =>
        l10n.enterValidEgyptianPhoneNumber,
      ValidationError.nameTooShort => l10n.mustBeAtLeast3Characters,
      ValidationError.nameOnlyLetters => l10n.onlyLettersAllowed,
      ValidationError.idNumberRequired => l10n.idNumberRequired,
      ValidationError.enterIdNumber => l10n.invalidIdNumber,
    };
  }
}
