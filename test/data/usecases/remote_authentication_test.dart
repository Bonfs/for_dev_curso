import 'package:faker/faker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }

  RemoteAuthentication({
    required this.httpClient,
    required this.url
  });
}

abstract class HttpClient {
  Future<void>? request({
    required String url,
    required String method,
  });
}

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
    await sut.auth();

    verify(httpClient.request(
      url: url,
      method: 'post'
    ));
  });
}
