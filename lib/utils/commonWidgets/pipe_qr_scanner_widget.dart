import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PipeQRScannerWidget extends StatefulWidget {
  const PipeQRScannerWidget({super.key});

  @override
  State<PipeQRScannerWidget> createState() => _PipeQRScannerWidgetState();
}

class _PipeQRScannerWidgetState extends State<PipeQRScannerWidget> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [BarcodeFormat.qrCode],
  );

  bool _isScanned = false;
  bool _isProcessing = false;
  String _scannedData = '';

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = EnvironmentConfig.of(context)!.primaryTheme;
    final double boxSize =
    (MediaQuery.of(context).size.width * 0.7).clamp(150.0, 300.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Pipe Code'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _scannerController.toggleTorch(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ================================================================
            // Pipe CAMERA
            // ================================================================
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MobileScanner(
                    controller: _scannerController,
                    onDetect: _onDetect,
                  ),

                  // Scan frame
                  Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: primary, width: 4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // Instruction
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Point camera at Pipe code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================================================================
            // BOTTOM PANEL
            // ================================================================
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    if (_isScanned) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          border: Border.all(color: Colors.green, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Pipe Code scanned successfully',
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (_isScanned && !_isProcessing)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _autoLoadAndClose,
                              icon: const Icon(Icons.check),
                              label: const Text('Auto Load'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _resetScanner,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Scan Again'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (_isProcessing)
                      _infoBox(
                        primary: primary,
                        leading: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        text: 'Loading data... please wait',
                      )
                    else
                      _infoBox(
                        primary: primary,
                        leading: Icon(Icons.info, color: primary),
                        text: 'Scan Pipe code to load data',
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox({
    required Color primary,
    required Widget leading,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        border: Border.all(color: primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading,
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // SCAN
  // ==========================================================================
  Future<void> _onDetect(BarcodeCapture capture) async {
    if (!mounted || _isScanned) return;

    final code =
    capture.barcodes.isNotEmpty ? capture.barcodes.first.rawValue : null;
    if (code == null || code.trim().isEmpty) return;

    setState(() {
      _scannedData = code.trim();
      _isScanned = true;
    });

    await _scannerController.stop();
    developer.log('✓ Pipe Code scanned: $_scannedData', name: 'Pipe_CAMERA');

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pipe Code scanned! Tap Auto Load'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _resetScanner() async {
    setState(() {
      _scannedData = '';
      _isScanned = false;
      _isProcessing = false;
    });
    await _scannerController.start();
  }

  // ==========================================================================
  // AUTO LOAD AND CLOSE
  // ==========================================================================
  Future<void> _autoLoadAndClose() async {
    if (_scannedData.isEmpty) return;

    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 300));

    dynamic parsedData;
    try {
      parsedData = jsonDecode(_scannedData);
    } catch (_) {
      // Plain text Pipe, e.g. "Pipe id:12|Pipe:PN12"
      parsedData = _scannedData;
    }

    if (!mounted) return;
    Navigator.pop(context, parsedData);
  }
}