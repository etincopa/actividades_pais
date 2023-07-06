import 'package:actividades_pais/src/pages/InformacionAplicativo/informacion.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  String nombre;
  String dni;
  MenuPage({super.key, this.nombre = '', this.dni = ''});
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int cantidad = 0;
  final String _nombrePersona = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color(0xFF3949AB),
        actions: const [],
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cardNombre(widget.nombre, Icons.perm_contact_calendar, () {}),
            const SizedBox(
              height: 25,
            ),
            /*     cardNombre('Historial de Registros', Icons.article_outlined, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistorialPage(dni: widget.dni)),
              );
            }),
            cardNombre(
                'Sincronizar Registros', Icons.settings_backup_restore_sharp,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaasistenciaPage()),
              );
            }), */
            cardNombre('Informacion del Aplicativo', Icons.info_outline, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InformmacionAplicativoPage()),
              );
            }),
          ],
        ),
      )),
    );
  }

  Widget cardNombre(nombre, icon, onc) {
    return InkWell(
      onTap: onc,
      child: Container(
        child: Card(
          elevation: 19.0,
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 40,
                      color: Colors.blue[900],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(" $nombre",
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 13)),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
