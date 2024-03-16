import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcode_component/qr_code.dart'; // Replace 'your_flutter_app' with your app name or path

void main() {
  group('QRCodeComponent', () {
    testWidgets('QR code generation test', (WidgetTester tester) async {
      // Create a test QRCodeComponent widget with sample data
      await tester.pumpWidget(
        MaterialApp(
          home: QRCodeComponent(
            qrData: 'Test data',
          ),
        ),
      );

      // Verify that the CustomPaint widget is present
      expect(find.byType(CustomPaint), findsOneWidget);

      // Get the CustomPaint widget
      final customPaint = tester.widget<CustomPaint>(find.byType(CustomPaint));

      // Get the QRCodePainter from CustomPaint
      final qrCodePainter = customPaint.painter as QRCodePainter;

      // Get the image from the QRCodePainter
      final qrImage = qrCodePainter.image;

      // Verify that the image is not null
      expect(qrImage, isNotNull);

      // Verify that the image is of type ui.Image
      expect(qrImage, isA<ui.Image>());

      // Verify that the image dimensions are correct
      expect(qrImage!.width, 200);
      expect(qrImage.height, 200);

      // Convert the image to ByteData for further verification
      final ByteData? byteData = await qrImage.toByteData(format: ui.ImageByteFormat.png);

      // Verify that ByteData is not null
      expect(byteData, isNotNull);

      // Verify that ByteData contains data
      expect(byteData?.lengthInBytes, greaterThan(0));
    });
  });
}
