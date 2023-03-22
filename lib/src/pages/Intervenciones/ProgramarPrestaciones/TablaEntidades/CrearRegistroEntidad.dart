import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListaTipoGobierno.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/TablaEntidades/AgregarEntidad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrearRegistroEntidad extends StatefulWidget {
  const CrearRegistroEntidad({Key? key}) : super(key: key);

  @override
  State<CrearRegistroEntidad> createState() => _CrearRegistroEntidadState();
}

class _CrearRegistroEntidadState extends State<CrearRegistroEntidad> {
  @override
  void initState() {
    // TODO: implement initState
    cargarComboInicial();
    super.initState();
  }
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  //final _providerGuias = new ProviderProcesarGuias();
  //List<DetalleRenCuenModel> list = [];
  double datoss = 0.0;
  bool activoBoton = false;

  List<TipoGobierno> tipoGobierno=[];

 // String? _valueTipoUser = _itemTipoUser[0];

  Future refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    //var a = await DatabaseDRC.db.getDtaGRC();
   // setState(() {
      traertota();

      ///print(a);
      ///list = a;
   // });
  }

  Future traertota() async {
    await Future.delayed(const Duration(seconds: 10));
    // var a = await DatabaseDRC.db.traersumatotal();

  }

  cargarComboInicial()async{
    tipoGobierno = await ProviderRegistarInterv().getlistaTipoGobierno();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshList();
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "REGISTRO DE ENTIDADES:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: const Color.fromARGB(255, 69, 90, 210),
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AgregarEntidad(),
                  ),
                );
             /*   await utils().showMyDialog(
                  context,
                  "AGREGAR ENTIDAD",wFormulario: regitroEntidades(),activo: activoBoton
                );*/
              },
              // color: Colors.pink,
            ),
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
              columns: [
                DataColumn(
                    label: Container(
                  width: 70,
                  child: const Text('Usuario',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )),
                const DataColumn(
                    label: Text('Sector',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                const DataColumn(
                    label: Text('Programa',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                const DataColumn(
                    label: Text('Categoria',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                const DataColumn(
                    label: Text('Sub Categoria',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                const DataColumn(
                    label: Text('Actividad',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
                const DataColumn(
                    label: Text('Servicio',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold))),
              ],
              rows: [
                /*     //_providerAsignacion.getSqlGuiaRem();
                if (list = null)
                  for (var i = 0; i < list.length; i++)
                    DataRow(

                      //selected: true,
                        cells: [
                          DataCell(
                            Text(
                              '${list[i].fecha}',
                              style: TextStyle(fontSize: 10),
                            ),
                            // placeholder: true,
                            //  showEditIcon: true)
                          ),
                          DataCell(Container(
                            child: Text(
                              '${list[i].proveedor}',
                              style: TextStyle(fontSize: 10),
                            ),
                            width: 50,
                          )),
                          DataCell(Text(
                            '${list[i].ndocumento}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Text(
                            '${list[i].concepto}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Text(
                            '${list[i].monto}',
                            style: TextStyle(fontSize: 10),
                          )),
                          DataCell(Row(
                            children: [
                              accionesE(i),
                              SizedBox(width: 10.0),
                              accionesEl(list[i].id)
                            ],
                          )),
                        ]),*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  accionesEl(i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red,
        child: Container(
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
                  content: const Text('Desea Eliminar esta Guia'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              print(i);
                              // DatabaseDRC.db.eliminarPorid(i);
                              refreshList();
                              Navigator.pop(context);
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
            child: const Text(
              "Eliminar",
              textAlign: TextAlign.center,
              //    style:_providerGuias.style.copyWith(
              //                     color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context, String? title) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(title!), GestureDetector(
                child: Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Form(
            // key: _formKey1,
            child: Card(
              color: Colors.transparent,
              elevation: 0.0,
          //    child: regitroEntidades(),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text("Cancelar"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 26, 155, 86)),
                    ),
                    child: const Text("Agregar"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }



  comboSeleccionar({String? labelTexts, items, onchanged}) {
    return DropdownButtonFormField<Object>(
      decoration:   InputDecoration(
        isCollapsed: false,
        labelText: labelTexts,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        border: const UnderlineInputBorder(),
      ),
      isExpanded: true,
      items: items,
      onChanged: onchanged
    );
  }

  accionesE(int i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.green,
        child: Container(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              print(i);
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
