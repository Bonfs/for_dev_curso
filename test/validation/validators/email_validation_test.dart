import 'package:for_dev_curso/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String? validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate('');

    expect(error, null);
  });
}