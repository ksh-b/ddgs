/// HTTP client for making requests.
library;

import 'dart:async' as async;
import 'package:http/http.dart' as http;
import 'exceptions.dart';

/// HTTP response wrapper.
class HttpResponse {
  HttpResponse({
    required this.statusCode,
    required this.body,
    required this.bodyBytes,
  });
  final int statusCode;
  final String body;
  final List<int> bodyBytes;
}

/// HTTP client with proxy support.
class HttpClient {
  HttpClient({
    this.proxy,
    Duration? timeout,
    this.verify = true,
    http.Client? client,
  }) : timeout = timeout ?? const Duration(seconds: 10) {
    _client = client ?? http.Client();
  }
  final String? proxy;
  final Duration timeout;
  final bool verify;
  late final http.Client _client;

  /// Make an HTTP request.
  Future<HttpResponse> request(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? params,
    dynamic body,
  }) async {
    try {
      // Add query parameters
      if (params != null && params.isNotEmpty) {
        url = url.replace(
          queryParameters: {
            ...url.queryParameters,
            ...params,
          },
        );
      }

      http.Response response;
      final requestHeaders = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        ...?headers,
      };

      switch (method.toUpperCase()) {
        case 'GET':
          response =
              await _client.get(url, headers: requestHeaders).timeout(timeout);
          break;
        case 'POST':
          response = await _client
              .post(url, headers: requestHeaders, body: body)
              .timeout(timeout);
          break;
        default:
          throw DDGSException('Unsupported HTTP method: $method');
      }

      return HttpResponse(
        statusCode: response.statusCode,
        body: response.body,
        bodyBytes: response.bodyBytes,
      );
    } on http.ClientException catch (e) {
      // Includes SocketException wrappers often
      throw DDGSException('HTTP client error: $e');
    } on async.TimeoutException catch (e) {
      throw async.TimeoutException('Request timed out after ${e.duration}');
    } catch (e) {
      // Check for SocketException by string if strict type is gone
      if (e.toString().contains('SocketException')) {
        throw DDGSException('Network error: $e');
      }
      throw DDGSException('Request failed: $e');
    }
  }

  /// Make a GET request.
  Future<HttpResponse> get(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) =>
      request('GET', url, headers: headers, params: params);

  /// Make a POST request.
  Future<HttpResponse> post(
    Uri url, {
    Map<String, String>? headers,
    dynamic body,
  }) =>
      request('POST', url, headers: headers, body: body);

  void close() {
    _client.close();
  }
}
