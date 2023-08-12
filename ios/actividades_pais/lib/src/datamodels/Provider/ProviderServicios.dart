import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Home/Perfiles.dart';
import 'package:actividades_pais/src/datamodels/Clases/NumeroTelefono.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sexo.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Clases/Unidad.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarPrestacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Puesto.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:flutter/material.dart';

class ProviderServicios {
  Servicios servicios = Servicios();

  Future requestSqlData() async {
    await serv();
  }

  serv() async {
    await DatabasePr.db.initDB();
    await DatabasePr.db.deleteTabla();
    await getSaveTipoPlataforma();
    await getUnidadesTerr();
    // await getUnidadesTablaPlataforma();
    await getLugarPrestacion();
    await getPuesto();
    //await getUnidadesOrg();
    await getNumeroTelefono();
    await getProvincias();
    await getTipoDocumento();
    await getSexo();
  }

  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
    };
  }

/*  Future<List<UnidadesOrganicas>> getUnidadesOrg() async {
    String jsonString = await servicios.loadunidadesOrganicas();
    final jsonResponse = json.decode(jsonString);

    final listadoDepart =
        new ListarUnidadesOrganicas.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = UnidadesOrganicas(
          IDUO: listadoDepart.items[i].IDUO,
          UNIDAD_ORGANICA: listadoDepart.items[i].UNIDAD_ORGANICA);
      DatabasePr.db.insertUnidadesOrganicas(rspt);
    }
    return listadoDepart.items;
  }*/

  Future<List<UnidadesTerritoriales>> getUnidadesTerr() async {
    String jsonString = await servicios.loadunidadesTerritoriales();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        ListarUnidadesTerritoriales.fromJsonList(jsonResponse);

    return listadoDepart.items;
  }

