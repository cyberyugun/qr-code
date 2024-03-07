import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrcode_component/qr_code.dart';
import 'package:qrcode_component/qr_code.dart';

void main() {
  testWidgets('QRCodeComponent renders correctly', (WidgetTester tester) async {
    // Build the QRCodeComponent widget
    await tester.pumpWidget(
      QRCodeComponent(
        qrdata: 'https://example.com',
        qrCodeURL: (SafeUrl url) {},
      ),
    );

    // Verify that the QR code is rendered
    expect(find.byType(CustomPaint), findsOneWidget);
  });

  testWidgets('QRCodeComponent with image overlay renders correctly', (WidgetTester tester) async {
    // Build the QRCodeComponent widget with an image overlay
    await tester.pumpWidget(
      QRCodeComponent(
        qrdata: 'https://example.com',
        qrCodeURL: (SafeUrl url) {},
        imageSrc: 'assets/logo.png',
      ),
    );

    // Verify that the QR code with image overlay is rendered
    expect(find.byType(CustomPaint), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('QRCodeComponent emits correct SafeUrl', (WidgetTester tester) async {
    // Initialize variables to store emitted SafeUrl
    SafeUrl? emittedUrl;

    // Build the QRCodeComponent widget
    await tester.pumpWidget(
      QRCodeComponent(
        qrdata: 'https://example.com',
        qrCodeURL: (SafeUrl url) {
          emittedUrl = url;
        },
      ),
    );

    // Verify that the SafeUrl is emitted correctly
    expect(emittedUrl, isNotNull);
    // Add further verification if needed
  });
}