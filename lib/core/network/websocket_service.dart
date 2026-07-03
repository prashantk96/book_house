import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  Stream get stream => _channel!.stream;

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void send(String message) {
    _channel?.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
