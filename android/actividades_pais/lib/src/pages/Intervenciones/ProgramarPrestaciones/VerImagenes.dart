import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Utils/VisorImagenes.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';

class VerImagenes extends StatefulWidget {
  String idProgramacion='';
  VerImagenes({super.key, required this.idProgramacion});
  @override
  State<VerImagenes> createState() => _VerImagenesState();
}

class _VerImagenesState extends State<VerImagenes> {
  final List<Archivo> archivos = [];
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    traerImagenes();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.primaryColor,
          centerTitle: true,
          title: const Text('IMAGENES DE LA INTERVENCION'),
        ),
        body: VisorImagenes(imagenes: archivos),
      );
  }

  traerImagenes() async {
    var respuesta = await ProviderRegistarInterv().getListaImagenes(widget.idProgramacion);
    archivos.addAll(respuesta);
    setState(() {});
  }
}
