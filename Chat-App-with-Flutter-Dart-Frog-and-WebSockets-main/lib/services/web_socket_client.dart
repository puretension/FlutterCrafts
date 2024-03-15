import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

// 중요한건 sink를 통해 서버로 데이터 전송,
// broadcast 스트림을 통해 서버로부터 데이터 수신 및 처리하는 방식

// WebSocket 클라이언트 클래스
class WebSocketClient {
  IOWebSocketChannel? channel;  // WebSocket 채널 인스턴스

  // 메시지를 관리할 StreamController
  late StreamController<Map<String, dynamic>> messageController;

  WebSocketClient() {
    _initializeControllers(); // 스트림 컨트롤러를 초기화
  }

  void _initializeControllers() {
    // 생성된 스트림이 여러 리스너에 의해 동시에 수신될 수 있도록
    // broadcast를 사용하여 스트림을 생성
    // 같은 데이터 피드를 여러 위젯에서 동시에 수신해야 하는 상황에 유용
    messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect(
    String url, // 연결할 WebSocket 서버의 URL
    Map<String, String> headers, // 연결 시 사용할 HTTP 헤더
  ) {
    // 이미 연결되어 있다면 추가 연결을 시도하지 않는다
    if (channel != null && channel!.closeCode == null) {
      debugPrint('Already connected');
      return;
    }

    debugPrint('Connecting to the server...');
    // 연결된게 없다면 주어진 URL과 헤더로 새 WebSocket 채널을 생성
    channel = IOWebSocketChannel.connect(url, headers: headers);

    // 채널의 스트림을 수신 대기하며, 수신된 메시지를 처리
    channel!.stream.listen(
      (event) {
        // 수신된 메시지를 JSON으로 디코드
        Map<String, dynamic> message = jsonDecode(event);

        // 메시지 유형에 따라 적절한 동작을 수행
        if (message['event'] == 'message.created') {
          messageController.add(message['data']);
        }
        // 필요에 따라 다른 이벤트 처리를 추가
      },
      // 연결이 종료될 때 호출
      onDone: () {
        debugPrint('Connection closed');
      },
      // 오류 발생 시 호출
      onError: (error) {
        debugPrint('Error: $error');
      },
    );
  }

  // 서버로 데이터를 전송하는 메서드
  void send(String data) {
    // 연결이 활성화되지 않았다면 메시지를 전송하지 않는다
    if (channel == null || channel!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    // channel의 sink를 통해 서버로 메시지를 전송
    channel!.sink.add(data);
  }

  Stream<Map<String, dynamic>> messageUpdates() {
    return messageController.stream;
  }


  // WebSocket 연결을 종료하는 메서드
  void disconnect() {
    // 연결이 활성화되지 않았다면 종료 작업을 수행하지 않는다
    if (channel == null || channel!.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    // channel의 sink를 닫아 서버와의 연결을 종료
    channel!.sink.close();
    messageController.close();
    _initializeControllers();
  }
}
