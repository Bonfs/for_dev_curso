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

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}