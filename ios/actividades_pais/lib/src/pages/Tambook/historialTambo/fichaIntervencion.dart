import 'dart:typed_data';

import 'package:actividades_pais/src/pages/widgets/pdf/util_pdf.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class FichaIntervencion extends StatefulWidget {
  int idIntervencion = 0;
  String fechaEjecucion = '';

  FichaIntervencion(this.idIntervencion, this.fechaEjecucion, {super.key});

  @override
  State<FichaIntervencion> createState() => _FichaIntervencionState();
}

class _FichaIntervencionState extends State<FichaIntervencion> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  //var file = File('');
  //String porcentaje = "";
  late String pdfFilePath = "";
  String porcentaje = '0';

  Future<Uint8List> _downloadPDF(String idIntervencion) async {
    final url =
        '${AppConfig.backendsismonitor}/reportesintervenciones/exportar-ficha-pdf?data=$idIntervencion';
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
          'INTERVENCION - ${widget.idIntervencion.toString()}',
        ),
        backgroundColor: rojo,
      ),
      body: FutureBuilder<Uint8List>(
        future: _downloadPDF(widget.idIntervencion.toString()),
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
            return const Center(
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