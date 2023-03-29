import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;

  PDFViewerScreen({required this.pdfPath});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visor de PDF'),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(

            filePath: widget.pdfPath,
            onPageChanged: (  page,   total) {
              setState(() {
                _currentPage = page!;
                _totalPages = total!;
              });
            },
            onRender: (_pages) {
              setState(() {
                _isLoading = false;
                _totalPages = _pages!;
              });
            },
            onError: (error) {
              setState(() {
                _isLoading = false;
              });
              print(error);
            },
          ),
          _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Offstage(),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Text(
              'Página $_currentPage de $_totalPages',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
