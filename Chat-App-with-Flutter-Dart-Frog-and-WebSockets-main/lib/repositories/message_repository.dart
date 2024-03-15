import 'dart:async';
import 'dart:convert';

import 'package:models/models.dart';

import '../services/api_client.dart';
import '../services/web_socket_client.dart';

class MessageRepository {
  // apiClient: 서버와 HTTP 통신을 담당하는 클라이언트
  final ApiClient apiClient;
  // webSocketClient: 실시간 통신을 위한 WebSocket 클라이언트
  final WebSocketClient webSocketClient;
  // _messageSubscription: WebSocket을 통한 메시지 업데이트의 구독을 관리하는 StreamSubscription 인스턴스
  StreamSubscription? _messageSubscription;

  // 필수적으로 ApiClient(HTTP서버 통신용) 와 WebSocketClient 인스턴스(소켓 통신용)를 받아야 한다.
  MessageRepository({
    required this.apiClient,
    required this.webSocketClient,
  });

  // Message 객체를 JSON 형태로 인코딩하여 WebSocket을 통해 서버로 전송
  Future<void> createMessage(Message message) async {
    // final payload = "{'message.create': ${message.toJson()}";
    // webSocketClient.send(payload);
    var payload = {'event': 'message.create', 'data': message.toJson()};
    webSocketClient.send(jsonEncode(payload));
  }

  //주어진 채팅방 ID에 대한 메시지들을 서버로부터 가져온다.
  Future<List<Message>> fetchMessages(String chatRoomId) async {
    final response = await apiClient.fetchMessages(chatRoomId);
    final messages = response['messages']
        .map<Message>((message) => Message.fromJson(message))
        .toList();

    return messages;
  }

  // TODO: Subscribe only to the current chat room.
  //WebSocket을 통해 실시간 메시지 업데이트를 구독
  void subscribeToMessageUpdates(
    void Function(Map<String, dynamic>) onMessageReceived,
  ) {
    _messageSubscription = webSocketClient.messageUpdates().listen(
      (message) {
        onMessageReceived(message);
      },
    );
  }

  void unsubscribeFromMessageUpdates() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }
}
