import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:actividades_pais/src/datamodels/Clases/ArchivoTramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/AsistenciaClass.dart';
import 'package:actividades_pais/src/datamodels/Clases/AsistenciaModel.dart';
import 'package:actividades_pais/src/datamodels/Clases/Ccpp.dart';
import 'package:actividades_pais/src/datamodels/Clases/CierreUsuario.dart';

import 'package:actividades_pais/src/datamodels/Clases/ConfigInicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/Distritos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/InfoTelefono.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/LoginClass.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarPrestacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/NumeroTelefono.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/ParticipanteEjecucion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Puesto.dart';
import 'package:actividades_pais/src/datamodels/Clases/ReportePias.dart';
import 'package:actividades_pais/src/datamodels/Clases/ServicioProgramacionParticipante.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sexo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/IntentosRegistrosFallecidos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/ParticipantesIntervenciones.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/UbicacionUsuario.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesOrganicas.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTablaPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/porcentajesEnvio.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/database/DatabaseParticipantes.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/incidentesNovedades.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../Clases/CentroPoblado.dart';

class DatabasePr {
  final Logger _log = Logger();
  Database? _db;

  static final DatabasePr db = DatabasePr._();

  DatabasePr._();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();

    return _db!;
  }

  Future initDB() async {
    ///if(_db )
    _db = await openDatabase(
      'databaseConfig.db',
      version: 1,
      onCreate: (Database db, int version) async {
        /* db.execute(
            "CREATE TABLE DatUnidadesOrganicas (id INTEGER PRIMARY KEY, UNIDAD_ORGANICA TEXT, IDUO INTEGER)");
       */
        /* db.execute(
            "CREATE TABLE DatUnidadTerritorial (id INTEGER PRIMARY KEY, unidadTerritorial TEXT, id_UnidadesTerritoriales INTEGER)");
       */
        /*db.execute(
            'CREATE TABLE DatUnidadesTablaPlataforma (id INTEGER PRIMARY KEY, ID_UNIDAD_TERRITORIAL  INTEGER,'
            'SNIP  INTEGER,'
            'UBIGEO_CCPP  TEXT,'
            'UBIGEO_TAMBO  TEXT,'
            'DEPARTAMENTO  TEXT,'
            'PROVINCIA  TEXT,'
            'DISTRITO  TEXT,'
            'CCPP  TEXT,'
            'TAMBO  TEXT,'
            'LONGITUD,'
            'LATITUD,'
            'ALTITUD'
            ')');*/

        /* db.execute(
            "CREATE TABLE DatLugarPrestacion (id INTEGER PRIMARY KEY, idLugarPrestacion INTEGER, nombreLugarPrestacion TEXT)");
*/
        /*  db.execute(
            "CREATE TABLE DatPuesto (id INTEGER PRIMARY KEY, idPuesto INTEGER, nombrePuesto TEXT)");
       */
        db.execute(
            "CREATE TABLE asistenciaClass (id INTEGER PRIMARY KEY,  numeroDni,	nombres, snip,	nombreTambo, modalidadTrabajo,	idModalidadTrabajo,	cargo, date,dateSalida, unidadorg, tipoasistencia, idTipoasistencia)");
        db.execute(
            "CREATE TABLE asistencia (id INTEGER PRIMARY KEY,  snip,	tipoTrabajo, tipoasistencia, idUnidadTerritorial,	dni, tipoCheck,	latitud,	longitud, fechaHora,idLugarPrestacion, idUnidadOrganica, tipohor, isSelected, imei)");
        db.execute(
            "CREATE TABLE infoTelefono (id INTEGER PRIMARY KEY,  imei,	mac, ip)");
        db.execute(
            "CREATE TABLE numeroTelefono (id INTEGER PRIMARY KEY,  numeroTelefono)");
        db.execute(
            "CREATE TABLE ubicacionUsuario (id INTEGER PRIMARY KEY,  actividad, tipo, dni, snip, idLugarDeprestacion, idUnidTerritoriales, idUnidadesOrganicas, idPlataforma, latitud, longitud, fechaHora, idselecttipotrab, selecttipotrab, millisec)");
        db.execute(
            "CREATE TABLE cierreUsuario (id INTEGER PRIMARY KEY,  descripcion, imagen, dni, snip, idUnidTerritoriales, idUnidadesOrganicas, idLugarDeprestacion, idPlataforma, latitud, longitud, fechaHora)");
        db.execute(
            "CREATE TABLE funcionarios (id INTEGER PRIMARY KEY,flgReniec,tipo,dni,pais,datos,entidad,nombreCargo,telefono,apellidoMaterno,nombres,apellidoPaterno,idProgramacion,cargo,estado,idActividad,idEntidad,idPais,idTipoDocumento,idUsuario,numDocExtranjero,txtIpmaq,ubigeoCcpp,tipoDocumento)");
        db.execute(
            "CREATE TABLE participantes (id INTEGER PRIMARY KEY, idProgramacion,dni,primerNombre,segundoNombre, apellidoPaterno, apellidoMaterno, edad, sexo, ubigeoCcpp, nombreResidencia,flatResidencia,fechaNacimiento,provincia,distrito,centroPoblado,idCentroPoblado,numDocExtranjero,idEntidad,entidad,idPais,idTipoDocumento,tipoDocumento,idServicio,servicio,idUsuario,txtIpmaq,tipo, tipoParticipante, pais,nombreCcpp)");
        db.execute(
            "CREATE TABLE partExtrangeros (id INTEGER PRIMARY KEY,  id_programacion_participante, id_programacion, id_participante, nombre, nombre2, apellidoPaterno, apellidoMaterno, edad, fecha_nacimiento, sexo, pais, tipo_documento, id_tipo_documento,dni,servicio,entidad,codigoIntervencion)");
        db.execute(
            "CREATE TABLE tipoDocumento (id INTEGER PRIMARY KEY,idTipoDocumento, descripcion)");
        db.execute(
            "CREATE TABLE provincias (id INTEGER PRIMARY KEY, provincia_descripcion, provincia_ubigeo)");
        /*db.execute(
            "CREATE TABLE plataforma_ubigeos (id INTEGER PRIMARY KEY, plataforma_codigo_snip, departamento_ubigeo)"); */
        db.execute(
            "CREATE TABLE tramaIntervenciones (id INTEGER PRIMARY KEY, codigoIntervencion, codigoInterno, snip, id_departamento, departamento, provincia, distrito, tambo, tipoIntervencion, identificacionIntervencion, fecha, horaInicio, horaFin, lugarIntervencion, tipoGobierno, sector, programa, categoria, subCategoria, poblacion, atencion, estado, fechaRegistro, tipoActividad, servicio, beneficiario, descripcion_evento, estadoAppMovil, idTipoIntervencion)");
        db.execute(
            "CREATE TABLE tramaIntervencionesUs (id INTEGER PRIMARY KEY, codigoIntervencion, codigoInterno, snip, id_departamento, departamento, provincia, distrito, tambo, tipoIntervencion, identificacionIntervencion, fecha, horaInicio, horaFin, lugarIntervencion, tipoGobierno, sector, programa, categoria, subCategoria, poblacion, atencion, estado, fechaRegistro, tipoActividad, servicio, beneficiario, descripcion_evento, estadoAppMovil, idTipoIntervencion)");
        db.execute(
            "CREATE TABLE archivoTramaIntervenciones (id INTEGER PRIMARY KEY,codigoIntervencion, file, fileEncode, nmero)");
        db.execute(
            'CREATE TABLE sexo (id INTEGER PRIMARY KEY,cod,descripcion)');

        db.execute(
            'CREATE TABLE servicioProgramacionParticipante (id INTEGER PRIMARY KEY,id_programacion_participante_servicio,id_programacion_participante, id_servicio, id_programacion, tipo)');

        db.execute(
            'CREATE TABLE tipoPlataforma (id INTEGER PRIMARY KEY,cod,descripcion)');
        db.execute(
            'CREATE TABLE porcentajesEnvio (id INTEGER PRIMARY KEY,tipo,codigoIntervencion,porcentaje)');
        db.execute(
            'CREATE TABLE EntidadFuncionario (id INTEGER PRIMARY KEY, id_accion_programacion,'
            'id_tipo_actividad,'
            'nombre_tipo_actividad,'
            'id_entidad,'
            'nombre_programa,'
            'id_programacion)');

        db.execute(
            'CREATE TABLE listarCcpp (id INTEGER PRIMARY KEY, ubigeoCcpp,'
            'nombreCcpp, snip)');

        db.execute(
            'CREATE TABLE participanteEjecucion (id INTEGER PRIMARY KEY, id_entidad,id_servicio,'
            'nombre_servicio,id_programacion)');

        db.execute(
            "CREATE TABLE DatConfigInicio (idConfigInicio INTEGER PRIMARY KEY,  nombreConfigInicio,	idLugarPrestacion, lugarPrestacion,	idUnidadesOrganicas, unidadesOrganicas,	idPuesto,	puesto, idUnidTerritoriales, unidTerritoriales,	idTambo,	nombreTambo, snip, tipoPlataforma,campania,codCampania,modalidad, tipoUsuario)");

        db.execute(
            "CREATE TABLE ConfigPersonal (id INTEGER PRIMARY KEY,unidad, codigo, nombres, rol,fechaNacimento,numeroDni,contrasenia,apellidoMaterno, apellidoPaterno, cargo, tipoUsuario)");

        db.execute(
            "CREATE TABLE login (id, name,username,password, token, rol)");

        db.execute(
            "CREATE TABLE distritos (distrito_descripcion, distrito_ubigeo)");

        db.execute(
            "CREATE TABLE centros_poblados (centro_poblado_ubigeo, centro_poblado_descripcion)");
        db.execute(
            "CREATE TABLE intentos_registros_fallecidos (id INTEGER PRIMARY KEY, id_plataforma, id_programacion, dni, id_usuario_reg, fecha_reg, ipmaq_reg, id_usuario_act, fecha_act, ipmaq_act, id_usuario_del, fecha_del, ipmaq_del)");

        db.execute('''CREATE TABLE accion (id INTEGER PRIMARY KEY AUTOINCREMENT,
           usuario TEXT, 
           sector TEXT, 
           programa TEXT, 
           categoria TEXT,
           subcategoria TEXT,
           actividad TEXT,
           servicio TEXT,
           id_gobierno TEXT,
           id_categoria TEXT,
           id_sector TEXT,
           id_subcategoria TEXT,
           id_entidad TEXT,
           id_actividad TEXT,
           id_servicio TEXT,
           descripcion_entidad TEXT
       )''');
      },
    );
  }

  Future eliminarAccion()async{
   return await _db!.execute(
      "DELETE FROM accion",
    );
  }

  Future Login(LoginClass loginClass) async {
    initDB();
    await _db!.execute(
      "DELETE FROM login",
    );
    await _db!.execute(
      "DELETE FROM ConfigPersonal",
    );
    await _db!.execute(
      "DELETE FROM DatConfigInicio",
    );
    await eliminarProvincias();
    var a = await _db!.insert("login", loginClass.toMap());
    return a;
  }

  Future eliminarProvincias() async {
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

  Future<List<LoginClass>> loginUser() async {
    initDB();
    final res = await _db!.rawQuery("select * from login");
    List<LoginClass> list =
        res.isNotEmpty ? res.map((e) => LoginClass.fromMap(e)).toList() : [];
    return list;
  }

/*  Future createUserDemo() async {
    initDB();
    _log.i('Inicio: Creación de USUARIO DEMO');

    await _db!.execute(
      "DELETE FROM DatConfigInicio WHERE tipoUsuario = 'DEMO'",
    );
    await _db!.execute(
      "DELETE FROM ConfigPersonal WHERE tipoUsuario = 'DEMO'",
    );

    /**
     * GENERAR USUARIO DEMO
     */

    await _db!.execute(
      "INSERT INTO DatConfigInicio (idLugarPrestacion, lugarPrestacion, idUnidadesOrganicas, unidadesOrganicas, idPuesto, puesto, idUnidTerritoriales, unidTerritoriales, idTambo, nombreTambo, tipoPlataforma, snip, campania, codCampania, modalidad, tipoUsuario) VALUES (2, 'UNIDADES TERRITORIALES', 2, 'UNIDAD DE ADMINISTRACION', 1, 'GESTOR INSTITUCIONAL', 1, 'AMAZONAS', 20491, 'PUERTO PACUY', 'TAMBO', 342434, '', '0', '', 'DEMO')",
    );

    /*
    await db.execute(
      "INSERT INTO DatConfigInicio (idLugarPrestacion, lugarPrestacion, idUnidadesOrganicas, unidadesOrganicas, idPuesto, puesto, idUnidTerritoriales, unidTerritoriales, idTambo, nombreTambo, tipoPlataforma, snip, campania, codCampania, modalidad) VALUES (2, 'UNIDADES TERRITORIALES', 2, 'UNIDAD DE ADMINISTRACION', 1, 'GESTOR INSTITUCIONAL', 1, 'AMAZONAS', 20491, 'PUERTO PACUY', 'PIAS', 342434, '', '0', '1', 'DEMO')",
    );
    */

    await _db!.execute(
      "INSERT INTO ConfigPersonal (codigo, nombres, rol, fechaNacimento, numeroDni, contrasenia, apellidoPaterno, apellidoMaterno, unidad, tipoUsuario) VALUES ('', 'JULIO ARMANDO ', '', '1994-07-26', 48400113, '111222', 'VEGA', 'SALVADOR', 'UAGS', 'DEMO')",
    );
    await _db!.execute(
      "INSERT INTO ConfigPersonal (codigo, nombres, rol, fechaNacimento, numeroDni, contrasenia, apellidoPaterno, apellidoMaterno, unidad, tipoUsuario) VALUES ('CIP_92822', 'Freddy Ramos Espinoza', 'CRP', '1994-07-26', 48400113, '111222', '', '', 'UPS', 'DEMO')",
    );

    _log.i('Fin: Creación de USUARIO DEMO');
  }
