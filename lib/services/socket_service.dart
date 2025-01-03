import 'dart:convert';

import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initialize() {
    socket = IO.io(uri, {
      'transports': 'websocket',
       'autoConnect': false,  // Optional: Auto-connect behavior
    });

    socket.on('connect', (_) {
      print('Connected to the server');
    });

    socket.on('productAvailabilityUpdated', (data) {
      if (data is Map<String, dynamic>) {
        print(
            'Product availability updated: ${data['productId']} - ${data['isAvailable']}');
      } else if (data is String) {
        print('Received data as string: $data');
        // Optionally parse the string if it's in a JSON format
        try {
          var parsedData = jsonDecode(data);
          print('Parsed data: $parsedData');
        } catch (e) {
          print('Error parsing string data: $e');
        }
      } else {
        print('Error: Data format is incorrect');
      }
    });
  }

  void sendMessage(String message) {
    socket.emit('message', message);
  }

  void close() {
    socket.disconnect();
  }
}
