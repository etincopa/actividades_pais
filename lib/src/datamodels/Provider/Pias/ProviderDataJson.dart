import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/Pias/Campania.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/TipoAtencion.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';

class ProviderDataJson {
  Servicios servicios = Servicios();

  Future<List<CLima>> getSaveClima() async {
    await DatabasePias.db.initDB();
    await DatabasePias.db.eliminarTodoClima();
    String jsonString = await servicios.loadCLima();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = CLimas.fromJsonList(jsonResponse);
/*
    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = CLima(
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
        id: listadoDepart.items[i].id,
      );
      await DatabasePias.db.insertClima(rspt);
    }*/
    return listadoDepart.items;
  }

  Future<List<TipoAtencion>> getTipoAtencion() async {
    await DatabasePias.db.initDB();
    await DatabasePias.db.eliminarTodoClima();
    String jsonString = await servicios.loadtipoAtencion();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListaTipoAtencion.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = TipoAtencion(
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
        id: listadoDepart.items[i].id,
      );
      await DatabasePias.db.insertTipoAtencion(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<Campania>> getCamapanias() async {
    await DatabasePias.db.initDB();
    await DatabasePias.db.eliminarCampanias();
    String jsonString = await servicios.loadCampanias();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListasCampanias.fromJsonList(jsonResponse);
/*
    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Campania(
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
        id: listadoDepart.items[i].id,
      );
      await DatabasePias.db.insertCampanias(rspt);
    }*/
    return listadoDepart.items;
  }
}
