abstract class Validator {
  bool validate(String? value);
}

class NonEmptyFieldValidator implements Validator {
  @override
  bool validate(String? value) {
    if (value == null) return false;
    return value.isNotEmpty;
  }
}

class TextLimitationValidator extends NonEmptyFieldValidator {
  static const double minLength = 1;
  static const double maxLength = 30;

  @override
  bool validate(String? value) {
    bool result = super.validate(value);
    if (result) {
      if (value != null) {
        return value.length > minLength && value.length < maxLength;
      }
    }
    return result;
  }
}

class TaskValidators {
  final TextLimitationValidator _textLimitationValidator =
      TextLimitationValidator();
  final String textLimitationText =
      'Name length must be 2 to 30 characters long';

  String? validateName(String? value) {
    if (!_textLimitationValidator.validate(value)) {
      return textLimitationText;
    }
    return null;
  }
}
