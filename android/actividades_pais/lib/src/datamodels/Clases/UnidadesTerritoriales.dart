import 'package:sqflite/sqflite.dart';

class ListarUnidadesTerritoriales {
  List<UnidadesTerritoriales> items = [];
  ListarUnidadesTerritoriales();
  ListarUnidadesTerritoriales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = UnidadesTerritoriales.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

/*  "id_UnidadesTerritoriales": 3,
        "unidadTerritorial": "APURIMAC" */
class UnidadesTerritoriales {
  String unidadTerritorial = '';
  int id_UnidadesTerritoriales = 0;

/*String  = "3";
  String unidadTerritorialtipoRegistro="PERSONAL AUXILIAR";*/
  UnidadesTerritoriales(
      {this.unidadTerritorial = '', this.id_UnidadesTerritoriales = 0});

  Map<String, dynamic> toMap() {
    return {
      "unidadTerritorial": unidadTerritorial,
      "id_UnidadesTerritoriales": id_UnidadesTerritoriales,
    };
  }

  factory UnidadesTerritoriales.fromJson(Map<String, dynamic> parsedJson) =>
      UnidadesTerritoriales(
          unidadTerritorial: parsedJson['unidadTerritorial'],
          id_UnidadesTerritoriales: parsedJson['id_UnidadesTerritoriales']);

  UnidadesTerritoriales.fromMap(Map<String, dynamic> map) {
    unidadTerritorial = map['unidadTerritorial'];
    //  idUsuario = map['idUsuario'];
    id_UnidadesTerritoriales = map['id_UnidadesTerritoriales'];
  }
}

class DatUnidadTerritorial {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'database.db',
      version: 1,
      onCreate: (Database db, int version) {
        /*    db.execute(
            "CREATE TABLE DatUnidadTerritorial (id INTEGER PRIMARY KEY, unidadTerritorial TEXT, id_UnidadesTerritoriales INTEGER)"); */
      },
    );
    print(_db!.rawQuery("SELECT * FROM DatUnidadTerritorial"));
  }

  Future<void> insert(UnidadesTerritoriales regitroCalificada) async {
    print(_db!.insert("DatUnidadTerritorial", regitroCalificada.toMap()));
  }

  Future<List<UnidadesTerritoriales>> getAllTasks() async {
    List<Map<String, dynamic>> result =
        await _db!.query("DatUnidadTerritorial");
    //  print(result[0].toString());
    return result.map((map) => UnidadesTerritoriales.fromMap(map)).toList();
  }

  Future updateTask(UnidadesTerritoriales task) async {
    _db!.update("DatUnidadTerritorial", task.toMap(),
        where: "id = ?", whereArgs: [task.id_UnidadesTerritoriales]);
  }

  Future<List<UnidadesTerritoriales>> getTodosUnidadesTeritoriales() async {
    initDB();

    final res = await _db!.query('DatUnidadTerritorial');
    print(res);
    List<UnidadesTerritoriales> list = res.isNotEmpty
        ? res.map((e) => UnidadesTerritoriales.fromJson(e)).toList()
        : [];
    print(list[0].toString());
    return list;
  }
}
