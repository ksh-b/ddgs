import 'dart:convert';
import 'package:ddgs/src/http_client.dart';
import 'package:ddgs/src/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mock_http_client.dart';

void main() {
  group('HttpClient', () {
    late MockClient mockClient;
    late HttpClient httpClient;

    setUp(() {
      mockClient = MockClient();
      httpClient = HttpClient(client: mockClient);
      registerFallbackValue(Uri.parse('https://example.com'));
    });

    test('valid GET request returns HttpResponse', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('{"key": "value"}', 200));

      final response = await httpClient.get(Uri.parse('https://example.com'));

      expect(response.statusCode, 200);
      expect(response.body, '{"key": "value"}');
      verify(() => mockClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('adds user agent header', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('ok', 200));

      await httpClient.get(Uri.parse('https://example.com'));

      final captured = verify(() =>
              mockClient.get(any(), headers: captureAny(named: 'headers')))
          .captured;
      final headers = captured.first as Map<String, String>;
      expect(headers, contains('User-Agent'));
      expect(headers['User-Agent'], contains('Mozilla'));
    });

    test('throws DDGSException on client error', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(http.ClientException('Simulated error'));

      expect(() => httpClient.get(Uri.parse('https://example.com')),
          throwsA(isA<DDGSException>()));
    });
  });
}
