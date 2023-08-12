import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf(final PdfPageFormat format) async {
  final pdf = pw.Document(
    title: 'TEST PDF',
  );
  final pageTheme = await _myPageTheme(format);
  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (final context) => [
        pw.Container(
          padding: const pw.EdgeInsets.only(
            left: 30,
            bottom: 20,
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 20),
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('CAMPO 1'),
                      pw.Text('CAMPO 2'),
                      pw.Text('COMPO 3'),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  return pdf.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm,
      vertical: 0.5 * PdfPageFormat.cm,
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Opacity(
          opacity: 0.5,
        ),
      ),
    ),
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Document printed successfully'),
    ),
  );
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Document shared successfully'),
    ),
  );
}
