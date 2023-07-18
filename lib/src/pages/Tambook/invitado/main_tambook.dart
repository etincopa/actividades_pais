import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:actividades_pais/src/pages/Tambook/invitado/actividad_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/invitado/home_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/invitado/mapa_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/invitado/search_tambook.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class TambookHome extends StatefulWidget {
  const TambookHome({super.key});

  @override
  State<TambookHome> createState() => _TambookHomeState();
}

class _TambookHomeState extends State<TambookHome>
    with TickerProviderStateMixin<TambookHome> {
  int pageIndex = 0;

  final pages = [
    const HomeTambook(),
    const MapTambook(),
    ActividadTambook(),
  ];

  onTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        'BUSCAR TAMBO',
        context: context,
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage(),
            ),
          );
        },
        iconAct: Icons.search,
        onPressedAct: () {
          showSearch(
            context: context,
            delegate: SearchTambookDelegate(),
          );
        },
      ),
      backgroundColor: colorGB,
      body: pages[pageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color_10o15,
        foregroundColor: Colors.black,
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchTambookDelegate(),
          );
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: pageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Intervenciones',
          ),
        ],
      ),
    );
  }
}