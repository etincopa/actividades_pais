import 'dart:io';

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

class FichaIntervencion extends StatefulWidget {
  int idIntervencion = 0;
  String fechaEjecucion = '';

  FichaIntervencion(this.idIntervencion, this.fechaEjecucion);

  @override
  State<FichaIntervencion> createState() => _FichaIntervencionState();
}

class _FichaIntervencionState extends State<FichaIntervencion> {
  var file = File('');
  String porcentaje = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppConfig.primaryColor,
            title: const Text("REPORTE DE ACTIVIDADES"),
            actions: [
              InkWell(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download),
                        Text('$porcentaje %')
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                onTap: () async {
                  await downloadPDF(widget.idIntervencion.toString());
                },
              )
            ]),
        body: Center(
            child: PDF(
          preventLinkNavigation: true,
          fitEachPage: true,
          pageSnap: true,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: false,
          swipeHorizontal: true,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onLinkHandler: (uri) {
            print(uri);
          },
        ).cachedFromUrl(
          'https://www.pais.gob.pe/backendsismonitor/public/reportesintervenciones/exportar-ficha-pdf?data=${widget.idIntervencion}',
          maxAgeCacheObject: const Duration(days: 30), //duration of cache
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),),
        )));
  }

  _displaySnackBar(BuildContext context, mensaje, {call}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$mensaje'),
        /* action: SnackBarAction(
          label: 'Action',
          onPressed: call,
        ),*/
      ),
    );
  }

  Future<void> saveFile(String fileName) async {
    var file = File('');

    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$fileName');
    }
    if (Platform.isAndroid) {
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      file = File('${dir.path}/$fileName');
    }
  }

  Future<void> downloadPDF(String idIntervencion) async {
    BusyIndicator.show(context);

    var status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
      setState(() {});
    }
    final directory = await DownloadsPath.downloadsDirectory();

    final DateTime now = DateTime.now();
    final String timestamp =
        '${widget.fechaEjecucion}_${now.hour}${now.minute}${now.second}';
    final String pdfFilePath =
        '${directory!.path}/${idIntervencion}_$timestamp.pdf';

    if (await File(pdfFilePath).exists()) {
      await File(pdfFilePath).delete();
    }

    if (status.isGranted) {
      try {
        var dio = Dio();
        await dio.download(
          'https://www.pais.gob.pe/backendsismonitor/public/reportesintervenciones/exportar-ficha-pdf?data=$idIntervencion',
          pdfFilePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
            if (totalBytes != -1) {
              porcentaje =
                  (receivedBytes / totalBytes * 100).toStringAsFixed(0);
              setState(() {});
            }
          },
        );

        _displaySnackBar(
            context, "PDF descargado y guardado en la carpeta de descargas.",
            call: () async {
/*   final result = await OpenFile.open(pdfFilePath);
              print(result.message);*/
        });
        BusyIndicator.hide(context);
      } catch (e) {
        BusyIndicator.hide(context);
        _displaySnackBar(context, 'Error al descargar el PDF: $e');
        print('Error al descargar el PDF: $e');
      }
    }
  }
}
