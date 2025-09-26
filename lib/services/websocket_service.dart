import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../features/tasks/data/models/task_model.dart';

class WebSocketService {
  final String wsUrl;
  WebSocketChannel? _channel;

  final StreamController<List<Map<String, dynamic>>> _taskController = StreamController.broadcast();

  WebSocketService(this.wsUrl);

  Stream<List<Map<String, dynamic>>> get taskStreamController => _taskController.stream;

  void connect() {
    _channel ??= WebSocketChannel.connect(Uri.parse(wsUrl));
    _channel!.stream.listen((message) {
      final data = json.decode(message) as List<dynamic>;
      _taskController.add(data.map((e) => e as Map<String, dynamic>).toList());
    });
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _taskController.close();
  }
}