*/
  Future deleteTabla() async {
    var sql = "DELETE FROM ";
    initDB();
    //ConfigPersonal
    print(_db!.execute(sql + "ConfigPersonal"));
    print(_db!.execute(sql + "DatPuesto"));
    print(_db!.execute(sql + "DatConfigInicio"));
    // print(_db!.execute("DELETE FROM DatUnidadesOrganicas"));
    // print(_db!.execute("DELETE FROM DatUnidadTerritorial"));
    print(_db!.execute("DELETE FROM DatUnidadesTablaPlataforma"));
    print(_db!.execute("DELETE FROM DatLugarPrestacion"));
    print(_db!.execute("DELETE FROM numeroTelefono"));
    print(_db!.execute("DELETE FROM ubicacionUsuario"));
    print(_db!.execute("DELETE FROM cierreUsuario"));
    print(_db!.execute("DELETE FROM funcionarios"));
    print(_db!.execute("DELETE FROM participantes"));
    print(_db!.execute("DELETE FROM partExtrangeros"));
    print(_db!.execute("DELETE FROM tramaIntervenciones"));
    print(_db!.execute("DELETE FROM tipoDocumento"));
    print(_db!.execute("DELETE FROM sexo"));
  }

//
  Future<List<ConfigPersonal>> getLoginUser({dni, contrasenia}) async {
    initDB();
    final res = await _db!.rawQuery(
        "select * from ConfigPersonal where numeroDni=$dni and contrasenia = '$contrasenia'");
    List<ConfigPersonal> list = res.isNotEmpty
        ? res.map((e) => ConfigPersonal.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<ConfigPersonal>> getValidarUsuario(
      {required int dni, fechaNacimiento}) async {
    initDB();
    print(
        "select * from ConfigPersonal where numeroDni=$dni and contrfechaNacimentoasenia = '$fechaNacimiento'");
    final res = await _db!.rawQuery(
        "select * from ConfigPersonal where numeroDni=$dni and fechaNacimento = '$fechaNacimiento'");
    List<ConfigPersonal> list = res.isNotEmpty
        ? res.map((e) => ConfigPersonal.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<int> updateUsuarioContrasenia(ConfigPersonal configPersonal) async {
    print(configPersonal.contrasenia);
    print(
        "UPDATE ConfigPersonal SET contrasenia = '${configPersonal.contrasenia}' where id = ${configPersonal.id};");
    final res = await _db?.rawQuery(
        "UPDATE ConfigPersonal SET contrasenia = '${configPersonal.contrasenia}' where id = ${configPersonal.id};");
    print(res);
    return res!.length;
  }

//////////////////////
  //Distritos

  Future<int> insertEntidadAccion(Accion accion) async {
    await DatabasePr.db.initDB();
    return _db!.insert("accion", accion.toMap());
  }

  Future<void> insertarDistritos(Distrito distrito) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("distritos", distrito.toMap()));
  }

  Future<void> insertParticipanteEjecucion(
      ParticipanteEjecucion participanteEjecucion) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("participanteEjecucion", participanteEjecucion.toMap()));
  }

  Future<List<ParticipanteEjecucion>> ListarParticipanteEjecucion(
      idProgramacion, idEntidad) async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from participanteEjecucion a where id_programacion = $idProgramacion and id_entidad = $idEntidad");
    List<ParticipanteEjecucion> list = res!.isNotEmpty
        ? res.map((e) => ParticipanteEjecucion.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<Accion>> ListarEntidadesReg() async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("SELECT * from accion");
    List<Accion> list =
        res!.isNotEmpty ? res.map((e) => Accion.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<IntentosRegistrosFallecidos>>
      ListarIntentosRegistrosFallecidos() async {
    await DatabasePr.db.initDB();
    final res =
        await _db?.rawQuery("SELECT * from intentos_registros_fallecidos");
    List<IntentosRegistrosFallecidos> list = res!.isNotEmpty
        ? res.map((e) => IntentosRegistrosFallecidos.fromMap(e)).toList()
        : [];
    return list;
  }

  Future eliminarIntentoFallecido(id) async {
    _log.i(id);
    await DatabasePr.db.initDB();
    final res = await _db
        ?.rawQuery("DELETE FROM intentos_registros_fallecidos where id = $id");
    return res;
  }

  Future eliminarIntentoFallecidos() async {
    await DatabasePr.db.initDB();
    final res =
        await _db?.rawQuery("DELETE FROM intentos_registros_fallecidos");
    return res;
  }

  Future eliminarTodoParticipanteEjecucion() async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM participanteEjecucion");
    return res;
  }

  ////////////////////////////////////
  Future<List<ListarCcpp>> ListarCcpps() async {
    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();

    for (var i = 0; i < abc.length; i++) {
      final res = await _db?.rawQuery(
          "SELECT DISTINCT * from listarCcpp where snip = ${abc[i].snip} ORDER BY nombreCcpp DESC");
      List<ListarCcpp> list =
          res!.isNotEmpty ? res.map((e) => ListarCcpp.fromMap(e)).toList() : [];
      return list;
    }
    return List.empty();
  }

  Future eliminarTodoListarCcpp() async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM listarCcpp");
    return res;
  }

  Future<void> insertarIntentoFallecido(
      IntentosRegistrosFallecidos intentosRegistrosFallecidos) async {
    await DatabasePr.db.initDB();
    print(_db!.insert(
        "intentos_registros_fallecidos", intentosRegistrosFallecidos.toMap()));
  }

  Future<void> insertCcpp(CentroPoblado listarCcpp) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("centros_poblados", listarCcpp.toMap()));
  }

  Future<void> insertlistarCcpp(ListarCcpp listarCcpp) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("listarCcpp", listarCcpp.toMap()));
  }

  Future<List<ListarEntidadFuncionario>> listarEntidadFuncionario(
      codigoInterno) async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from EntidadFuncionario a where id_programacion = $codigoInterno");
    List<ListarEntidadFuncionario> list = res!.isNotEmpty
        ? res.map((e) => ListarEntidadFuncionario.fromMap(e)).toList()
        : [];
    return list;
  }

  Future eliminarTodoEntidadFuncionario() async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM EntidadFuncionario");
    return res;
  }

  Future<void> insertEntidadFuncionario(
      ListarEntidadFuncionario tipoDocumento) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("EntidadFuncionario", tipoDocumento.toMap()));
  }

  Future insertPorcentajesEnvio(PorcentajesEnvio ser) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("porcentajesEnvio", ser.toMap()));
  }

  Future eliminarTPorcentajesEnvioPorid(i) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "DELETE FROM porcentajesEnvio where codigoIntervencion = '$i';");

    return res;
  }

  Future<List<PorcentajesEnvio>> listarPorcentajes(codigoInterno, tipo) async {
    await DatabasePr.db.initDB();
    print(
        "SELECT DISTINCT * from porcentajesEnvio a where codigoIntervencion = '$codigoInterno' and tipo = $tipo");
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from porcentajesEnvio a where codigoIntervencion = '$codigoInterno' and tipo = $tipo");
    List<PorcentajesEnvio> list = res!.isNotEmpty
        ? res.map((e) => PorcentajesEnvio.fromMap(e)).toList()
        : [];
    return list;
  }

  Future eliminarTodoAsTipoPlataforma() async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM tipoPlataforma");
    return res;
  }

  Future insertTipoPlataforma(TipoPlataforma ser) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("tipoPlataforma", ser.toMap()));
  }

  Future<List<TipoPlataforma>> getAllTipoPlataforma() async {
    List<Map<String, dynamic>> result = await _db!.query("tipoPlataforma");
    return result.map((map) => TipoPlataforma.fromMap(map)).toList();
  }

  Future deleteInter() async {
    initDB();
    print(_db!.execute("DELETE FROM tramaIntervenciones"));
  }

  Future insertServicio(ServicioProgramacionParticipante ser) async {
    print("aqquiiiii ${ser.id_programacion}");
    await DatabasePr.db.initDB();
    print(_db!.insert("servicioProgramacionParticipante", ser.toMap()));
  }

  Future<List<ServicioProgramacionParticipante>> buscarServicioParticipante(
      idProgramacionParticipanteServicio) async {
    await DatabasePr.db.initDB();
    print(
        "select id_servicio from servicioProgramacionParticipante where id_programacion_participante_servicio = $idProgramacionParticipanteServicio");
    final res = await _db?.rawQuery(
        "select * from servicioProgramacionParticipante where id_programacion_participante_servicio = $idProgramacionParticipanteServicio");
    List<ServicioProgramacionParticipante> list = res!.isNotEmpty
        ? res.map((e) => ServicioProgramacionParticipante.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<Sexo>> listarSexo() async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery("SELECT DISTINCT * from sexo");
    List<Sexo> list =
        res!.isNotEmpty ? res.map((e) => Sexo.fromMap(e)).toList() : [];
    return list;
  }

  ///listas

  Future<List<ArchivoTramaIntervencion>> listarImagenesDB(codigoInterno) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from archivoTramaIntervenciones a where codigoIntervencion = '$codigoInterno'");
    List<ArchivoTramaIntervencion> list = res!.isNotEmpty
        ? res.map((e) => ArchivoTramaIntervencion.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<Funcionarios>> listarFuncionariosDB(codigoInterno) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from funcionarios a where idProgramacion =$codigoInterno");
    List<Funcionarios> list =
        res!.isNotEmpty ? res.map((e) => Funcionarios.fromMap(e)).toList() : [];
    return list;
  }

  Future deleteEjecucion() async {
    initDB();
    print(_db!.execute("DELETE FROM funcionarios"));
    print(_db!.execute("DELETE FROM participantes"));
    print(_db!.execute("DELETE FROM partExtrangeros"));
  }

  Future deleteIntervenciones() async {
    final res = await _db?.delete("tramaIntervenciones");
    print(res);
    return res;
/*    var eliminado = await _db!.execute("DELETE FROM tramaIntervenciones");
    print("eliminar = $eliminado");
   return  eliminado;*/
  }

  Future deleteArchivoIntervenciones(codigoIntervencion, numero) async {
    print(_db!.execute(
        "DELETE FROM archivoTramaIntervenciones where codigoIntervencion = '$codigoIntervencion' and nmero = $numero"));
  }

  Future<void> insertArchivoTramaIntervencion(
      ArchivoTramaIntervencion tramaIntervencion) async {
    print(tramaIntervencion.codigoIntervencion);
    await DatabasePr.db.initDB();
    print(_db!.insert("archivoTramaIntervenciones", tramaIntervencion.toMap()));
  }

  Future<void> insertTramaIntervencionesUs(
      TramaIntervencion tramaIntervencion) async {
    print(tramaIntervencion.codigoIntervencion);
    await DatabasePr.db.initDB();
    print(_db!.insert("tramaIntervencionesUs", tramaIntervencion.toMap()));
  }

  Future eliminarTramaIntervencionesPorid(i) async {
    print('eliminar $i');
    await DatabasePr.db.initDB();
    print('eliminar $i');
    final res = await _db?.rawQuery(
        "DELETE FROM tramaIntervenciones where codigoIntervencion = '$i';");

    return res;
  }

  Future eliminarTramaIntervencionesUsPorid(i) async {
    print('eliminar $i');
    await DatabasePr.db.initDB();
    print('eliminar $i');
    final res = await _db?.rawQuery(
        "DELETE FROM tramaIntervencionesUs where codigoIntervencion = '$i';");

    return res;
  }

  Future<void> insertTramaIntervenciones(
      TramaIntervencion tramaIntervencion) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("tramaIntervenciones", tramaIntervencion.toMap()));
  }

  Future<List<TramaIntervencion>> listarIntervencionesPs() async {
    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();

    for (var i = 0; i < abc.length; i++) {
      final res = await _db?.rawQuery(
          "SELECT DISTINCT * from tramaIntervencionesUs a where snip ='${abc[i].snip}' ");
      List<TramaIntervencion> list = res!.isNotEmpty
          ? res.map((e) => TramaIntervencion.fromMap(e)).toList()
          : [];
      return list;
    }
    return List.empty();
  }

  Future<List<TramaIntervencion>> cierreTRama(codigoIntervencion) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * from tramaIntervencionesUs a where codigoIntervencion ='$codigoIntervencion' ");

    List<TramaIntervencion> list = res!.isNotEmpty
        ? res.map((e) => TramaIntervencion.fromMap(e)).toList()
        : [];
    print(list[0].codigoIntervencion);
    return list;
  }

  Future<List<TramaIntervencion>> listarInterciones({snip}) async {
    await DatabasePr.db.initDB();
    var abc = await getAllTasksConfigInicio();

    for (var i = 0; i < abc.length; i++) {



      if(abc[i].snip==0){
        final res = await _db?.rawQuery(
            "SELECT DISTINCT * from tramaIntervenciones a where snip ='$snip' and a.codigoIntervencion NOT IN (SELECT b.codigoIntervencion from tramaIntervencionesUs b) ORDER by codigoIntervencion DESC;");
        List<TramaIntervencion> list = res!.isNotEmpty
            ? res.map((e) => TramaIntervencion.fromMap(e)).toList()
            : [];
        return list;
      } else{
        final res = await _db?.rawQuery(
            "SELECT DISTINCT * from tramaIntervenciones a where snip ='${abc[i].snip}' and a.codigoIntervencion NOT IN (SELECT b.codigoIntervencion from tramaIntervencionesUs b) ORDER by codigoIntervencion DESC;");
        List<TramaIntervencion> list = res!.isNotEmpty
            ? res.map((e) => TramaIntervencion.fromMap(e)).toList()
            : [];
        return list;
      }

    }
    return List.empty();
  }

  Future eliminarArchivoPorid(i) async {
    await DatabasePr.db.initDB();
    final res = await _db
        ?.rawQuery("DELETE FROM archivoTramaIntervenciones where id = $i;");
    return res;
  }

  Future eliminarFuncionarioPorid(i) async {
    await DatabasePr.db.initDB();
    print(i);
    final res = await _db?.rawQuery("DELETE FROM funcionarios where id = $i;");

    return res;
  }

  Future eliminarParticipantesPorid(i) async {
    await DatabasePr.db.initDB();
    print(i);
    final res = await _db?.rawQuery("DELETE FROM participantes where id = $i;");

    //await _db?.rawQuery("DELETE FROM servicioProgramacionParticipante");
    await _db?.rawQuery(
        "DELETE FROM servicioProgramacionParticipante where id_programacion_participante_servicio = $i;");

    return res;
  }

  Future eliminarExtangerosPorid(i) async {
    await DatabasePr.db.initDB();
    print(i);
    final res =
        await _db?.rawQuery("DELETE FROM partExtrangeros where id = $i;");

    return res;
  }

  Future<List<PartExtrangeros>> listarPartExtrangeros(idProgramacion) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * FROM partExtrangeros where codigoIntervencion = '$idProgramacion' ORDER BY id DESC;");
    print(res);
    List<PartExtrangeros> list = res!.isNotEmpty
        ? res.map((e) => PartExtrangeros.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<int> insertPartExtrangeros(PartExtrangeros partExtrangeros) async {
    await DatabasePr.db.initDB();
    var a = await _db!.insert("partExtrangeros", partExtrangeros.toMap());
    return a;
  }

  Future<void> insertTipoDocumento(TipoDocumento tipoDocumento) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("tipoDocumento", tipoDocumento.toMap()));
  }

  Future<List<TipoDocumento>> listarTipoDocumento() async {
    await DatabasePr.db.initDB();
    final res =
        await _db?.rawQuery("SELECT * FROM tipoDocumento ORDER BY id ASC;");
    List<TipoDocumento> list = res!.isNotEmpty
        ? res.map((e) => TipoDocumento.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<List<Participantes>> buscarDni(dni, idProgramacion) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * FROM participantes where dni = '$dni' and idProgramacion =  $idProgramacion");
    List<Participantes> list = res!.isNotEmpty
        ? res.map((e) => Participantes.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<List<Funcionarios>> buscarDniFuncioario(dni, idProgramacion) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT dni FROM funcionarios where dni = '$dni' and idProgramacion =  $idProgramacion");
    List<Funcionarios> list =
        res!.isNotEmpty ? res.map((e) => Funcionarios.fromMap(e)).toList() : [];

    return list;
  }

  Future<int> insertParticipantes(Participantes participantes) async {
    await DatabasePr.db.initDB();
    print(participantes.toMap());
    var a = await _db!.insert("participantes", participantes.toMap());
    await DatabaseParticipantes.db.initDB();
    var ar = await DatabaseParticipantes.db
        .getUsuarioParticipanteDniSQLites(participantes.dni);
    print("aaassss ${ar.length}");
    if (ar.length == 0) {
      ParticipantesIntervenciones participantesIntervenciones =
          ParticipantesIntervenciones();
      participantesIntervenciones.dNI = participantes.dni;
      participantesIntervenciones.pRIMERNOMBRE = participantes.primerNombre;
      participantesIntervenciones.sEGUNDONOMBRE = participantes.segundoNombre;
      participantesIntervenciones.aPELLIDOPATERNO =
          participantes.apellidoPaterno;
      participantesIntervenciones.aPELLIDOMATERNO =
          participantes.apellidoMaterno;
      participantesIntervenciones.sEXO = participantes.sexo;
      participantesIntervenciones.fECHANACIMIENTO =
          participantes.fechaNacimiento;
      await DatabaseParticipantes.db
          .insertParticipantesIntervencionesMovil(participantesIntervenciones);
    }

    return a;
  }

  Future<List<Participantes>> listarParticipantes(idProgramacion, tipo) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT * FROM participantes where idProgramacion =  $idProgramacion AND tipo ='$tipo' ORDER BY id DESC;");
    List<Participantes> list = res!.isNotEmpty
        ? res.map((e) => Participantes.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<void> insertFuncionario(Funcionarios funcionarios) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("funcionarios", funcionarios.toMap()));
  }

  Future<List<Funcionarios>> listarFuncionarios(idProgramacion) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery(
        "SELECT DISTINCT * FROM funcionarios where idProgramacion = $idProgramacion ORDER BY id ASC;");
    print("resres");
    print(res);
    print(res!.isNotEmpty
        ? res.map((e) => Funcionarios.fromMap(e)).toList()
        : []);
    List<Funcionarios> list =
        res.isNotEmpty ? res.map((e) => Funcionarios.fromMap(e)).toList() : [];
    print("sss $list");
    return list;
  }

  Future borrar() async {
    print(_db!.execute("DELETE FROM funcionarios"));
  }

