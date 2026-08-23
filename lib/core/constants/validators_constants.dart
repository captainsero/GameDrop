abstract class ValidatorsConstants {
  static const String regExpValidateName = r'^[a-zA-Z]+$';
  static const String regExpValidatePhone = r'^\+?20?01[0125][0-9]{8}$';
  static const String regExpValidatePassword =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
  static const String regExpValidateEmail =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String regExpValidateNid = r'^\d{14}$';
}
