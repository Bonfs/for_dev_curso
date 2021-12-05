import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  Future<void> auth() async {
    await httpClient.request(url: url);
  }

  RemoteAuthentication({
    required this.httpClient,
    required this.url
  });
}

abstract class HttpClient {
  Future<void> request({
    required String url,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call http client with correct URL', () async {
    // AAA => Arrange, act and assert
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    print(url);
    final sut = RemoteAuthentication(httpClient: httpClient, url: url); // sut = system under test

    await sut.auth();

    verify(httpClient.request(url: url));
  });
}
