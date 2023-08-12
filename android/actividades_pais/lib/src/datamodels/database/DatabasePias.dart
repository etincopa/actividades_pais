
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Archivos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/ArchivosEvidencia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Atencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Campania.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PorcentajesEnvioPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PuntoAtencionPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/TipoAtencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePias {
  Database? _db;

  static final DatabasePias db = DatabasePias._();

  DatabasePias._();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase('databasePiasDb.db', version: 3,
        onCreate: (Database db, int version) {
      db.execute("CREATE TABLE PuntoAtencionPias (id INTEGER PRIMARY KEY,"
          "codigoUbigeo,"
          "idCampania,"
          "idPias,"
          "pias,"
          "puntoAtencion,"
          "latitud,"
          "longitud,"
          "anio)");
      db.execute(
          "CREATE TABLE reportesPias (id INTEGER PRIMARY KEY,fechaParteDiario,puntoAtencion,codigoUbigeo,idPlataforma,plataforma,idUnidadTerritorial,unidadTerritorial,clima,climaId,detalle,personal,estadosEquipos,sismonitor,idUnicoReporte,latitud,longitud,campania, idParteDiario)");

      db.execute(
          'CREATE TABLE climas (id INTEGER PRIMARY KEY,cod,descripcion)');
      db.execute(
          'CREATE TABLE actividadesPias (id INTEGER PRIMARY KEY,plataforma,descripcion,idUnicoReporte)');
      db.execute(
          'CREATE TABLE tipoAtencion (id INTEGER PRIMARY KEY,cod,descripcion)');
      db.execute(
          'CREATE TABLE atencion (id INTEGER PRIMARY KEY,tipo, tipoDescripcion,atendidos,atenciones, idUnicoReporte)');
      db.execute(
          'CREATE TABLE incidentesNovedadesPias (id INTEGER PRIMARY KEY,incidentes,novedades, idUnicoReporte,tipo)');
      db.execute(
          "CREATE TABLE nacimiento (id INTEGER PRIMARY KEY,detalle,idUnicoReporte,idParteDiarioNacimiento)");
      db.execute(
          'CREATE TABLE campanias (id INTEGER PRIMARY KEY,cod,descripcion)');

      db.execute(
          'CREATE TABLE porcentajesEnvio (id INTEGER PRIMARY KEY,tipo,idUnicoReporte,porcentaje)');
      db.execute(
          "create table archivos(id INTEGER PRIMARY KEY,idNacimiento,idParteDiario,file, idUnicoReporte, idParteDiarioNacimiento)");
      db.execute(
          "create table archivosEvidencia(id INTEGER PRIMARY KEY,idParteDiario,file, idUnicoReporte)");
    });
  }

  borrarPorcentajes(idUnicoReporte) async {
    final res = await _db?.rawQuery(
        "DELETE FROM porcentajesEnvio where idUnicoReporte = '$idUnicoReporte'");
  }

  Future updateArchivos(idParteDiarioNacimiento, idNacimiento) async {
    print("$idParteDiarioNacimiento $idNacimiento");
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "UPDATE archivos SET idParteDiarioNacimiento = $idParteDiarioNacimiento  WHERE idNacimiento = $idNacimiento;");
    return res;
  }

  Future<int> insertArchivos(Archivos ser) async {
    await DatabasePias.db.initDB();
    var a = await _db!.insert("archivos", ser.toMap());
    return a;
  }

  Future<List<Archivos>> traerArchivos(
    idUnicoReporte,
    idNacimiento,
  ) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from  archivos where idUnicoReporte =  '$idUnicoReporte' and idNacimiento = $idNacimiento");
    List<Archivos> list =
        res!.isNotEmpty ? res.map((e) => Archivos.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<Archivos>> traerArchivosParte(
      idUnicoReporte, idNacimiento, idParteDiarioNacimiento) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from  archivos where idUnicoReporte =  '$idUnicoReporte' and idNacimiento = $idNacimiento and idParteDiarioNacimiento=$idParteDiarioNacimiento");
    List<Archivos> list =
        res!.isNotEmpty ? res.map((e) => Archivos.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<Archivos>> DeleteArchivosParte(
      idUnicoReporte, idNacimiento, idParteDiarioNacimiento) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "Delete from archivos where idUnicoReporte =  '$idUnicoReporte' and idNacimiento = $idNacimiento and idParteDiarioNacimiento=$idParteDiarioNacimiento");
    List<Archivos> list =
        res!.isNotEmpty ? res.map((e) => Archivos.fromJson(e)).toList() : [];
    return list;
  }

  Future eliminarTodoClima() async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM climas");
    return res;
  }

  Future insertClima(CLima ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("climas", ser.toMap()));
  }

  Future<List<CLima>> getTodosClima() async {
    initDB();
    final res = await _db!.query('climas');
    List<CLima> list =
        res.isNotEmpty ? res.map((e) => CLima.fromJson(e)).toList() : [];
    return list;
  }

  Future<int> insertReportePias(ReportesPias ser) async {
    print(  ser.toMap());
     await DatabasePias.db.initDB();
    var a = await _db!.insert("reportesPias", ser.toMap());
    return a;

  }

  Future<List<ReportesPias>> getTodosReportePias() async {
    initDB();
    final res = await _db!.query('climas');

    List<ReportesPias> list =
        res.isNotEmpty ? res.map((e) => ReportesPias.fromJson(e)).toList() : [];
    return list;
  }

