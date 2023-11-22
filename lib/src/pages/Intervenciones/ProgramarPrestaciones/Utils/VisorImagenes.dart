import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';

class VisorImagenes extends StatelessWidget {
  final List<Archivo> imagenes;

  const VisorImagenes({super.key, required this.imagenes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagenes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Image.network(
            '${AppConfig.backendsismonitor}/storage/${imagenes[index].directorio}',
             fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1200px-Imagen_no_disponible.svg.png");
            },
          ),
        );
      },
    );
  }
}
