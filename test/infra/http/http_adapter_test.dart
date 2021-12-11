import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'http_adapter_test.mocks.dart';

// class ClientSpy extends Mock implements Client {}

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void>? request({
    required String url,
    required String method,
    Map? body
  }) async {
    await client.post(Uri.parse(url), body: null, headers: null, encoding: null);
  }
}

@GenerateMocks([], customMocks: [MockSpec<Client>(as: #ClientSpy)])
void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      when(client.post(Uri.parse(url), body: anyNamed('body'), headers: anyNamed('headers'), encoding: anyNamed('encoding')))
        .thenAnswer((_) => Future.value(Response('', 200)));
      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url), body: null, headers: null, encoding: null));
    });
  });
}
