import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// 인증 토큰을 제공하는 함수. HTTP 요청 시 인증 헤더에 사용
typedef TokenProvider = Future<String?> Function();

class ApiClient {
  // 아래를 보면 API 클라이언트 생성자가 2개임(쉽게 사용하기 분기처리)
  // 하나는 토큰 제공자를 받아서 사용하는 생성자
  // 다른 하나는 토큰 제공자와 기본 URL을 받아서 사용하는 생성자

  // API 클라이언트 생성자1
  ApiClient({
    required TokenProvider tokenProvider,
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'http://localhost:8080',  // API 요청을 위한 기본 URL
          tokenProvider: tokenProvider, // 인증 토큰을 제공하는 함수
          httpClient: httpClient, // HTTP 클라이언트(외부에서 주입)
        );

  // API 클라이언트 생성자2
  ApiClient._({
    required TokenProvider tokenProvider,
    required String baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _tokenProvider = tokenProvider;

  final TokenProvider _tokenProvider;
  final String _baseUrl;
  final http.Client _httpClient;

  // 특정 채팅방 ID를 인자로 받아, 해당 채팅방의 메시지들을 가져오는 HTTP GET 요청을 수행
  Future<Map<String, dynamic>> fetchMessages(String chatRoomId) async {
    final uri = Uri.parse('$_baseUrl/chat-rooms/id/$chatRoomId/messages');
    final response = await _handleRequest(
        (headers) => _httpClient.get(uri, headers: headers));
    return response;
  }

  // HTTP 요청을 실행하고 응답을 처리하는 공통 로직을 캡슐화
  Future<Map<String, dynamic>> _handleRequest(
    Future<http.Response> Function(Map<String, String>) request,
  ) async {
    try {
      final headers = await _getRequestHeaders(); // 인증 토큰을 포함한 요청 헤더를 생성
      final response = await request(headers); // HTTP 요청을 실행
      final body = jsonDecode(response.body); // 응답 본문을 JSON으로 디코딩

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('${response.statusCode}, error: ${body['message']}');
      }

      return body;
    } on TimeoutException {
      throw Exception('Request timeout. Please try again');
    } catch (err) {
      throw Exception('Unexpected error: $err');
    }
  }

  // 인증 토큰을 포함한 요청 헤더를 생성
  // Content-Type과 Accept 헤더는 application/json으로 설정되고,
  // 사용 가능한 경우 인증 토큰이 Authorization 헤더에 추가
  Future<Map<String, String>> _getRequestHeaders() async {
    final token = await _tokenProvider();

    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