/*  Future<List<UnidadesTablaPlataforma>> getUnidadesTablaPlataforma() async {
    String jsonString = await servicios.loadUnidadesTablaPlataforma();

    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        new ListarUnidadesTablaPlataforma.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = UnidadesTablaPlataforma(
        ALTITUD: listadoDepart.items[i].ALTITUD,
        CCPP: listadoDepart.items[i].CCPP,
        DEPARTAMENTO: listadoDepart.items[i].DEPARTAMENTO,
        DISTRITO: listadoDepart.items[i].DISTRITO,
        ID_UNIDAD_TERRITORIAL: listadoDepart.items[i].ID_UNIDAD_TERRITORIAL,
        LATITUD: listadoDepart.items[i].LATITUD,
        LONGITUD: listadoDepart.items[i].LONGITUD,
        PROVINCIA: listadoDepart.items[i].PROVINCIA,
        SNIP: listadoDepart.items[i].SNIP,
        TAMBO: listadoDepart.items[i].TAMBO,
        UBIGEO_CCPP: listadoDepart.items[i].UBIGEO_CCPP,
        UBIGEO_TAMBO: listadoDepart.items[i].UBIGEO_TAMBO,
      );
      DatabasePr.db.insertUnidadesTablaPlataforma(rspt);
    }
    return listadoDepart.items;
  }*/

  Future<List<LugarPrestacion>> getLugarPrestacion() async {
    String jsonString = await servicios.loadunidadesLugarPrestacion();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarLugarPrestacion.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = LugarPrestacion(
        idLugarPrestacion: listadoDepart.items[i].idLugarPrestacion,
        nombreLugarPrestacion: listadoDepart.items[i].nombreLugarPrestacion,
      );
      DatabasePr.db.insertLugarPrestacion(rspt);
      //DatLugarPrestacion.db.insert(rspt);
    }
    return listadoDepart.items;
  }

  //loadPuesto

  Future<List<Puesto>> getPuesto() async {
    String jsonString = await servicios.loadPuesto();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarPuesto.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Puesto(
        idPuesto: listadoDepart.items[i].idPuesto,
        nombrePuesto: listadoDepart.items[i].nombrePuesto,
      );
      DatabasePr.db.insertPuesto(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<NumerosTelef>> getNumeroTelefono() async {
    String jsonString = await servicios.loadNumeroTelefono();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarNumerosTelef.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = NumerosTelef(
        idNumeroTelefono: listadoDepart.items[i].idNumeroTelefono,
        numeroTelefono: listadoDepart.items[i].numeroTelefono,
      );
      DatabasePr.db.insertNmTelef(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<Provincia>> getProvincias() async {
    String jsonString = await servicios.loadprovincias();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = Provincias.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Provincia(
        provinciaDescripcion: listadoDepart.items[i].provinciaDescripcion,
        provinciaUbigeo: listadoDepart.items[i].provinciaUbigeo,
      );
      DatabasePr.db.insertProvincia(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<TipoDocumento>> getTipoDocumento() async {
    await DatabasePr.db.deleteTipoDocumento();
    String jsonString = await servicios.loadTipoDocumento();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarTipoDocumento.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = TipoDocumento(
        idTipoDocumento: listadoDepart.items[i].idTipoDocumento,
        descripcion: listadoDepart.items[i].descripcion,
      );
      await DatabasePr.db.insertTipoDocumento(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<Sexo>> getSexo() async {
    await DatabasePr.db.deletesexo();

    String jsonString = await servicios.loadSexo();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarSexo.fromJsonList(jsonResponse);

    /*for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Sexo(
        id: listadoDepart.items[i].id,
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
      );
      await DatabasePr.db.insertSexo(rspt);
    }*/
    return listadoDepart.items;
  }

  Future<List<Provincia>> getSaveIntervenciones() async {
    String jsonString = await servicios.loadprovincias();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = Provincias.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Provincia(
        provinciaDescripcion: listadoDepart.items[i].provinciaDescripcion,
        provinciaUbigeo: listadoDepart.items[i].provinciaUbigeo,
      );
      DatabasePr.db.insertProvincia(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<TipoPlataforma>> getSaveTipoPlataforma() async {
    await DatabasePr.db.initDB();
    await DatabasePr.db.eliminarTodoAsTipoPlataforma();
    String jsonString = await servicios.loadTipoPlataforma();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = TipoPlataformas.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = TipoPlataforma(
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
        id: listadoDepart.items[i].id,
      );
      await DatabasePr.db.insertTipoPlataforma(rspt);
    }
    return listadoDepart.items;
  }

  Future<Participantes> getBuscarParticipante(dni) async {
    String jsonString = await servicios.loadParticipantes();

    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        ListaParticipantesSer.fromJsonList(jsonResponse["response"]);
    for (var i = 0; i < listadoDepart.items.length; i++) {
            if(listadoDepart.items[i].dni==dni){
              return listadoDepart.items[i];
            }
    }
    /*    print(" vcvcv   ${listadoDepart.items[i]}");
      if (listadoDepart.items[i].dni == dni) {
        print(" vcvcv   ${listadoDepart.items[i]}");
        return listadoDepart.items[i];
      } else {
        return new Participantes();
      }*/

    return Participantes();
  }

  Future<Funcionarios> getBuscarFuncionarios(dni) async {
    String jsonString = await servicios.loadFuncionarios();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        ListaFuncionarios.fromJsonList(jsonResponse["response"]);

    for (var i = 0; i < listadoDepart.items.length; i++) {
         if(listadoDepart.items[i].dni == dni ){
           listadoDepart.items[i].estado_registro ="ENCONTRADO_JSON";
           return listadoDepart.items[i];
         } else{
           return listadoDepart.items[i];
         }
    }

    return Funcionarios();
  }


  Future<Funcionarios> getBuscarPersonasFallecidas(dni) async {
    String jsonString = await servicios.loadDataArchivos("jsonPersonasFallecidas.json");
    final jsonResponse = json.decode(jsonString);

    final listadoDepart =
    ListaFuncionarios.fromJsonList(jsonResponse["response"]);

    for (var i = 0; i < listadoDepart.items.length; i++) {

     if(listadoDepart.items[i].dni==dni){
       print(  "9+++++++ ${ listadoDepart.items[i]}");
      return listadoDepart.items[i];
     }
    }

    return Funcionarios();
  }

  Future<List<Perfil>?> loadPerfiles() async {
    String jsonString = await servicios.loadDataArchivos("perfiles.json");
    final jsonResponse = json.decode(jsonString);

    final listadoDepart =
    Perfiles.fromJsonList(jsonResponse["response"]);

    return listadoDepart.items;
  }
  Future listarPorIdUt(idUnidadterritorial) async {
    String jsonString = await servicios.loadunidadesTerritoriales();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = ListarUnidadesTerritoriales.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {

      if(listadoDepart.items[i].id_UnidadesTerritoriales==idUnidadterritorial){
        print(  "9+++++++ ${ listadoDepart.items[i]}");
        return listadoDepart.items[i].unidadTerritorial;
      }
    }
    return listadoDepart.items[0].unidadTerritorial;


  }
  Future<List<Unidad>> getUnidad() async {
    await DatabasePr.db.deletesexo();

    String jsonString = await servicios.loadUnidad();
    final jsonResponse = json.decode(jsonString);
    final listado = ListarUnidad.fromJsonList(jsonResponse);
    return listado.items;
  }

  underline() {
    var underlineCbo = Container(
      height: 1,
      color: Colors.grey,
    );
    return underlineCbo;
  }
}
