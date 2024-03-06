import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

class QRCodeComponent extends StatefulWidget {
  final bool allowEmptyString;
  final elementType;
  final Color colorDark;
  final Color colorLight;
  final String? cssClass;
  final int errorCorrectionLevel;
  final String? imageSrc;
  final int? imageHeight;
  final int? imageWidth;
  final int margin;
  late final String qrdata;
  final int scale;
  late final int? version;
  final int width;
  final String? alt;
  final String? ariaLabel;
  final String? title;
  final Function(SafeUrl) qrCodeURL;

  QRCodeComponent({
    this.allowEmptyString = false,
    this.elementType = 'canvas',
    this.colorDark = Colors.black,
    this.colorLight = Colors.white,
    this.cssClass,
    this.errorCorrectionLevel = QrErrorCorrectLevel.M,
    this.imageSrc,
    this.imageHeight,
    this.imageWidth,
    this.margin = 4,
    required this.qrdata,
    this.scale = 4,
    this.version,
    this.width = 10,
    this.alt,
    this.ariaLabel,
    this.title,
    required this.qrCodeURL,
  });

  @override
  _QRCodeComponentState createState() => _QRCodeComponentState();
}

class _QRCodeComponentState extends State<QRCodeComponent> {
  late QrCode qrCode;
  late ImageProvider? centerImage;

  @override
  void initState() {
    super.initState();
    generateQRCode();
  }

  void generateQRCode() {
    if (widget.version != null && widget.version! > 40) {
      print("[qrcode] max value for 'version' is 40");
      widget.version = 40;
    } else if (widget.version != null && widget.version! < 1) {
      print("[qrcode]'min value for 'version' is 1");
      widget.version = 1;
    } else if (widget.version != null && widget.version!.isNaN) {
      print(
          "[qrcode] version should be a number, defaulting to auto.");
      widget.version = null;
    }

    if (!isValidQrCodeText(widget.qrdata)) {
      throw ("[qrcode] Field 'qrdata' is empty, set 'allowEmptyString=\"true\"' to overwrite this behaviour.");
    }

    // This is a workaround to allow an empty string as qrdata
    if (isValidQrCodeText(widget.qrdata) && widget.qrdata.isEmpty) {
      widget.qrdata = " ";
    }

    qrCode = QrCode(
      widget.errorCorrectionLevel,
      widget.version ?? 24,
    );
    qrCode.addData(widget.qrdata);
    // qrCode.make();
    if (widget.imageSrc != null) {
      centerImage = AssetImage(widget.imageSrc!);
    }
  }

  bool isValidQrCodeText(String? data) {
    if (widget.allowEmptyString == false) {
      return !(data == null || data.isEmpty || data == "null");
    }
    return !(data == null);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.elementType) {
      case "canvas":
        print("canvas");
        return CustomPaint(
          size: Size(widget.width.toDouble(), widget.width.toDouble()),
          painter: QRCodePainter(
            qrCode: qrCode,
            colorDark: widget.colorDark,
            colorLight: widget.colorLight,
            margin: widget.margin,
            scale: widget.scale,
            centerImage: centerImage,
            imageHeight: widget.imageHeight,
            imageWidth: widget.imageWidth,
            alt: widget.alt,
            ariaLabel: widget.ariaLabel,
            title: widget.title,
            qrCodeURL: widget.qrCodeURL,
          ),
        );
      case "svg":
        print("svg");
      // Generate SVG QR code
      // Use qr_flutter or another library to generate SVG QR code
      // Example:
      // final svgString = await qrImage.svgString();
      // Render SVG element
      // svgString can be directly embedded in SVG widget
        break;
      case "url":
      case "img":
      default:
        print("default");
        break;
    }
    return Container();
  }
}

class QRCodePainter extends CustomPainter {
  final QrCode qrCode;
  final Color colorDark;
  final Color colorLight;
  final int margin;
  final int scale;
  final ImageProvider? centerImage;
  final int? imageHeight;
  final int? imageWidth;
  final String? alt;
  final String? ariaLabel;
  final String? title;
  final Function(SafeUrl) qrCodeURL;

  QRCodePainter({
    required this.qrCode,
    required this.colorDark,
    required this.colorLight,
    required this.margin,
    required this.scale,
    required this.centerImage,
    required this.imageHeight,
    required this.imageWidth,
    required this.alt,
    required this.ariaLabel,
    required this.title,
    required this.qrCodeURL,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    Paint darkPaint = Paint()..color = colorDark;
    Paint lightPaint = Paint()..color = colorLight;

    final int dimension = qrCode.moduleCount * scale + margin * 2;
    final double squareSize = size.shortestSide / dimension;

    for (int x = 0; x < qrCode.moduleCount; x++) {
      for (int y = 0; y < qrCode.moduleCount; y++) {
        // if (qrCode.isDark(y, x)) {
          final Rect rect = Rect.fromLTWH(
            margin + x * squareSize,
            margin + y * squareSize,
            squareSize,
            squareSize,
          );
          print("draw");
          canvas.drawRect(rect, darkPaint);
        // } else {
        //   final Rect rect = Rect.fromLTWH(
        //     margin + x * squareSize,
        //     margin + y * squareSize,
        //     squareSize,
        //     squareSize,
        //   );
        //   canvas.drawRect(rect, lightPaint);
        // }
      }
    }

    if (centerImage != null) {
      centerImage!.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
              (ImageInfo image, bool synchronousCall) {
            final double imageX = (size.width - imageWidth!) / 2;
            final double imageY = (size.height - imageHeight!) / 2;
            canvas.drawImage(
              (image.image),
              Offset(imageX, imageY),
              Paint(),
            );
          },
        ),
      );
    }

    if (title != null) {
      // Add title to canvas
    }

    if (ariaLabel != null) {
      // Add aria label to canvas
    }

    if (alt != null) {
      // Add alt text to canvas
    }

    generateImage(size);
  }

  void generateImage(Size size) async {
    print("generate img start");
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas recorderCanvas = Canvas(recorder);
    paint(recorderCanvas, size);
    final ui.Picture picture = recorder.endRecording();
    final Uint8List pngBytes = await picture.toImage(size.width.floor(), size.height.floor())
        .then((img) => img.toByteData(format: ui.ImageByteFormat.png))
        .then((byteData) => byteData!.buffer.asUint8List());
    final String base64Image = base64Encode(pngBytes);
    final SafeUrl safeUrl = trustedHtml("<img src='data:image/png;base64, $base64Image' alt='${alt ?? ''}' title='${title ?? ''}' />");

    print("generate img end");
    qrCodeURL(safeUrl);
  }

  @override
  bool shouldRepaint(QRCodePainter oldDelegate) {
    return qrCode != oldDelegate.qrCode ||
        colorDark != oldDelegate.colorDark ||
        colorLight != oldDelegate.colorLight ||
        margin != oldDelegate.margin ||
        scale != oldDelegate.scale ||
        centerImage != oldDelegate.centerImage ||
        imageHeight != oldDelegate.imageHeight ||
        imageWidth != oldDelegate.imageWidth ||
        alt != oldDelegate.alt ||
        ariaLabel != oldDelegate.ariaLabel ||
        title != oldDelegate.title;
  }
}

class SafeUrl {}

SafeUrl trustedHtml(String s) {
  print('safe');
  throw UnimplementedError();
}

