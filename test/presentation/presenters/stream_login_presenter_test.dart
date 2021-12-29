import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'stream_login_presenter_test.mocks.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class LoginState {
  String emailError = '';
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({ required this.validation });
  
  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

@GenerateMocks([], customMocks: [MockSpec<Validation>(as: #ValidationSpy/* , returnNullOnMissingStub: true */)])
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