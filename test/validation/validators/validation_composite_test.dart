import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/validation/protocols/protocols.dart';
import 'package:for_dev_curso/validation/validators/validators.dart';

import './validation_composite_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<FieldValidation>(as: #FieldValidationSpy)])
void main() {
  late ValidationComposite sut;
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;

  void mockValidation1(String? error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String? error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String? error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);
    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('other_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return empty if all validations return null or empty', () {
    mockValidation2('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, '');
  });
  
  test('Should return the first error of the field', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });
}