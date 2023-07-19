import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRReader2 extends StatefulWidget {
  const QRReader2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRReader2State();
}

class _QRReader2State extends State<QRReader2> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isScan = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, 'キャンセルしました！');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
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
                  switch (state) {
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
        body: SafeArea(
          child: MobileScanner(
            // fit: BoxFit.contain,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _transitionToNextScreen(barcode);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  void _transitionToNextScreen(Barcode barcode) {
    if (!_isScan) {
      cameraController.stop();
      _isScan = true;

      Navigator.pop(context, '読み込んだ値: ${barcode.rawValue}');
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
