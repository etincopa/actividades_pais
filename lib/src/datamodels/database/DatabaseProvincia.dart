import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:actividades_pais/src/datamodels/Clases/Distritos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../Clases/CentroPoblado.dart';

class DatabaseProvincia {
  final Logger _log = Logger();
  Database? _db;

  static final DatabaseProvincia db = DatabaseProvincia._();

  DatabaseProvincia._();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'databaseProvincia.db',
      version: 1,
      onCreate: (Database db, int version) async {

          db.execute(
            "CREATE TABLE provincias (id INTEGER PRIMARY KEY, provincia_descripcion, provincia_ubigeo)");

        db.execute(
            "CREATE TABLE distritos (distrito_descripcion, distrito_ubigeo)");

        db.execute(
            "CREATE TABLE centros_poblados (centro_poblado_ubigeo, centro_poblado_descripcion)");
      },
    );
  }

  Future eliminarProvincias()async{

    await _db!.execute(
      "DELETE FROM centros_poblados",
    );
    await _db!.execute(
      "DELETE FROM distritos",
    );
    await _db!.execute(
      "DELETE FROM provincias",
    );

  }

  Future<void> insertCcpp(CentroPoblado listarCcpp) async {
    await DatabaseProvincia.db.initDB();
    print(_db!.insert("centros_poblados", listarCcpp.toMap()));
  }

  Future<List<CentroPoblado>> getCentroPoblado(ubigeo) async {
    initDB();
    final res = await _db!.rawQuery(
        "SELECT * FROM centros_poblados  where SUBSTR(centro_poblado_ubigeo, 1, 6) ='$ubigeo'  ORDER BY centro_poblado_descripcion ASC");
    List<CentroPoblado> list = res.isNotEmpty
        ? res.map((e) => CentroPoblado.fromJson(e)).toList()
        : [];
    return list;
  }
  Future<void> insertarDistritos(
      Distrito distrito) async {
    await DatabaseProvincia.db.initDB();
    print(_db!.insert("distritos", distrito.toMap()));
  }
  Future<List<Distrito>> getDistrito(ubigeo) async {
    initDB();
     final res = await _db!.rawQuery(
        "SELECT * FROM distritos  where SUBSTR(distrito_ubigeo, 1, 4) ='$ubigeo' ORDER BY distrito_descripcion ASC");
    List<Distrito> list = res.isNotEmpty
        ? res.map((e) => Distrito.fromJson(e)).toList()
        : [];
    return list;
  }
  Future<void> insertProvincia(Provincia regitroCalificada) async {
    await DatabaseProvincia.db.initDB();
    print(_db!.insert("provincias", regitroCalificada.toMap()));
  }
  Future<List<Provincia>> getProvincias() async {
    List<Map<String, dynamic>> result = await _db!.query("provincias",orderBy: "provincia_descripcion ASC");
    return result.map((map) => Provincia.fromMap(map)).toList();
  }
}
