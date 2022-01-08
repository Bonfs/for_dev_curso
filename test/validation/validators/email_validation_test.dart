import 'package:test/test.dart';

import 'package:for_dev_curso/validation/validators/validators.dart';

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