/*  Future<ReportesPias> traerUtlimoPorId(idUnicoReporte) async{
    List<Map<String, dynamic>> result =
    await _db!.query("reportesPias");
    //  print(result[0].toString());
    return result.map((map) => ReportesPias.fromMap(map)).toList();

  }*/

  Future<List<ReportesPias>> traerUtlimoPorId(idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from  reportesPias where idUnicoReporte = '$idUnicoReporte'");
    if (res!.isNotEmpty) {
      final res2 = await _db?.rawQuery(
          "SELECT max(id), * from  reportesPias where idUnicoReporte = '$idUnicoReporte'");
      List<ReportesPias> list = res2!.isNotEmpty
          ? res.map((e) => ReportesPias.fromJson(e)).toList()
          : [];
      return list;
    } else {
      return List.empty();
    }
  }

  Future eliminarActividadesPiasid(i) async {
    await DatabasePias.db.initDB();
    final res =
        await _db?.rawQuery("DELETE FROM actividadesPias where id = '$i';");

    return res;
  }

  Future insertActividadesPias(ActividadesPias ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("actividadesPias", ser.toMap()));
  }

  Future<List<ActividadesPias>> listarActividadesPias(idUnicoReporte) async {
    await DatabasePias.db.initDB();

    final res = await _db?.rawQuery(
        "SELECT * from actividadesPias where idUnicoReporte ='$idUnicoReporte' ");
    List<ActividadesPias> list = res!.isNotEmpty
        ? res.map((e) => ActividadesPias.fromMap(e)).toList()
        : [];
    return list;
  }

  Future insertTipoAtencion(TipoAtencion ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("tipoAtencion", ser.toMap()));
  }

  Future<int> insertAtencion(Atencion ser) async {
    await DatabasePias.db.initDB();
    var a = await _db!.insert("atencion", ser.toMap());
    return a;
  }

  Future<List<Atencion>> buscarTipoAtencion(tipo, idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from atencion WHERE tipo='$tipo' and idUnicoReporte = '$idUnicoReporte'");
    List<Atencion> list =
        res!.isNotEmpty ? res.map((e) => Atencion.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Atencion>> listarAtencion(idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from atencion where idUnicoReporte ='$idUnicoReporte' ORDER BY id DESC");
    List<Atencion> list =
        res!.isNotEmpty ? res.map((e) => Atencion.fromMap(e)).toList() : [];
    return list;
  }

  Future sumaAtenAtenc(idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT sum(atendidos) as sumaAtendidos, sum(atenciones) as sumAtenciones from atencion where idUnicoReporte = '$idUnicoReporte'");
     return res;
  }

  Future eliminarAtencionid(i) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM atencion where id = '$i';");
    return res;
  }

  Future eliminarIncidentesNovedadesPiasid(i) async {
    await DatabasePias.db.initDB();
    final res = await _db
        ?.rawQuery("DELETE FROM incidentesNovedadesPias where id = '$i';");

    return res;
  }

  Future eliminarNacidos(i) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM nacimiento where id = '$i';");

    return res;
  }

  Future<List<IncidentesNovedadesPias>> ListarIncidentesNovedadesPias(
      idUnicoReporte, tipo) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from incidentesNovedadesPias where idUnicoReporte ='$idUnicoReporte' and tipo = $tipo ORDER BY id DESC;");
    List<IncidentesNovedadesPias> list = res!.isNotEmpty
        ? res.map((e) => IncidentesNovedadesPias.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<IncidentesNovedadesPias>> ListarIncidentesNovedadesPiasT(
      idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * from incidentesNovedadesPias where idUnicoReporte ='$idUnicoReporte' ORDER BY id DESC;");
    List<IncidentesNovedadesPias> list = res!.isNotEmpty
        ? res.map((e) => IncidentesNovedadesPias.fromMap(e)).toList()
        : [];
    return list;
  }

  Future insertIncidentesNovedadesPias(IncidentesNovedadesPias ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("incidentesNovedadesPias", ser.toMap()));
  }

  Future<List<ReportesPias>> listaReportePias() async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("SELECT DISTINCT * from reportesPias");
    List<ReportesPias> list = res!.isNotEmpty
        ? res.map((e) => ReportesPias.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<ReportesPias>> reportePias(idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from reportesPias where idUnicoReporte ='$idUnicoReporte'");
    List<ReportesPias> list = res!.isNotEmpty
        ? res.map((e) => ReportesPias.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<int> insertNacimiento(Nacimiento ser) async {
    await DatabasePias.db.initDB();
    var a = await _db!.insert("nacimiento", ser.toMap());
    return a;
  }

  Future<List<Nacimiento>> ListarNacimientoPias(idUnicoReporte) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from nacimiento where idUnicoReporte ='$idUnicoReporte' ORDER BY id DESC;");
    List<Nacimiento> list =
        res!.isNotEmpty ? res.map((e) => Nacimiento.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Nacimiento>> ListarNacimientoPiasEn(
      idUnicoReporte, idNacimiento) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from nacimiento where idUnicoReporte ='$idUnicoReporte' and id =$idNacimiento ORDER BY id DESC;");
    List<Nacimiento> list =
        res!.isNotEmpty ? res.map((e) => Nacimiento.fromMap(e)).toList() : [];
    return list;
  }

  Future eliminarNacimiento(i) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM nacimiento where id = '$i';");
    await _db?.rawQuery("DELETE FROM archivos where idNacimiento =  $i;");
    return res;
  }

  Future eliminarReportePorId(id) async {
    print(id);
    await DatabasePias.db.initDB();
    final res =
        await _db?.rawQuery("DELETE from reportesPias where id = '$id'");

    return res;
  }

  Future eliminarReportePorIdru(idUnicoReporte) async {
     await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "DELETE from reportesPias where idUnicoReporte = '$idUnicoReporte'");
    await _db?.rawQuery(
        "DELETE from atencion where idUnicoReporte = '$idUnicoReporte'");
    await _db?.rawQuery(
        "DELETE from actividadesPias where idUnicoReporte = '$idUnicoReporte'");
    await _db?.rawQuery(
        "DELETE from nacimiento where idUnicoReporte = '$idUnicoReporte'");
    await _db?.rawQuery(
        "DELETE from archivos where idUnicoReporte = '$idUnicoReporte'");
    await _db?.rawQuery(
        "DELETE from porcentajesEnvio where idUnicoReporte = '$idUnicoReporte'");
    return res;
  }

  Future updateTask(ReportesPias task) async {

    print(_db!.update("reportesPias", task.toMap(),
        where: "idUnicoReporte = ?", whereArgs: [task.idUnicoReporte]));

    var a = await _db!.update("reportesPias", task.toMap(),
        where: "idUnicoReporte = ?", whereArgs: [task.idUnicoReporte]);

    print(a);
  }

  Future updateNacimiento(Nacimiento task) async {
    var res = await _db!.update("nacimiento", task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    return res;
  }

  Future eliminarCampanias() async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM campanias");
    return res;
  }

  Future insertCampanias(Campania ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("campanias", ser.toMap()));
  }

  Future<List<Campania>> getCampanias() async {
    initDB();
    final res = await _db!.query('campanias');
    List<Campania> list =
        res.isNotEmpty ? res.map((e) => Campania.fromJson(e)).toList() : [];
    return list;
  }

  Future insertPuntoAtencionPias(PuntoAtencionPias ser) async {
    await DatabasePias.db.initDB();
    print(_db!.insert("PuntoAtencionPias", ser.toMap()));
  }

  Future deletePuntoAtencionPias() async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery("DELETE from PuntoAtencionPias");
    print(res);
  }

  Future<List<PuntoAtencionPias>> ListarPuntoAtencionPias(
      campaniaCod, idPia) async {
    await DatabasePias.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from PuntoAtencionPias where idPias = $idPia and idCampania=$campaniaCod ORDER BY id DESC;");
    List<PuntoAtencionPias> list = res!.isNotEmpty
        ? res.map((e) => PuntoAtencionPias.fromMap(e)).toList()
        : [];
    return list;
  }

  Future insertPorcentajesEnvio(PorcentajesEnvioPias ser) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("porcentajesEnvio", ser.toMap()));
  }

  Future eliminarTPorcentajesEnvioPorid(i) async {
    await DatabasePr.db.initDB();
    final res = await _db
        ?.rawQuery("DELETE FROM porcentajesEnvio where idUnicoReporte = '$i';");
    return res;
  }

  Future<List<PorcentajesEnvioPias>> listarPorcentajes(
      codigoUnico, tipo) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from porcentajesEnvio a where idUnicoReporte = '$codigoUnico' and tipo = $tipo");
    List<PorcentajesEnvioPias> list = res!.isNotEmpty
        ? res.map((e) => PorcentajesEnvioPias.fromMap(e)).toList()
        : [];
    return list;
  }

  Future eliminarArchivoPorId(file) async {
    final res =
        await _db?.rawQuery("DELETE from archivos where file = '$file'");
    print(res);
  }

  Future eliminarArchivoEvPorId(file) async {
    final res = await _db
        ?.rawQuery("DELETE from archivosEvidencia where file = '$file'");
    print(res);
  }

  Future<List<Archivos>> listarArchivos(idNacimiento) async {
    final res = await _db?.rawQuery(
        "SELECT * from archivos a where idNacimiento = $idNacimiento");
    List<Archivos> list =
        res!.isNotEmpty ? res.map((e) => Archivos.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<ArchivosEvidencia>> listarArchivosUnico(idUnicoReporte) async {
    final res = await _db?.rawQuery(
        "SELECT * from archivosEvidencia a where idUnicoReporte = '$idUnicoReporte' ORDER BY id DESC ");
    List<ArchivosEvidencia> list = res!.isNotEmpty
        ? res.map((e) => ArchivosEvidencia.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<int> insertArchivosEv(ArchivosEvidencia ser) async {
    await DatabasePias.db.initDB();
    var a = await _db!.insert("archivosEvidencia", ser.toMap());
    return a;
  }
}
