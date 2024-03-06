import 'package:flutter/material.dart';
import 'package:qrcode_component/qr_code.dart'; // Replace 'your_package_name' with the actual name of your package

class MyQRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Example'),
      ),
      body: Center(
        child: QRCodeComponent(
          qrdata: 'Your QR Code Data Here', // Provide the data for the QR code
          qrCodeURL: (SafeUrl url) {
            // Handle the generated QR code URL here
            print('QR Code URL: $url');
          },
          // You can customize other properties here as needed
        ),
      ),
    );
  }
}
