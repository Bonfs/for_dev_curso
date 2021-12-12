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

  Future<Map?> request({
    required String url,
    required String method,
    Map? body
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    
    final response = await client.post(
      Uri.parse(url), 
      body: body, 
      headers: headers, 
      encoding: null
    );

    if(response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

@GenerateMocks([], customMocks: [MockSpec<Client>(as: #ClientSpy)])
void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    PostExpectation mockRequest() =>
      when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers'), encoding: anyNamed('encoding')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(
        Uri.parse(url), 
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: {'any_key': 'any_value'},
        encoding: anyNamed('encoding')
      ));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(
        any,
        headers: anyNamed('headers'),
        encoding: anyNamed('encoding')
      ));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
