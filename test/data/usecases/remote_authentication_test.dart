import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev_curso/data/usecases/usecases.dart';
import 'package:for_dev_curso/data/http/http.dart';
import 'package:for_dev_curso/domain/helpers/helpers.dart';
import 'package:for_dev_curso/domain/usecases/usecases.dart';

import 'remote_authentication_test.mocks.dart';

// class HttpClientSpy extends Mock implements HttpClient {}

@GenerateMocks([], customMocks: [MockSpec<HttpClient>(as: #HttpClientSpy)])
void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url; // sut = system under test
  late AuthenticationParams params ;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
  });

  test('Should call http client with correct values', () async {
    // AAA => Arrange, act and assert
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: { 'email': params.email, 'password': params.password }
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.notFound);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.serverError);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
      .thenThrow(HttpError.unauthorized);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });
}
