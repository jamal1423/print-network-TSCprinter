// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:print_network/printer_service.dart';
import 'package:print_network/tsc_command.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrinterScreen(),
    );
  }
}

class PrinterScreen extends StatefulWidget {
  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  final PrinterService printerService = PrinterService(ipAddress: '10.10.100.200', port: 9100);
  // final PrinterService printerService = PrinterService(ipAddress: '10.16.46.21', port: 9100);
  TSCPrinter? tscPrinter;

  // String text = "KODE BARANG : 9999\nDESKRIPSI : KARUNG PLASTIK\nBERAT : 56.3 Kg\nJML BAL : 1 bal";
  String longText = 'WOVEN BAG DEPAN LAMINASI1SISI OPP CAKRA PANDAWA K12 50KG BELAKANG FLEXO /INN 2S2W';
  String ukuran = "060x090";

  @override
  void initState() {
    super.initState();
    tscPrinter = TSCPrinter(printerService);
  }
  
  List<String> wrapText(String text, int maxLength) {
    List<String> lines = [];
    int start = 0;
    while (start < text.length) {
      int end = (start + maxLength < text.length) ? start + maxLength : text.length;
      lines.add(text.substring(start, end));
      start += maxLength;
    }
    return lines;
  }

  List<String> splitTextIntoThreeParts(String text) {
    List<String> words = text.split(' ');

    int totalWords = words.length;
    int firstSplit = (totalWords / 3).round();
    int secondSplit = (2 * totalWords / 3).round();

    String part1 = words.sublist(0, firstSplit).join(' ');
    String part2 = words.sublist(firstSplit, secondSplit).join(' ');
    String part3 = words.sublist(secondSplit).join(' ');

    return [part1, part2, part3];
  }

  void printTestLabel() {
    // List<String> wrappedText1 = wrapText('WOVEN BAG DEPAN LAMINASI1SISI OPP CAKRA PANDAWA K12 50KG BELAKANG FLEXO /INN 2S2W', 35);
    
    List<String> result = splitTextIntoThreeParts(longText);

    tscPrinter?.printLabel('TEXT 50,90,"3",0,1,1,"No.BT : 240000149520"',
    'QRCODE 50,150,M,6,M,0,M2,"240000149520"',
    'TEXT 200,150,"3",0,1,1,"${result[0].toString()}"',
    'TEXT 200,180,"3",0,1,1,"${result[1].toString()}"',
    'TEXT 200,210,"3",0,1,1,"${result[2].toString()} $ukuran"',
    'TEXT 50,290,"3",0,1,1,"PT. FERTILIZER INTI TECHNOLOGY"',
    'TEXT 50,320,"3",0,1,1,"JAWA TIMUR 61151 500 LBR 81.4 KG"');
  }

  @override
  void dispose() {
    tscPrinter?.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TSC P200 Printer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await tscPrinter?.initializePrinter();
            printTestLabel();
          },
          child: Text('Print Test Label'),
        ),
      ),
    );
  }
}
