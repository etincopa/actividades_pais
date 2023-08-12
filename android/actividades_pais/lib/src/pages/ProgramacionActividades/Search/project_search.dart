import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/Search/list_view_Projectos.dart';
import 'package:flutter/material.dart';

class ProgramacionSearchDelegate extends SearchDelegate<String> {
  List<ProgramacionActividadModel> searchProgramacion;
  ProgramacionSearchDelegate(this.searchProgramacion);
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();

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
    List<String> matchQuery = [];
    for (var item in searchProgramacion) {
      if ((item.idProgramacionIntervenciones!).contains(query.toLowerCase()) ||
          (item.estadoProgramacion!)
              .toLowerCase()
              .contains(query.toLowerCase())) {
        matchQuery.add(
            '${item.idProgramacionIntervenciones} - ${item.estadoProgramacion}');
      }
    }
    if (query.isEmpty || matchQuery.isEmpty) {
      return buildNoSuggestions();
    } else {
      return buildSuggestionsSuccess(matchQuery);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;

    if (!_data.contains(searched)) {
      final splitted = searched.split(' - ');
      for (var item in searchProgramacion) {
        if (item.idProgramacionIntervenciones == splitted[0]) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListViewProgramacion(
                context: context,
                oProgramacion: item,
              );
            },
          );
        }
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

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
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
