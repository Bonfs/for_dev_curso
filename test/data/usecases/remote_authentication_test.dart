import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/data/usecases/usecases.dart';
import 'package:for_dev_curso/data/http/http.dart';
import 'package:for_dev_curso/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

@GenerateMocks([HttpClient])
void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url; // sut = system under test

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call http client with correct values', () async {
    // AAA => Arrange, act and assert
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: { 'email': params.email, 'password': params.password }
    ));
  });
}
