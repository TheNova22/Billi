import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanner extends StatefulWidget {
  QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Future save(data) async {
    final prefs = await SharedPreferences.getInstance();
    final String? logs = prefs.getString('logs');
    String date = DateFormat.yMd().format(DateTime.now());
    if (logs == null) {
      Map deets = {
        date: [data]
      };
      await prefs.setString('logs', jsonEncode(deets));
    } else {
      final deets = jsonDecode(logs);
      if (deets.containsKey(date)) {
        deets[date]!.add(data);
      } else {
        deets[date] = [data];
      }
      await prefs.setString('logs', jsonEncode(deets));
    }
  }

  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              save(code).then((value) {
                print("saved");
              });
            }));
  }
}