//Insert

  Future<void> insertInfoTel(InfoTelefono infoTelefono) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("infoTelefono", infoTelefono.toMap()));
  }

  Future<List<InfoTelefono>> getAllInfoTel() async {
    List<Map<String, dynamic>> result = await _db!.query("infoTelefono");
    //  print(result[0].toString());
    return result.map((map) => InfoTelefono.fromMap(map)).toList();
  }

  Future<void> inserAsistencia(AsistenciaModel asistenciaModel) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("asistencia", asistenciaModel.toMap()));
  }

  Future inserCierreUsuario(CierreUsuario asistenciaModel) async {
    await DatabasePr.db.initDB();

    return _db!.insert("cierreUsuario", asistenciaModel.toMap());
  }

  Future<void> inserUbicacionUsuario(UbicacionUsuario asistenciaModel) async {
    await DatabasePr.db.initDB();

    print(_db!.insert("ubicacionUsuario", asistenciaModel.toMap()));
  }

  Future<List<UbicacionUsuario>> getAllUbicacionUsuario() async {
    List<Map<String, dynamic>> result = await _db!.query("ubicacionUsuario");
    //  print(result[0].toString());
    return result.map((map) => UbicacionUsuario.fromMap(map)).toList();
  }

  Future<List<AsistenciaModel>> listarasistencia() async {
    await DatabasePr.db.initDB();

    final res =
        await _db?.rawQuery("SELECT * FROM asistencia ORDER BY id ASC;");

    List<AsistenciaModel> list = res!.isNotEmpty
        ? res.map((e) => AsistenciaModel.fromMap(e)).toList()
        : [];

    return list;
  }

  Future<List<AsistenciaModel>> listaraEstado() async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery(
        "SELECT * FROM asistencia where isSelected = 1 ORDER BY id ASC;");

    List<AsistenciaModel> list = res!.isNotEmpty
        ? res.map((e) => AsistenciaModel.fromMap(e)).toList()
        : [];

    return list;
  }

  Future eliminarPorid(i) async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery("DELETE FROM asistencia where id = $i;");

    return res;
  }
  Future eliminarPoridAccion(i) async {
    await DatabasePr.db.initDB();
    final res = await _db?.rawQuery("DELETE FROM accion where id = $i;");
    return res;
  }

  Future eliminarTodoAsistencia() async {
    await DatabasePr.db.initDB();

    final res = await _db?.rawQuery("DELETE FROM asistencia");

    return res;
  }

  Future<List<AsistenciaModel>> getDtjsGRC() async {
    await DatabasePr.db.initDB();
    //GuiaRemClienteM guiaRemClienteM;
    final res =
        await _db?.rawQuery("SELECT * FROM asistencia ORDER BY id ASC;");

    List<AsistenciaModel> list = res!.isNotEmpty
        ? res.map((e) => AsistenciaModel.fromJson(e)).toList()
        : [];

    return list;
  }

  Future updateAsistencia(ise, i) async {
    await DatabasePr.db.initDB();

    final res = await _db
        ?.rawQuery("UPDATE asistencia SET isSelected = $ise where id = $i;");

    return res;
  }

  Future updateAsistencias(ise, i) async {
    await DatabasePr.db.initDB();

    final res = await _db
        ?.rawQuery("  update asistencia set isSelected = $ise where id<>$i");

    return res;
  }

  Future<void> deleteTipoDocumento() async {
    await DatabasePr.db.initDB();
    await _db?.rawQuery("DELETE FROM tipoDocumento");
  }

  Future<void> deletesexo() async {
    await DatabasePr.db.initDB();
    await _db?.rawQuery("DELETE FROM sexo");
  }

  Future<void> insertSexo(Sexo sexo) async {
    await DatabasePr.db.initDB();
    print(_db!.insert("sexo", sexo.toMap()));
  }

  Future<int> insertConfigPersonal(ConfigPersonal regitroCalificada) async {
    var a = await _db!.insert("ConfigPersonal", regitroCalificada.toMap());

    return a;
    // print(_db!.insert("ConfigPersonal", regitroCalificada.toMap()));
  }

  Future<void> insertInicial(ConfigInicio regitroCalificada) async {
    print(_db!.insert("DatConfigInicio", regitroCalificada.toMap()));
  }

  Future<void> insertConfigInicio(ConfigInicio regitroCalificada) async {
    print(_db!.insert("DatConfigInicio", regitroCalificada.toMap()));
  }

  Future<void> insertPuesto(Puesto regitroCalificada) async {
    print(_db!.insert("DatPuesto", regitroCalificada.toMap()));
  }

  Future<void> insertNmTelef(NumerosTelef regitroCalificada) async {
    print(_db!.insert("numeroTelefono", regitroCalificada.toMap()));
  }

  Future<void> insertProvincia(Provincia regitroCalificada) async {
    print(_db!.insert("provincias", regitroCalificada.toMap()));
  }

