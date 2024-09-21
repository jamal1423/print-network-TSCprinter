
// ignore_for_file: prefer_const_constructors

import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

Future<void> printToNetworkPrinter(String printerIp) async {
  final profile = await CapabilityProfile.load();
  final printer = NetworkPrinter(PaperSize.mm80, profile);

  final PosPrintResult res = await printer.connect(printerIp, port: 9100);

  if (res == PosPrintResult.success) {
    printer.text(
      'Hello, Printer!',
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    printer.feed(2);
    printer.cut();
    printer.disconnect();
  } else {
    print('Could not connect to printer. Error: $res');
  }
}