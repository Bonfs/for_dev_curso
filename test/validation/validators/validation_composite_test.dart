import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/presentation/protocols/protocols.dart';
import 'package:for_dev_curso/validation/protocols/protocols.dart';

import './validation_composite_test.mocks.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    return '';
  }
}
@GenerateMocks([], customMocks: [MockSpec<FieldValidation>(as: #FieldValidationSpy)])
void main() {
  test('Should return empty if all validations return null or empty', () {
    final validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);
    final validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');
    final sut = ValidationComposite([validation1, validation2]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, '');
  });
}