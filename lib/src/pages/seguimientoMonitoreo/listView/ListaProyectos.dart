import 'package:actividades_pais/src/pages/seguimientoMonitoreo/detalleProyecto.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ListaProyectos extends StatelessWidget {
  ListaProyectos({
    Key? key,
    required this.context,
    required this.oProyecto,
  }) : super(key: key);

  final BuildContext context;
  final TramaProyectoModel oProyecto;

  final MainController mainController = MainController();

  Color getColorAvancefisico(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? Colors.blue
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? Colors.green
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? Colors.red
                  : Colors.yellow);
    } catch (oError) {
      return color_01;
    }
  }

  double getAvancefisico(dynamic oProyecto) {
    try {
      return double.parse(oProyecto.avanceFisico.toString());
    } catch (oError) {
      return 1;
    }
  }

  String getAvancefisicoText(dynamic oProyecto) {
    try {
      return "${((double.parse(oProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%";
    } catch (oError) {
      return "NAN %";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetalleProyecto(datoProyecto: oProyecto),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorGB,
          border: Border.all(
            width: 1,
            color: getColorAvancefisico(oProyecto),
          ),
          boxShadow: [
            BoxShadow(
              color: color_04.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircularPercentIndicator(
                          radius: 30.0,
                          lineWidth: 8.0,
                          percent: getAvancefisico(oProyecto),
                          center: Text(
                            getAvancefisicoText(oProyecto),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          progressColor: getColorAvancefisico(oProyecto),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TAMBO ${oProyecto.tambo!}',
                              style: const TextStyle(
                                color: color_01,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${oProyecto.departamento!} / ${oProyecto.provincia!} / ${oProyecto.distrito!}",
                              style: const TextStyle(
                                color: color_04,
                              ),
                            ),
                            Text(
                              oProyecto.fechaTerminoEstimado!,
                              style: const TextStyle(
                                color: color_01,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(oProyecto.estado!),
                  ],
                ),
                const SizedBox(width: 20),
                Text(
                  oProyecto.cui!,
                  style: const TextStyle(
                    color: color_01,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
