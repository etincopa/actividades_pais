import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_detail_form_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class ProjetSearchOtroDelegate extends SearchDelegate<String> {
  ProjetSearchOtroDelegate();

  MainController mainController = MainController();

  List<TramaProyectoModel> aProyecto = [];
  Future<List<TramaProyectoModel>> getProyectos(String search) async {
    _prefs = await SharedPreferences.getInstance();
    UserModel oUser = UserModel(
      nombres: _prefs!.getString('nombres') ?? '',
      codigo: _prefs!.getString('codigo') ?? '',
      rol: _prefs!.getString('rol') ?? '',
    );
    aProyecto = await mainController.getAllProyectoByNeUserSearch(
      oUser,
      search,
      0,
      0,
    );

    return aProyecto;
  }

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return buildNoSuggestions();
    } else {
      return FutureBuilder(
        future: getProyectos(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: aProyecto.length,
              itemBuilder: (context, index) {
                final oProyecto = aProyecto[index];
                return ListTile(
                  onTap: () {
                    showResults(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MonitoringDetailNewEditPage(
                                datoProyecto: aProyecto[index],
                                statusM: "SEARCH"),
                      ),
                    );
                  },
                  leading: const Icon(Icons.search),
                  title: RichText(
                    text: TextSpan(
                      text: "${oProyecto.cui} - ${oProyecto.tambo}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getProyectos(query),
      builder: (context, snapshot) {
        final String searched = query;
        if (snapshot.connectionState == ConnectionState.done) {
          return const Text('');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildNoSuggestions() => const Center(
        child: Text(
          '¡No hay sugerencias!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
}
