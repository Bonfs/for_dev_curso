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
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(
      Uri.parse(url), 
      body: body, 
      headers: headers, 
      encoding: null
    );
  }
}

@GenerateMocks([], customMocks: [MockSpec<Client>(as: #ClientSpy)])
void main() {
  late final ClientSpy client;
  late final HttpAdapter sut;
  late final String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    test('Should call post with correct values', () async {
      when(client.post(Uri.parse(url), body: anyNamed('body'), headers: anyNamed('headers'), encoding: anyNamed('encoding')))
        .thenAnswer((_) => Future.value(Response('', 200)));

      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(
        Uri.parse(url), 
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: {'any_key': 'any_value'},
        encoding: null
      ));
    });
  });
}
