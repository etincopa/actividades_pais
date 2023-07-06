import 'dart:io';
import 'dart:typed_data';

import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/util_pdf.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class Informe extends StatefulWidget {
  String path = '';


  Informe(this.path);

  @override
  State<Informe> createState() => _FichaIntervencionState();
}

class _FichaIntervencionState extends State<Informe> {
  @override
  void initState() {
    print("aqyiii");
    // TODO: implement initState

    super.initState();
  }

  //var file = File('');
  //String porcentaje = "";
  late String pdfFilePath = "";
  String porcentaje = '0';

  Future<Uint8List> _downloadPDF(String path) async {
    print( AppConfig.backendsismonitor+'/storage/${path}');

    final url =
        AppConfig.backendsismonitor+'/storage/${path}';
    //http://localhost/backendsismonitor/public/storage/equipo/archivos/4aX90pujWN7ilITfAgZbKqZVSKLy63IabDD8WzjV.pdf
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PDF VIEW ',
        ),
        backgroundColor: AppConfig.primaryColor,
      ),
      body: FutureBuilder<Uint8List>(
        future: _downloadPDF(widget.path),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PdfPreview(
              maxPageWidth: 708,
              onPrinted: showPrintedToast,
              onShared: showSharedToast,
              build: (context) => (snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Descargando archivo...'),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}