import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListaTipoGobierno.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/TablaEntidades/AgregarEntidad.dart';
import 'package:flutter/material.dart';

class CrearRegistroEntidad extends StatefulWidget {
 // const CrearRegistroEntidad(bool ismostar, {Key? key}) : super(key: key);
  bool ismostar=false;
  CrearRegistroEntidad( this.ismostar, {super.key});

  @override
  State<CrearRegistroEntidad> createState() => _CrearRegistroEntidadState();
}

class _CrearRegistroEntidadState extends State<CrearRegistroEntidad> {
  @override
  void initState() {
    // TODO: implement initState
    cargarComboInicial();
    cargarTabla();

    super.initState();
  }

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  double datoss = 0.0;
  bool activoBoton = false;

  List<TipoGobierno> tipoGobierno = [];
  List<DataRow> dataRows = [];
  bool _isActivo = true;
  final bool _ismostar= false;
  Future traertota() async {
    await Future.delayed(const Duration(seconds: 10));
    // var a = await DatabaseDRC.db.traersumatotal();
  }

  cargarComboInicial() async {
    tipoGobierno = await ProviderRegistarInterv().getlistaTipoGobierno();
  }

  cargarTabla() async {
    setState(() {
      dataRows = [];
    });
    var dataTable = await DatabasePr.db.ListarEntidadesReg();
    if (dataTable.isNotEmpty) {
      _isActivo = false;
    } else {
      _isActivo = true;
    }
    for (int i = 0; i < dataTable.length; i++) {
      _dataRow(dataTable[i]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "REGISTRO DE ENTIDADES:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _isActivo
                ? IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: const Color.fromARGB(255, 69, 90, 210),
                    onPressed: () async {
                      var resp = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgregarEntidad( widget.ismostar),
                        ),
                      );
                      if (resp == 'OK') {
                        cargarTabla();
                      }

                    },
                    // color: Colors.pink,
                  )
                : Container(),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortColumnIndex: 2,
                sortAscending: true,
                headingRowColor: MaterialStateProperty.all(Colors.green[100]),
                columnSpacing: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                columns: const [
                  DataColumn(
                      label: SizedBox(
                    width: 70,
                    child: Text('Usuario',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  )),
                  DataColumn(
                      label: Text('Sector',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Programa',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Categoria',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Sub Categoria',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Actividad',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Servicio',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Accion',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                ],
                rows: dataRows),
          ),
        ),
      ],
    );
  }

  _dataRow(Accion data) {
    dataRows.add(
      DataRow(
        //  key: ValueKey(data.id),
        cells: [
          DataCell(Text(data.usuario!)),
          DataCell(Text(data.sector!)),
          DataCell(Text(data.programa!)),
          DataCell(Text(data.categoria!)),
          DataCell(Text(data.subcategoria!)),
          DataCell(Text(data.actividad!)),
          DataCell(Text(data.servicio!), onTap: () {
          }),
          DataCell(
            accionesEl(data.id),

          ),
        ],
      ),
    );
  }

  alertDialog(BuildContext context, i) {
    AlertDialog(
      title: const Text('Eliminar'),
      content: const Text('Desea Eliminar esta Guia'),
      actions: <Widget>[
        TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  await DatabasePr.db.eliminarPoridAccion(i);
                  Navigator.pop(context);
                  await cargarTabla();
                },
                child: const Text('Si'),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              )
            ],
          ),
        ),
      ],
    );
  }

  accionesEl(i) {
    return Material(

        elevation: 1.0,
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.red,
        child: SizedBox(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

            onPressed: () async {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Eliminar'),
                  content: const Text('Desea Eliminar esta Informacion'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              await DatabasePr.db.eliminarPoridAccion(i);
                              Navigator.pop(context);
                              await cargarTabla();
                            },
                            child: const Text('Si'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            /*child: Icon(
              Icons.delete,
              color: Color.fromARGB(255, 230, 51, 35),
            ),*/
          ),
        ));
  }

  comboSeleccionar({String? labelTexts, items, onchanged}) {
    return DropdownButtonFormField<Object>(
        decoration: InputDecoration(
          isCollapsed: false,
          labelText: labelTexts,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          border: const UnderlineInputBorder(),
        ),
        isExpanded: true,
        items: items,
        onChanged: onchanged);
  }

  accionesE(int i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.green,
        child: SizedBox(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              /*  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditarGuiaClientePage(
                        //  guiaCliente: list,
                          id: i,
                        )),
              ); */
            },
            child: const Text(
              "Editar",
              textAlign: TextAlign.center,
              /*   style: _providerGuias.style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)*/
            ),
          ),
        ));
  }
}
