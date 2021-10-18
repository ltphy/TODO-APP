import 'package:flutter_test/flutter_test.dart';
import 'package:todo/service/validators.dart';

void main() {
  group('empty field', () {
    test('non empty string', () {
      final validator = NonEmptyFieldValidator();
      expect(validator.validate('name'), true);
    });

    test('empty string', () {
      final validator = NonEmptyFieldValidator();
      expect(validator.validate(''), false);
    });

    test('null string', () {
      final validator = NonEmptyFieldValidator();
      expect(validator.validate(null), false);
    });
  });

  group('text limitaton', () {
    test('string with length larger than 1, and smaller than 30', () {
      final validator = TextLimitationValidator();
      expect(validator.validate('name'), true);
    });

    test('empty string', () {
      final validator = TextLimitationValidator();
      expect(validator.validate(''), false);
    });

    test('string with length smaller than 2', () {
      final validator = TextLimitationValidator();
      expect(validator.validate('a'), false);
    });

    test('string with length larger than 30', () {
      final validator = TextLimitationValidator();
      expect(
          validator.validate(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '),
          false);
    });

    test('null string', () {
      final validator = TextLimitationValidator();
      expect(validator.validate(null), false);
    });
  });

  group('validate name', () {
    test('string with length larger than 1, and smaller than 30', () {
      final validator = TaskValidators();
      expect(validator.validateName('name'), null);
    });

    test('empty string', () {
      final validator = TaskValidators();
      expect(validator.validateName(''), validator.textLimitationText);
    });

    test('string with length smaller than 2', () {
      final validator = TaskValidators();
      expect(validator.validateName('a'), validator.textLimitationText);
    });

    test('string with length larger than 30', () {
      final validator = TaskValidators();
      expect(
          validator.validateName(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '),
          validator.textLimitationText);
    });

    test('null string', () {
      final validator = TaskValidators();
      expect(validator.validateName(null), validator.textLimitationText);
    });
  });
}
