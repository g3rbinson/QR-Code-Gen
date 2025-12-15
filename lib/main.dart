import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL to QR Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QRCodeGenerator(),
    );
  }
}

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});

  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final TextEditingController _urlController = TextEditingController();
  String _qrData = '';

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _generateQRCode() {
    setState(() {
      _qrData = _urlController.text;
    });
  }

  void _clearQRCode() {
    setState(() {
      _urlController.clear();
      _qrData = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('URL to QR Code'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter a URL to generate QR Code',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'URL',
                  hintText: 'https://example.com',
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _generateQRCode,
                      icon: const Icon(Icons.qr_code),
                      label: const Text('Generate QR Code'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _clearQRCode,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_qrData.isNotEmpty)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: _qrData,
                      version: QrVersions.auto,
                      size: 250.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
