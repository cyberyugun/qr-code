import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:qr/qr.dart';

class QRCodeComponent extends StatefulWidget {
  final String qrData;
  final double width;
  final double height;
  final Color color;
  final Color backgroundColor;
  final String? imageUrl;
  final String? imageSrc;
  QRCodeComponent({
    Key? key,
    required this.qrData,
    this.width = 200,
    this.height = 200,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    this.imageUrl,
    this.imageSrc,
  }) : super(key: key);

  @override
  _QRCodeComponentState createState() => _QRCodeComponentState();
}

class _QRCodeComponentState extends State<QRCodeComponent> {
  late Future<ui.Image?> _imageFuture;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl != null || widget.imageSrc != null) {
      if (widget.imageUrl != null) {
        _imageFuture = loadImageFromUrl(widget.imageUrl!);
      } else {
        _imageFuture = loadImageFromAsset(widget.imageSrc!);
      }
    } else {
      _imageFuture = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image?>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if ((widget.imageSrc == null || (widget.imageSrc != null && snapshot.data != null)) && (widget.imageUrl == null || (widget.imageUrl != null && snapshot.data != null))) {
          return Container(
            width: widget.width,
            height: widget.height,
            color: widget.backgroundColor,
            child: CustomPaint(
              size: Size(widget.width, widget.height),
              painter: QRCodePainter(widget.qrData, widget.color, widget.backgroundColor, snapshot.data),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<ui.Image?> loadImageFromAsset(String assetPath) {
    Completer<ui.Image?> completer = Completer<ui.Image?>();

    rootBundle.load(assetPath).then((ByteData data) {
      ui.instantiateImageCodec(Uint8List.view(data.buffer)).then((ui.Codec codec) {
        codec.getNextFrame().then((ui.FrameInfo frameInfo) {
          completer.complete(frameInfo.image);
        }).catchError((e) {
          print('Error decoding image: $e');
          completer.completeError(e);
        });
      }).catchError((e) {
        print('Error instantiating image codec: $e');
        completer.completeError(e);
      });
    }).catchError((e) {
      print('Error loading image from asset: $e');
      completer.completeError(e);
    });

    return completer.future;
  }

  Future<ui.Image?> loadImageFromUrl(String url) async {
    try {
      final completer = Completer<ui.Image>();
      final imageStream = NetworkImage(url).resolve(ImageConfiguration());
      imageStream.addListener(ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          completer.complete(info.image);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          print('Error loading image: $exception');
          completer.completeError(exception);
        },
      ));
      return completer.future;
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }
}

class QRCodePainter extends CustomPainter {
  final String qrData;
  final Color color;
  final Color backgroundColor;
  final ui.Image? image;

  QRCodePainter(this.qrData, this.color, this.backgroundColor, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    QrCode qrCode = QrCode(4, QrErrorCorrectLevel.L);
    qrCode.addData(qrData);
    var qrImage = QrImage(qrCode);

    double pixelSize = size.width / qrCode.moduleCount.toDouble();

    Paint paint = Paint()..color = color;

    // Draw QR code pattern
    for (var x = 0; x < qrCode.moduleCount; x++) {
      for (var y = 0; y < qrCode.moduleCount; y++) {
        var isDark = qrImage.isDark(y, x);
        if (isDark) {
          Rect rect = Rect.fromLTWH(x.toDouble() * pixelSize, y.toDouble() * pixelSize, pixelSize, pixelSize);
          canvas.drawRect(rect, paint);
        }
      }
    }

    // Draw image in the center if image is provided and loaded
    if (image != null) {
      drawCenterImage(canvas, size);
    }
  }

  void drawCenterImage(Canvas canvas, Size size) {
    // Calculate position for centering image
    double imageSize = size.width * 0.3;
    double imageX = (size.width - imageSize) / 2;
    double imageY = (size.height - imageSize) / 2;

    // Draw image
    canvas.drawImageRect(
      image!,
      Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble()),
      Rect.fromLTWH(imageX, imageY, imageSize, imageSize),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(QRCodePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(QRCodePainter oldDelegate) => false;
}