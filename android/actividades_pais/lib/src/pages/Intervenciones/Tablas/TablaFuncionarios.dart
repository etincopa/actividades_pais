import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';

class TablaGiaClienteAsix extends StatefulWidget {
  late String title;

  TablaGiaClienteAsix({super.key});
  @override
  State<TablaGiaClienteAsix> createState() => _TablaGiaClienteAsixState();
}

class _TablaGiaClienteAsixState extends State<TablaGiaClienteAsix> {
  List<Funcionarios> list = [];
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    //var a = await DatabasePr.db.getDtaGRC();
    setState(() {
      ///list = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshList();
    return DataTable(
      columns: const [
        DataColumn(
            label: SizedBox(
          width: 50,
          child: Text('N° Guia',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        )),
        DataColumn(
            label: Text('Descripcion',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Acciones',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      ],
      rows: [
        //_providerAsignacion.getSqlGuiaRem();
        // ignore: sdk_version_ui_as_code
        if (list != null)
          for (var i = 0; i < list.length; i++)
            DataRow(

                //selected: true,
                cells: [
                  DataCell(
                    Text(
                      '${list[i].cargo}-${list[i].telefono}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    // placeholder: true,
                    //  showEditIcon: true)
                  ),
                  DataCell(Text(
                    list[i].dni,
                    style: const TextStyle(fontSize: 10),
                  )),
                  DataCell(Row(
                    children: [
                      accionesE(list[i].id),
                      const SizedBox(width: 10.0),
                      accionesEl(list[i].id)
                    ],
                  )),
                ]),
      ],
    );
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
/*              var consulta = await DatabasePr.db.getporid(i);

              final respuesta = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalleguiaedPage(
                        id: i,
                        idtipocarga: consulta[0].idTipoCarga,
                        alto: consulta[0].alto,
                        ancho: consulta[0].ancho,
                        cantidad: consulta[0].cantidad,
                        descripcion: consulta[0].descripcion,
                        ft: consulta[0].ft,
                        oc: consulta[0].oc,
                        grnumero: consulta[0].gr,
                        grserie: consulta[0].grs,
                        largo: consulta[0].largo,
                        peso: consulta[0].peso,
                        tipoCarga: consulta[0].tipoCarga)),
              );
              print('aqqqqq' + respuesta);
              if (respuesta) {
                refreshList();
              } else {}
              //   LoginUser(email.text, password.text); */
            },
            child: Text("Editar",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }

  accionesEl(i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(20.0),
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
                  title: const Text('Eliminar??'),
                  content: const Text('Desea Eliminar esta Guia?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                //    DatabasePr.db.eliminarPorid(i);
                              });
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

              //   LoginUser(email.text, password.text);
            },
            child: Text("Eliminar",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
