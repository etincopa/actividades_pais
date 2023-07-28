import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/report_dto.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class ReportProjectPage extends StatelessWidget {
  final ReportDto dataPdf;
  const ReportProjectPage({
    Key? key,
    required this.dataPdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        dataPdf.name,
        context: context,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              child: _createDataTable(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(dataPdf: dataPdf),
            ),
          );
          // rootBundle.
        },
        child: const Icon(Icons.picture_as_pdf),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text(
          'N°',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'CUI',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'DEPARTAMENTO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'PROVINCIA',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'DISTRITO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'CC.PP',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'AVANCE FÍSICO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'ESTADO',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createRows() {
    return dataPdf.items.map((o) {
      String idx = (dataPdf.items.indexOf(o) + 1).toString();
      return DataRow(
        cells: [
          DataCell(
            Text(
              idx,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.cui ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.departamento ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.provincia ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.distrito ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.tambo ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              "${((double.parse(o.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          DataCell(
            Text(
              o.estado ?? '',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
