import 'package:faker/faker.dart';
import 'package:for_dev_curso/domain/entities/entities.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/domain/usecases/authentication.dart';
import 'package:for_dev_curso/presentation/presenters/presenters.dart';
import 'package:for_dev_curso/presentation/protocols/protocols.dart';
import 'stream_login_presenter_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<Validation>(as: #ValidationSpy),
  MockSpec<Authentication>(as: #AuthenticationSpy)
])
void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late AuthenticationSpy authentication;
  late String email;
  late String password;

  PostExpectation mockValidationCall(String? field) =>
    when(validation.validate(field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({ String? field, String value = '' }) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validations fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    // expectLater(sut.emailErrorStream, emitsInOrder(['error']));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit empty String if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call validation with correct passowrd', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validations fails', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit empty String if password validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should expect form validation succeeds', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () {
    when(authentication.auth(AuthenticationParams(email: email, password: password)))
      .thenAnswer((_) async => AccountEntity(faker.internet.ipv4Address()));

    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.auth();

    verify(authentication.auth(AuthenticationParams(email: email, password: password))).called(1);
  });
}