/*  Future<void> insertUnidadesTerritoriales(
      UnidadesTerritoriales regitroCalificada) async {
    print(_db!.insert("DatUnidadTerritorial", regitroCalificada.toMap()));
  }
*/
  Future<void> insertLugarPrestacion(LugarPrestacion regitroCalificada) async {
    print(_db!.insert("DatLugarPrestacion", regitroCalificada.toMap()));
  }

  Future<void> insertasistencia(AsistenciaClass regitroCalificada) async {
    print(_db!.insert("asistenciaClass", regitroCalificada.toMap()));
  }

  Future<void> updateasistencia(AsistenciaClass regitroCalificada) async {
    print(_db!.update("asistenciaClass", regitroCalificada.toMap()));
  }

//ConfigPersonal

  Future<List<Provincia>> getProvincias() async {
    List<Map<String, dynamic>> result = await _db!.query("provincias");
    //  print(result[0].toString());
    return result.map((map) => Provincia.fromMap(map)).toList();
  }

  Future<List<Distrito>> getDistrito(ubigeo) async {
    initDB();
    final res = await _db!.rawQuery(
        "SELECT * FROM distritos  where SUBSTR(distrito_ubigeo, 1, 4) ='$ubigeo'");
    List<Distrito> list =
        res.isNotEmpty ? res.map((e) => Distrito.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<CentroPoblado>> getCentroPoblado(ubigeo) async {
    initDB();
    print(
        "SELECT * FROM centros_poblados  where SUBSTR(centro_poblado_ubigeo, 1, 6) ='$ubigeo'");
    final res = await _db!.rawQuery(
        "SELECT * FROM centros_poblados  where SUBSTR(centro_poblado_ubigeo, 1, 6) ='$ubigeo'");
    List<CentroPoblado> list = res.isNotEmpty
        ? res.map((e) => CentroPoblado.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<ConfigPersonal>> getAllConfigPersonal() async {
    List<Map<String, dynamic>> result = await _db!.query("ConfigPersonal");
    //  print(result[0].toString());
    return result.map((map) => ConfigPersonal.fromMap(map)).toList();
  }

  Future<List<LugarPrestacion>> getAllTasksLugarPrestacion() async {
    List<Map<String, dynamic>> result = await _db!.query("DatLugarPrestacion");
    //  print(result[0].toString());
    return result.map((map) => LugarPrestacion.fromMap(map)).toList();
  }

  Future updateTaskLugarPrestacion(LugarPrestacion task) async {
    _db!.update("DatLugarPrestacion", task.toMap(),
        where: "id = ?", whereArgs: [task.idLugarPrestacion]);
  }

  Future<List<LugarPrestacion>> getTodosLugarPrestacion() async {
    final res = await _db!.query('DatLugarPrestacion');
    List<LugarPrestacion> list = res.isNotEmpty
        ? res.map((e) => LugarPrestacion.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<UnidadesTerritoriales>> getAllTasks() async {
    List<Map<String, dynamic>> result =
        await _db!.query("DatUnidadTerritorial");
    return result.map((map) => UnidadesTerritoriales.fromMap(map)).toList();
  }

/*
  Future updateTask(UnidadesTerritoriales task) async {
    _db!.update("DatUnidadTerritorial", task.toMap(),
        where: "id = ?", whereArgs: [task.id_UnidadesTerritoriales]);
  }

  Future<List<UnidadesTerritoriales>> getAllTasksUnidadesTerritoriales() async {
    List<Map<String, dynamic>> result =
        await _db!.query("DatUnidadTerritorial");
    return result.map((map) => UnidadesTerritoriales.fromMap(map)).toList();
  }

  Future updateTaskUnidadesTerritoriales(UnidadesTerritoriales task) async {
    _db!.update("DatUnidadTerritorial", task.toMap(),
        where: "id = ?", whereArgs: [task.id_UnidadesTerritoriales]);
  }
*/
//traertodos
  Future<List<NumerosTelef>> getAllNumerosTelf() async {
    initDB();
    List<Map<String, dynamic>> result = await _db!.query("numeroTelefono");

    return result.map((map) => NumerosTelef.fromMap(map)).toList();
  }

  Future<List<ConfigInicio>> getAllTasksConfigInicio() async {
    initDB();
    List<Map<String, dynamic>> result = await _db!.query("DatConfigInicio");
    return result.map((map) => ConfigInicio.fromMap(map)).toList();
  }

  Future<List<ConfigInicio>> getTodosConfigInicio() async {
    initDB();

    final res = await _db!.query('DatConfigInicio');
    List<ConfigInicio> list =
        res.isNotEmpty ? res.map((e) => ConfigInicio.fromJson(e)).toList() : [];
    return list;
  }

  Future<List<AsistenciaClass>> getAllasistenciaClass() async {
    List<Map<String, dynamic>> result = await _db!.query("asistenciaClass");
    return result.map((map) => AsistenciaClass.fromMap(map)).toList();
  }

//update

  Future updateTaskConfigInicio(ConfigInicio task) async {
    _db!.update("DatConfigInicio", task.toMap(),
        where: "idConfigInicio = ?", whereArgs: [task.idConfigInicio]);
  }

  Future<void> insertUnidadesTablaPlataforma(
      UnidadesTablaPlataforma regitroCalificada) async {
    _db!.insert("DatUnidadesTablaPlataforma", regitroCalificada.toMap());
  }

  Future<List<UnidadesTablaPlataforma>>
      getAllTasksUnidadesTablaPlataforma() async {
    List<Map<String, dynamic>> result =
        await _db!.query("DatUnidadesTablaPlataforma");
    return result.map((map) => UnidadesTablaPlataforma.fromMap(map)).toList();
  }

  Future updateTaskUnidadesTablaPlataforma(UnidadesTablaPlataforma task) async {
    _db!.update("DatUnidadesTablaPlataforma", task.toMap(),
        where: "id = ?", whereArgs: [task.ID_UNIDAD_TERRITORIAL]);
  }

  Future<List<UnidadesTablaPlataforma>>
      getTodosUnidadesTablaPlataforma() async {
    initDB();

    final res = await _db!.query('DatUnidadesTablaPlataforma');
    print(res);
    List<UnidadesTablaPlataforma> list = res.isNotEmpty
        ? res.map((e) => UnidadesTablaPlataforma.fromJson(e)).toList()
        : [];
    print(list[0].toString());
    return list;
  }

  Future<List<UnidadesTablaPlataforma>> getporidUnidadTeritoria(
      int unidadTeritorial) async {
    initDB();
    final res = await _db!.rawQuery(
        "SELECT * FROM DatUnidadesTablaPlataforma WHERE ID_UNIDAD_TERRITORIAL=$unidadTeritorial");
    List<UnidadesTablaPlataforma> list = res.isNotEmpty
        ? res.map((e) => UnidadesTablaPlataforma.fromMap(e)).toList()
        : [];
    return list;
  }

  Future<List<Puesto>> getAllTasksPuesto() async {
    initDB();
    List<Map<String, dynamic>> result = await _db!.query("DatPuesto");
    //  print(result[0].toString());
    return result.map((map) => Puesto.fromMap(map)).toList();
  }

  Future updateTaskPuesto(Puesto task) async {
    _db!.update("DatPuesto", task.toMap(),
        where: "id = ?", whereArgs: [task.idPuesto]);
  }

  Future<List<Puesto>> getTodosPuesto() async {
    initDB();

    final res = await _db!.query('DatPuesto');
    print(res);
    List<Puesto> list =
        res.isNotEmpty ? res.map((e) => Puesto.fromJson(e)).toList() : [];
    print(list[0].toString());
    return list;
  }

  traerSnip() async {
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    return abc[0].snip;
  }

  traerConfiguracionInicio() async {
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
   // return abc[].unidTerritoriales;
    return abc;
  }
/*  Future<void> insertUnidadesOrganicas(
      UnidadesOrganicas regitroCalificada) async {
    //print("hola");
    initDB();
    print(_db!.insert("DatUnidadesOrganicas", regitroCalificada.toMap()));
  }
*/
/*Future<List<UnidadesOrganicas>> getAllTasksUnidadesOrganicas() async {
    List<Map<String, dynamic>> result =
        await _db!.query("DatUnidadesOrganicas");
    //  print(result[0].toString());
    return result.map((map) => UnidadesOrganicas.fromMap(map)).toList();
  }*/

/*  Future updateTaskUnidadesOrganicas(UnidadesOrganicas task) async {
    _db!.update("DatUnidadesOrganicas", task.toMap(),
        where: "id = ?", whereArgs: [task.IDUO]);
  }*/

/*  Future<List<UnidadesOrganicas>> getTodosUnidadesOrganicas() async {
    initDB();

    final res = await _db!.query('DatUnidadesOrganicas');
    List<UnidadesOrganicas> list = res.isNotEmpty
        ? res.map((e) => UnidadesOrganicas.fromJson(e)).toList()
        : [];
    return list;
  }
*/
/*  Future<List<UnidadesTerritoriales>> getTodosUnidadesTeritoriales() async {
    initDB();

    final res = await _db!.query('DatUnidadTerritorial');
    print(res);

    List<UnidadesTerritoriales> list = res.isNotEmpty
        ? res.map((e) => UnidadesTerritoriales.fromJson(e)).toList()
        : [];
    print(list[0].toString());
    return list;
  }*/
}
