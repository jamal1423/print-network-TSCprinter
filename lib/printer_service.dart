import 'dart:io';

class PrinterService {
  final String ipAddress;
  final int port;
  Socket? _socket;

  PrinterService({required this.ipAddress, required this.port});

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(ipAddress, port);
      print('Connected to the printer');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }

  void disconnect() {
    _socket!.close();
    print('Disconnected from the printer');
  }

  void sendCommand(String command) async  {
    _socket!.add(command.codeUnits);
    _socket!.flush();
    // await Future.delayed(const Duration(seconds: 2));
    print('Command sent: $command');
  }
}
