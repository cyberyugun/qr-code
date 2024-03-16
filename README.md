# QRCodeComponent

QRCodeComponent is a Flutter widget that allows you to generate QR codes easily within your Flutter applications. It provides various customization options and supports rendering QR codes as canvas, SVG, or image elements.

## Installation

To use this package, add `qrcode_component` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  qrcode_component: ^2.1.0
```


Then, import the package in your Dart code:

```dart
import 'package:qrcode_component/qr_code.dart';
```

## Usage
Simply add the QRCodeComponent widget to your Flutter UI tree and configure it with the desired properties.

```dart
QRCodeComponent(
  qrData: 'Hello, World!',
  width: 200,
  height: 200,
  errorCorrectionLevel: QrErrorCorrectLevel.L,
  color: Colors.black,
  backgroundColor: Colors.white,
  imageUrl: 'assets/images/logo.png',
  imageSrc: 'https://fujifilm-x.com/wp-content/uploads/2021/01/gfx100s_sample_04_thum-1.jpg',
  onStartGenerate: () => {
    print('start')
  },
  onFinishGenerate: () => {
    print('end')
  },
),
```

## Properties
- color: The color of the dark modules in the QR code. // default: black
- backgroundColor: The color of the light modules in the QR code. // default: white
- imageSrc: The image source URL or path from local assets to overlay on the QR code. // default: null
- imageUrl: The image source URL or path from external assets to overlay on the QR code. // default: null
- width: The width of the QR code. // default: 200
- height: The height of the QR code. // default: 200
- qrData: The data to encode in the QR code. // required
- errorCorrectionLevel: The error correction level of the QR code. // default: 1
    static const int L = 1;
    static const int M = 0;
    static const int Q = 3;
    static const int H = 2;
- onStartGenerate: The `onStartGenerate` callback is invoked at the beginning of the QR code generation process.
- onFinishGenerate: The `onFinishGenerate` callback is invoked when the QR code generation process has finished.
- version: The version (size) of the QR code.

## Examples

There is a simple, working, example Flutter app in the `/example` directory. You can use it to play with all
the options. 

Also, the following examples give you a quick overview on how to use the library.

A basic QR code will look something like:

```dart
QRCodeComponent(
  qrData: 'Your QR Code Data Here', // Provide the data for the QR code
)
```

# Outro
## Credits
Thanks to Kevin Moore for his awesome [QR - Dart](https://github.com/kevmoo/qr.dart) library. It's the core of this library.

For author/contributor information, see the `AUTHORS` file.

## Contributing
Contributions are welcome! Please feel free to submit bug reports, feature requests, or pull requests.

## License
This package is licensed under the MIT License. See the `LICENSE` file for details.

You can save this content to a file named README.md in your project directory, and it will be ready to be used as the README file for your Flutter package.
