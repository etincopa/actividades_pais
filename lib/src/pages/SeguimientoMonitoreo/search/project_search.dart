import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/listView/ListaProyectos.dart';
import 'package:flutter/material.dart';

class ProjectSMSearchDelegate extends SearchDelegate<String> {
  ProjectSMSearchDelegate({required this.aProyecto});
  List<TramaProyectoModel> aProyecto;

  Future<List<TramaProyectoModel>> getProyectos(String search) async {
    aProyecto = aProyecto
        .where((o) => o.tambo!.toUpperCase().contains(search.toUpperCase()))
        .toList();
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
            if (query.isEmpty || aProyecto.isEmpty) {
              return buildNoSuggestions();
            } else {
              return buildSuggestionsSuccess(aProyecto);
            }
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
    if (query.isNotEmpty || aProyecto.isNotEmpty) {
      for (var item in aProyecto) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListaProyectos(context: context, oProyecto: item);
          },
        );
      }
    }
    return buildNoSuggestions();
  }

  Widget buildNoSuggestions() => const Center(
        child: Text(
          '¡No hay sugerencias!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );

  Widget buildSuggestionsSuccess(List<TramaProyectoModel> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index].tambo.toString();
          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            leading: const Icon(Icons.search),
            title: RichText(
              text: TextSpan(
                text: suggestion,
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
}
