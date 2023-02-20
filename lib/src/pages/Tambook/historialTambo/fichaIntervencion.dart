import 'dart:io';

import 'package:actividades_pais/util/app-config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FichaIntervencion extends StatefulWidget {
  int idIntervencion = 0;

  FichaIntervencion(this.idIntervencion);

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
            title: Text("REPORTE DE ACTIVIDADES"),
            actions: [
              InkWell(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.download), Text(porcentaje)],
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                onTap: () async {
                  const downloadsFolderPath = '/storage/emulated/0/Download/';
                  Directory dir = Directory(downloadsFolderPath);

                  var status = await Permission.storage.status;
                  if (status != PermissionStatus.granted) {
                    status = await Permission.storage.request();
                  }

                  file = File('${dir.path}/${widget.idIntervencion}.pdf');
                  if (file.existsSync()) {
                    await file.delete();
                    setState(() {

                    });
                  }

                  if (status.isGranted) {
                    try {
                      await Dio().download(
                          'https://www.pais.gob.pe/backendsismonitor/public/reportesintervenciones/exportar-ficha-pdf?data=${widget.idIntervencion}',
                          file.path, onReceiveProgress: (received, total) {
                        if (total != -1) {
                          porcentaje =
                              (received / total * 100).toStringAsFixed(0) + "%";
                          setState(() {});
                          print((received / total * 100).toStringAsFixed(0) +
                              "%");

                          //you can build progressbar feature too
                        }
                      });
                      print("File is saved to download folder.");
                    } on DioError catch (e) {
                      print("e.message");
                      print(e.message);
                      print(e.message);
                    }
                  }
                },
              )
            ]),
        /*  try {
                                          await Dio().download(
                                              fileurl,
                                              savePath,
                                              onReceiveProgress: (received, total) {
                                                  if (total != -1) {
                                                      print((received / total * 100).toStringAsFixed(0) + "%");
                                                      //you can build progressbar feature too
                                                  }
                                                });
                                           print("File is saved to download folder.");
                                     } on DioError catch (e) {
                                       print(e.message);
                                     }*/
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
          maxAgeCacheObject: Duration(days: 30), //duration of cache
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),),
        )));
  }

  Future<void> saveFile(String fileName) async {
    var file = File('');

    // Platform.isIOS comes from dart:io
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$fileName');
    }
    if (Platform.isAndroid) {
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      file = File('${dir.path}/$fileName');

      /*   var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {

      }*/
    }
  }
}
//  body: const PDF().cachedFromUrl(
//         url,
//         placeholder: (double progress) => Center(child: Text('$progress %')),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
