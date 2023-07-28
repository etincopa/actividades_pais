import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/src/pages/Tambook/Detalle/detalle_tambook.dart';
import 'package:flutter/material.dart';

class SearchTambookDelegate extends SearchDelegate<String> {
  SearchTambookDelegate();
  final MainController mainController = MainController();
  List<BuscarTamboDto> listTambo = [];

  Future<List<BuscarTamboDto>> getTambook(String search) async {
    try {
      if (search.length > 2) {
        listTambo = await mainController.searchTambo(search);
      }
    } catch (oError) {}

    return listTambo;
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
        future: getTambook(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (query.isEmpty || listTambo.isEmpty) {
              return buildNoSuggestions();
            } else {
              return buildSuggestionsSuccess(listTambo);
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
    if (query.isNotEmpty || listTambo.isNotEmpty) {
      for (var item in listTambo) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
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

  Widget buildSuggestionsSuccess(List<BuscarTamboDto> dataList) =>
      ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetalleTambook(listTambo: dataList[index]),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.black12,
              ),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      margin: const EdgeInsets.only(right: 15),
                      child: Image.network(
                        dataList[index].nombreFisicoFoto!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            alignment: Alignment.center,
                            child: Image.network(
                              "https://www.pais.gob.pe/tambook/themes/tambook/assets/img/user-male-2.png",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Tambo: ${dataList[index].nombreTambo!}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Gestor: ${dataList[index].gestor!}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Departamento: ${dataList[index].nombreDepartamento!}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
