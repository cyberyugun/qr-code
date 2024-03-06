# QRCodeComponent

QRCodeComponent is a Flutter widget that allows you to generate QR codes easily within your Flutter applications. It provides various customization options and supports rendering QR codes as canvas, SVG, or image elements.

## Installation

To use this package, add `qrcode_component` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  qrcode_component: ^1.0.0
```


Then, import the package in your Dart code:

```dart
import 'package:qrcode_component/qr_code.dart';
```

## Usage
Simply add the QRCodeComponent widget to your Flutter UI tree and configure it with the desired properties.

```dart
QRCodeComponent(
  qrdata: 'Hello, World!',
  width: 200,
  height: 200,
  colorDark: Colors.black,
  colorLight: Colors.white,
  margin: 4,
  scale: 4,
  allowEmptyString: false,
  errorCorrectionLevel: QRCodeErrorCorrectionLevel.M,
  imageSrc: 'assets/images/logo.png',
  imageHeight: 50,
  imageWidth: 50,
  version: 10,
  alt: 'QR Code',
  ariaLabel: 'QR Code',
  title: 'QR Code',
  qrCodeURL: (url) {
    // Handle the generated QR code URL
    print('Generated QR code URL: $url');
  },
),
```

## Properties
- allowEmptyString: Whether to allow an empty string as input for generating the QR code.
- colorDark: The color of the dark modules in the QR code.
- colorLight: The color of the light modules in the QR code.
- cssClass: Additional CSS class to apply to the QR code container.
- errorCorrectionLevel: The error correction level of the QR code.
- imageSrc: The image source URL or path to overlay on the QR code.
- imageHeight: The height of the overlay image.
- imageWidth: The width of the overlay image.
- margin: The margin around the QR code.
- qrdata: The data to encode in the QR code.
- scale: The scaling factor for the QR code.
- version: The version (size) of the QR code.
- width: The width of the QR code.
- alt: Alternate text for the QR code (for accessibility).
- ariaLabel: ARIA label for the QR code (for accessibility).
- title: Title attribute for the QR code (for accessibility).
- qrCodeURL: Callback function to handle the generated QR code URL.

## Examples

There is a simple, working, example Flutter app in the `/example` directory. You can use it to play with all
the options. 

Also, the following examples give you a quick overview on how to use the library.

A basic QR code will look something like:

```dart
QRCodeComponent(
  qrdata: 'Your QR Code Data Here', // Provide the data for the QR code
  qrCodeURL: (SafeUrl url) {
    // Handle the generated QR code URL here
    print('QR Code URL: $url');
  },
  // You can customize other properties here as needed
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
