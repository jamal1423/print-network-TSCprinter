import 'package:print_network/printer_service.dart';

class TSCPrinter {
  final PrinterService _printerService;

  TSCPrinter(this._printerService);

  Future<void> initializePrinter() async {
    await _printerService.connect();
  }// Print 1 copy
  void printLabel(String txt1, String qrcode, String txt2, String txt3, String txt4, String txt5, String txt6) {
    String command = '''
      SIZE 4,2\r\n
      GAP 0 mm,3 mm\r\n
      DENSITY 12\r\n
      DIRECTION 1\r\n
      REFERENCE 0,0\r\n
      CLS\r\n
      $txt1\r\n
      $qrcode\r\n
      $txt2\r\n
      $txt3\r\n
      $txt4\r\n
      $txt5\r\n
      $txt6\r\n
      PRINT 1\r\n
    ''';
    _printerService.sendCommand(command);
  }
  // void printLabel(String labelData) {
  //   String command = '''
  //     SIZE 4,2
  //     GAP 0,0
  //     DENSITY 8
  //     DIRECTION 1
  //     REFERENCE 0,0
  //     CLS
  //     $labelData
  //     SPEED 4
  //     SET TEAR OFF
  //     PRINT 1
      
  //   ''';
  //   _printerService.sendCommand(command);
  // }

  void closeConnection() {
    _printerService.disconnect();
  }
}
