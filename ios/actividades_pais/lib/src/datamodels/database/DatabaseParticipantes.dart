
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/ParticipantesIntervenciones.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseParticipantes {
  Database? _db;

  static final DatabaseParticipantes db = DatabaseParticipantes._();

  DatabaseParticipantes._();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future initDB() async {
    _db = await openDatabase('participantesDb.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE participantesIntervencionesMovil (id INTEGER PRIMARY KEY, idParticipante,"
          "DNI,"
          "PRIMERNOMBRE,"
          "SEGUNDONOMBRE,"
          "APELLIDOPATERNO,"
          "APELLIDOMATERNO,"
          "SEXO,"
          "FECHANACIMIENTO,"
          "UNIDADTERRITORIAL"
          ")");
    });
  }

  Future DeleteAllParticitantesInterv() async {
    await DatabaseParticipantes.db.initDB();
    final res = await _db!.rawQuery("delete from participantesIntervencionesMovil");
    return res;
  }

  Future insertParticipantesIntervencionesMovil(
      ParticipantesIntervenciones participanteEjecucion) async {
    await DatabaseParticipantes.db.initDB();
    final res = await _db!.insert(
        "participantesIntervencionesMovil", participanteEjecucion.toMap());
    return res;
  }

  Future <List<Participantes>> listarTodoParicipantes() async {
    await DatabaseParticipantes.db.initDB();
    final res =
        await _db?.rawQuery("SELECT * from participantesIntervencionesMovil");
    print(res);
    List<Participantes> list = res!.isNotEmpty
        ? res.map((e) => Participantes.fromJsondb(e)).toList()
        : [];

    return list;
  }

  Future<List<Participantes>> getUsuarioParticipanteDniSQLites(dni) async {
    await DatabaseParticipantes.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from participantesIntervencionesMovil where DNI = '$dni'");
    print(res);
    List<Participantes> list = res!.isNotEmpty
        ? res.map((e) => Participantes.fromJsondb(e)).toList()
        : [];

    return list;
  }
}
