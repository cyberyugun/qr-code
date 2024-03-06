import 'package:flutter/material.dart';
import 'package:qrcode_component/qr_code.dart';

class MyQRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Example'),
      ),
      body: Center(
        child: QRCodeComponent(
          qrdata: 'Your QR Code Data Here',
          qrCodeURL: (SafeUrl url) {
            print('QR Code URL: $url');
          },
        ),
      ),
    );
  }
}
