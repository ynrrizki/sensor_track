import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  late FocusNode _textInputFocus;
  String _textInput = '';

  @override
  void initState() {
    super.initState();
    _textInputFocus = FocusNode();
  }

  @override
  void dispose() {
    _textInputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Generate QR Code'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: _textInput.isEmpty
                  ? InkWell(
                      onTap: () => _textInputFocus.requestFocus(),
                      radius: 12,
                      child: DottedBorder(
                        color: Colors.white,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        dashPattern: const [6, 6, 6, 6],
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Colors.white10,
                          ),
                          child: const Center(
                            child: Text(
                              'QR CODE',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : QrImageView(
                      data: _textInput,
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      size: 200.0,
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: TextField(
              focusNode: _textInputFocus,
              onChanged: (value) {
                setState(() {
                  _textInput = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Add your qr code with text',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
