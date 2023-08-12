import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/ListView/list_view_monitores.dart';
import 'package:flutter/material.dart';

class MonitorSearchDelegate extends SearchDelegate<String> {
  final List<TramaMonitoreoModel> searchMonitor;
  final String? statusM;

  MonitorSearchDelegate({required this.searchMonitor, this.statusM});
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
    for (var item in searchMonitor) {
      if (statusM == "OTROS") {
        if ((item.tambo!).toLowerCase().contains(query.toLowerCase()) ||
            (item.idMonitoreo!).contains(query.toLowerCase()) ||
            (item.estadoMonitoreo!)
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add(
              '${item.idMonitoreo} - ${item.tambo} -${item.estadoMonitoreo}');
        }
      } else {
        if ((item.idMonitoreo!).contains(query.toLowerCase()) ||
            (item.estadoMonitoreo!)
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add('${item.idMonitoreo} - ${item.estadoMonitoreo}');
        }
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
      for (var item in searchMonitor) {
        if (item.idMonitoreo == splitted[0]) {
          return ListViewMonitores(context: context, aMonitoreo: [item]);
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
