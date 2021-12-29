import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'stream_login_presenter_test.mocks.dart';

abstract class Validation {
  String? validate({required String field, required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({ required this.validation });
  
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

@GenerateMocks([], customMocks: [MockSpec<Validation>(as: #ValidationSpy, returnNullOnMissingStub: true)])
void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });
  
  test('Should call validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}