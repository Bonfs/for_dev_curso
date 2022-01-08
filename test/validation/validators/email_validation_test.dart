import 'package:for_dev_curso/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String? validate(String value) {
    RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isValid = value.isEmpty || emailRegex.hasMatch(value);
    return isValid ? null : 'Campo inválido.';
  }
}

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('matheusbonfim05@gmail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('matheusbonfim05gmail.com'), 'Campo inválido.');
  });
}