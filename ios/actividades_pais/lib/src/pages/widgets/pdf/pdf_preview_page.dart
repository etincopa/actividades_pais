import 'package:actividades_pais/src/pages/widgets/pdf/build_content_pdf.dart';
import 'package:actividades_pais/src/pages/widgets/pdf/report_dto.dart';
import 'package:actividades_pais/src/pages/widgets/pdf/util_pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class PdfPreviewPage extends StatelessWidget {
  final ReportDto dataPdf;
  const PdfPreviewPage({Key? key, required this.dataPdf}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveAsFile,
        )
    ];

    return Scaffold(
      appBar: WidgetCustoms.appBar(
        'VISTA PREVIA DEL REPORTE',
        context: context,
      ),
      body: PdfPreview(
        maxPageWidth: 708,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: (context) => makePdf(dataPdf),
      ),
    );
  }
}
