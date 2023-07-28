import 'dart:typed_data';

import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/report_dto.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';

Future<Uint8List> makePdf(ReportDto oDataPdf) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/paislogo.png')).buffer.asUint8List(),
  );
  List<Widget> widgets = [];

  final font = await PdfGoogleFonts.cairoRegular();

  widgets.add(Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          Text("REPORTE PROYECTOS TAMBO"),
          Text("PAIS"),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      SizedBox(
        height: 140,
        width: 140,
        child: Image(imageLogo),
      )
    ],
  ));

  widgets.add(Container(height: 5));

  const pageSize = 20;
  List<TramaProyectoModel> totalDueList = oDataPdf.items;
  final numberOfPages = (totalDueList.length / pageSize).ceil();

  Map<int, List<TableRow>> rows = {};

  for (var page = 0; page < numberOfPages; page++) {
    rows[page] = [
      TableRow(
        decoration: const BoxDecoration(color: PdfColor.fromInt(0xffff9505)),
        children: [
          centerText('N°'),
          centerText('CUI'),
          centerText('DEPARTAMENTO'),
          centerText('PROVINCIA'),
          centerText('DISTRITO'),
          centerText('CC.PP'),
          centerText('AVANCE FÍSICO'),
          centerText('ESTADO'),
        ],
      )
    ];

    var loopLimit =
        totalDueList.length - (totalDueList.length - ((page + 1) * pageSize));

    if (loopLimit > totalDueList.length) loopLimit = totalDueList.length;

    for (var index = pageSize * page; index < loopLimit; index++) {
      rows[page]!.add(TableRow(
        decoration: const BoxDecoration(color: PdfColor.fromInt(0xffffc971)),
        children: [
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              "${index + 1}",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].cui ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].departamento ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].provincia ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].distrito ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].tambo ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              "${((double.parse(totalDueList[index].avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.5),
            child: Text(
              totalDueList[index].estado ?? "",
              style: TextStyle(font: font, fontSize: 7.5),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ));
    }
  }

  widgets.addAll(List<Widget>.generate(rows.keys.length, (index) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(color: PdfColor.fromHex("#000000")),
          children: rows[index]!,
        ),
      ],
    );
  }));

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          Column(
            children: widgets,
          )
        ];
      },
    ),
  );
  return pdf.save();
}

Widget leftText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        textAlign: align,
      ),
    );

Widget centerText(
  final String text, {
  final TextAlign align = TextAlign.center,
}) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        textAlign: align,
        style: TextStyle(
          fontSize: 7.5,
          color: PdfColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
