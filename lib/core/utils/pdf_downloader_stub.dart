import 'dart:typed_data';
import 'package:printing/printing.dart';

/// Downloads PDF bytes using the printing package (non-web platforms)
Future<void> downloadPdfBytes(Uint8List bytes, String filename) async {
  await Printing.sharePdf(bytes: bytes, filename: filename);
}

