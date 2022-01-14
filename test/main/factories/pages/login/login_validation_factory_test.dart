import 'package:test/test.dart';

import 'package:for_dev_curso/main/factories/factories.dart';
import 'package:for_dev_curso/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
    ]);
  });
}