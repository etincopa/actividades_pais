import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/util/throw-exception.dart';

class ListViewProgramacion extends StatelessWidget {
  ListViewProgramacion({
    Key? key,
    required this.context,
    required this.oProgramacion,
  }) : super(key: key);

  final BuildContext context;
  final ProgramacionActividadModel oProgramacion;

  final MainController mainController = MainController();

  void sendProgramaIntervencion() async {
    try {
      var aProg = await mainController.getAllProgramacion(
          oProgramacion.idProgramacionIntervenciones!, 0, 0);

      List<ProgramacionActividadModel> aError =
          await mainController.sendProgramaIntervencion(aProg);
      if (aError.isNotEmpty) {
        mostrarAlerta(
          context,
          'Error!',
          'Existen documentos que no se puedieron enviar, verifique que todo los datos sean correctos.',
        );
      } else {
        mostrarAlerta(
          context,
          'Success!',
          'Se enviaron los registros correctamente.',
        );
      }
    } catch (oError) {
      var sTitle = "Alerta";
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage = oError.msg!;
      }
      mostrarAlerta(
        context,
        sTitle,
        sMessage,
      );
    }
  }

  Color getColorByStatus(String estado) {
    Color c = Colors.green;
    switch (estado) {
      case ProgramacionActividadModel.sEstadoINC:
        c = const Color.fromARGB(255, 255, 115, 96);
        break;
      case ProgramacionActividadModel.sEstadoPEN:
        c = const Color.fromARGB(249, 255, 152, 0);
        break;
      case ProgramacionActividadModel.sEstadoENV:
        c = Colors.green;
        break;
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = '4495FF';
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
              child: Chip(
            label: Text(oProgramacion.estadoProgramacion!),
            backgroundColor:
                getColorByStatus(oProgramacion.estadoProgramacion!),
            labelStyle: const TextStyle(color: Colors.white),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            oProgramacion.programacionActividades!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            oProgramacion.fecha!,
                            style: TextStyle(
                              color: Colors.grey[500],
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
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (oProgramacion.estadoProgramacion !=
                        ProgramacionActividadModel.sEstadoENV)
                      GestureDetector(
                        onTap: () async {
                          sendProgramaIntervencion();
                        },
                        child: AnimatedContainer(
                          height: 35,
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color: Color(
                              int.parse('0xff$experienceLevelColor'),
                            ).withAlpha(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.cloud_upload_rounded,
                              color: Color.fromARGB(255, 38, 173, 108),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  oProgramacion.idProgramacionIntervenciones!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 13, 0, 255),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
