import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DetalleEquipo extends StatefulWidget {
  ListaEquipoInformatico listaEquipoInformatico;

  DetalleEquipo(this.listaEquipoInformatico, {super.key});

  @override
  State<DetalleEquipo> createState() => _DetalleEquipoState();
}

class _DetalleEquipoState extends State<DetalleEquipo> {
  final bool _loaded = false;
  var img = Image.network(
      'https://www.pais.gob.pe/backendsismonitor/public/storage/null');
  var placeholder = const AssetImage('assets/paislogo.png');
  var respuetaImgen = '0';
  Dio dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaImagen();
  }

  cargaImagen() async {
    respuetaImgen = await ProviderSeguimientoParqueInformatico()
        .consultaEquipo(widget.listaEquipoInformatico.idEquipoInformatico);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 20, top: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ESTADO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 102),
                    Text("ACTIVO")
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "CODIGO PATRIMONIAL :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text("${widget.listaEquipoInformatico.codigoPatrimonial}")
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "FECHA DE INGRESO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 28),
                    Text("${widget.listaEquipoInformatico.fecIngreso}")
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "MARCA :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 105),
                    Text("${widget.listaEquipoInformatico.descripcionMarca}")
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "COLOR :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 110),
                    Text("${widget.listaEquipoInformatico.color}")
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "DENOMINACION :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionEquipoInformatico}",
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "TIPO EQUIPO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 70),
                    SizedBox(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionTipoEquipoInformatico}",
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "MODELO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 97),
                    SizedBox(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionModelo}",
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "NRO SERIE :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 89),
                    SizedBox(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.serie}",
                        ))
                  ],
                ),
                const SizedBox(height: 15),
                if (respuetaImgen != '0') ...[
                  Image.network(
                      '${AppConfig.backendsismonitor}/storage/$respuetaImgen')
                ],
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
