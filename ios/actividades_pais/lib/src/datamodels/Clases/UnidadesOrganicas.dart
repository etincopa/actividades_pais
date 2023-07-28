
class ListarUnidadesOrganicas {
  List<UnidadesOrganicas> items = [];
  ListarUnidadesOrganicas();
  ListarUnidadesOrganicas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = UnidadesOrganicas.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class UnidadesOrganicas {
  String UNIDAD_ORGANICA = '';
  int IDUO = 0;

/*String  = "3";
  String UNIDAD_ORGANICAtipoRegistro="PERSONAL AUXILIAR";*/
  UnidadesOrganicas({this.UNIDAD_ORGANICA = '', this.IDUO = 0});

  Map<String, dynamic> toMap() {
    return {
      "UNIDAD_ORGANICA": UNIDAD_ORGANICA,
      "IDUO": IDUO,
    };
  }

  factory UnidadesOrganicas.fromJson(Map<String, dynamic> parsedJson) =>
      UnidadesOrganicas(
          UNIDAD_ORGANICA: parsedJson['UNIDAD_ORGANICA'],
          IDUO: parsedJson['IDUO']);

  UnidadesOrganicas.fromMap(Map<String, dynamic> map) {
    UNIDAD_ORGANICA = map['UNIDAD_ORGANICA'];
    //  idUsuario = map['idUsuario'];
    IDUO = map['IDUO'];
  }
}

/*class DatUnidadesOrganicas {
  Database _db;
  static final DatUnidadesOrganicas db = DatUnidadesOrganicas._();
  DatUnidadesOrganicas._();
  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDB();

    return _db;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'database.db',
      version: 1,
      onCreate: (Database db, int version) {
        /*    db.execute(
            "CREATE TABLE DatUnidadesOrganicas (id INTEGER PRIMARY KEY, UNIDAD_ORGANICA TEXT, IDUO INTEGER)"); */
      },
    );
    print(_db.rawQuery("SELECT * FROM DatUnidadesOrganicas"));
  }

  /* Future<void> insertUnidadesOrganicas(
      UnidadesOrganicas regitroCalificada) async {
    print(_db.insert("DatUnidadesOrganicas", regitroCalificada.toMap()));
  }

  Future<List<UnidadesOrganicas>> getAllTasksUnidadesOrganicas() async {
    List<Map<String, dynamic>> result = await _db.query("DatUnidadesOrganicas");
    //  print(result[0].toString());
    return result.map((map) => UnidadesOrganicas.fromMap(map)).toList();
  }

  Future updateTaskUnidadesOrganicas(UnidadesOrganicas task) async {
    _db.update("DatUnidadesOrganicas", task.toMap(),
        where: "id = ?", whereArgs: [task.IDUO]);
  }

  Future<List<UnidadesOrganicas>> getTodosUnidadesOrganicas() async {
    initDB();

    final res = await _db.query('DatUnidadesOrganicas');
    print(res);

    List<UnidadesOrganicas> list = res.isNotEmpty
        ? res.map((e) => UnidadesOrganicas.fromJson(e)).toList()
        : [];
    print(list[0].toString());
    return list;
  } */

/*  nuevoInsertarStu(Student departamento) async {
 
    final db = await database;
 
    final insertar= await db.rawQuery(
        "SELECT DISTINCT UNIDAD_ORGANICATambo, idTambo, fecha, estado FROM preguntas WHERE estado = $estado");
    final res = await db.insert('LoginDat', departamento.toJson());
 
    print(res);
    return res;
  } */
}
 */
