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
  late AuthenticationParams params;

  Map mockValidData() => {
    'accessToken': faker.guid.guid(), 
    'name': faker.person.name()
  };

  PostExpectation mockRequest() =>
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')));

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    mockHttpData(mockValidData());
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
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {
    mockHttpError(HttpError.unauthorized);
      
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpData(validData);
      
    final account = await sut.auth(params);

    expect(account.token, validData['accessToken']);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData({ 'ivalid_key': 'invalid_value' });

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
