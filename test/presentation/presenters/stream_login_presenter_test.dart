import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/presentation/presenters/presenters.dart';
import 'package:for_dev_curso/presentation/protocols/protocols.dart';
import 'stream_login_presenter_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<Validation>(as: #ValidationSpy)])
void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;

  PostExpectation mockValidationCall(String? field) =>
    when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({ String? field, String value = '' }) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit error if validations fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    // expectLater(sut.emailErrorStream, emitsInOrder(['error']));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit empty String if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}