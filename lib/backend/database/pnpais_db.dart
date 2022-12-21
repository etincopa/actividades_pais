import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePnPais {
  static final DatabasePnPais instance = DatabasePnPais._init();

  static Database? _database;
  static const _version = 1;

  final createTable = 'CREATE TABLE';
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT';
  final boolType = 'BOOLEAN';
  final integerType = 'INTEGER';
  final notNull = 'NOT NULL';
  final sLimit = "LIMIT [limit]";
  final sOffset = "OFFSET [offset]";

  DatabasePnPais._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pnpais.db');
    return _database!;
  }

  Future<Database> _initDB(
    String filePath,
  ) async {
    //Directory directory = await getApplicationDocumentsDirectory();
    //String path = join(directory.path, filePath);

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _insertDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _insertDB(
    Database db,
    int version,
  ) async {
    var constFields = '''
      ${MonitorFields.id} $idType, 
      ${MonitorFields.time} $textType,
      ${MonitorFields.isEdit} $boolType $notNull
      ''';

    await db.execute('''
    $createTable $tableNameUsers ( 
      $constFields,

      ${UserFields.codigo} $textType $notNull,
      ${UserFields.nombres} $textType $notNull,
      ${UserFields.rol} $textType $notNull,
      ${UserFields.clave} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameTramaMonitoreos ( 
      $constFields,

      ${MonitorFields.item} $textType,
      ${MonitorFields.idMonitoreo} $textType,
      ${MonitorFields.idEstadoMonitoreo} $textType,
      ${MonitorFields.estadoMonitoreo} $textType,
      ${MonitorFields.idUsuario} $textType,
      ${MonitorFields.usuario} $textType,
      ${MonitorFields.idRol} $textType,
      ${MonitorFields.rol} $textType,
      ${MonitorFields.tambo} $textType,
      ${MonitorFields.snip} $textType,
      ${MonitorFields.cui} $textType,
      ${MonitorFields.fechaMonitoreo} $textType,
      ${MonitorFields.avanceFisicoAcumulado} $textType,
      ${MonitorFields.idEstadoAvance} $textType,
      ${MonitorFields.estadoAvance} $textType,
      ${MonitorFields.actividadPartidaEjecutada} $textType,
      ${MonitorFields.idAvanceFisicoPartida} $textType,
      ${MonitorFields.avanceFisicoPartida} $textType,
      ${MonitorFields.observaciones} $textType,
      ${MonitorFields.imgActividad} $textType,
      ${MonitorFields.imgActividad1} $textType,
      ${MonitorFields.imgActividad2} $textType,
      ${MonitorFields.imgActividad3} $textType,
      ${MonitorFields.imgActividad4} $textType,
      ${MonitorFields.problemaIdentificado} $textType,
      ${MonitorFields.idProblemaIdentificado} $textType,
      ${MonitorFields.imgProblema} $textType,
      ${MonitorFields.imgProblema1} $textType,
      ${MonitorFields.imgProblema2} $textType,
      ${MonitorFields.imgProblema3} $textType,
      ${MonitorFields.imgProblema4} $textType,
      ${MonitorFields.alternativaSolucion} $textType,
      ${MonitorFields.idAlternativaSolucion} $textType,
      ${MonitorFields.riesgoIdentificado} $textType,
      ${MonitorFields.idRiesgoIdentificado} $textType,
      ${MonitorFields.imgRiesgo} $textType,
      ${MonitorFields.imgRiesgo1} $textType,
      ${MonitorFields.imgRiesgo2} $textType,
      ${MonitorFields.imgRiesgo3} $textType,
      ${MonitorFields.imgRiesgo4} $textType,
      ${MonitorFields.fechaTerminoEstimado} $textType,
      ${MonitorFields.latitud} $textType,
      ${MonitorFields.longitud} $textType,
      ${MonitorFields.txtIpReg} $textType,
      ${MonitorFields.fechaInicio} $textType,
      ${MonitorFields.fechaFin} $textType,
      ${MonitorFields.nomEstado} $textType,
      ${MonitorFields.nivelRiesgo} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameTramaProyectos ( 
      $constFields,

      ${TramaProyectoFields.numSnip} $textType,
      ${TramaProyectoFields.cui} $textType,
      ${TramaProyectoFields.latitud} $textType,
      ${TramaProyectoFields.longitud} $textType,
      ${TramaProyectoFields.departamento} $textType,
      ${TramaProyectoFields.provincia} $textType,
      ${TramaProyectoFields.distrito} $textType,
      ${TramaProyectoFields.tambo} $textType,
      ${TramaProyectoFields.centroPoblado} $textType,
      ${TramaProyectoFields.estado} $textType,
      ${TramaProyectoFields.subEstado} $textType,
      ${TramaProyectoFields.estadoSaneamiento} $textType,
      ${TramaProyectoFields.modalidad} $textType,
      ${TramaProyectoFields.fechaInicio} $textType,
      ${TramaProyectoFields.fechaTerminoEstimado} $textType,
      ${TramaProyectoFields.inversion} $textType,
      ${TramaProyectoFields.costoEjecutado} $textType,
      ${TramaProyectoFields.costoEstimadoFinal} $textType,
      ${TramaProyectoFields.avanceFisico} $textType,
      ${TramaProyectoFields.residente} $textType,
      ${TramaProyectoFields.supervisor} $textType,
      ${TramaProyectoFields.crp} $textType,
      ${TramaProyectoFields.codResidente} $textType,
      ${TramaProyectoFields.codSupervisor} $textType,
      ${TramaProyectoFields.codCrp} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameProgramacionActividad ( 
      $constFields,

      ${ProgramacionActividadFields.idProgramacionIntervenciones} $textType,
      ${ProgramacionActividadFields.estadoProgramacion} $textType,
      ${ProgramacionActividadFields.programacionActividades} $textType,
      ${ProgramacionActividadFields.accion} $textType,
      ${ProgramacionActividadFields.tipoUsuario} $textType,
      ${ProgramacionActividadFields.sector} $textType,
      ${ProgramacionActividadFields.programa} $textType,
      ${ProgramacionActividadFields.tipoActividad} $textType,
      ${ProgramacionActividadFields.descripcionActividad} $textType,
      ${ProgramacionActividadFields.articulacionOrientadaA} $textType,
      ${ProgramacionActividadFields.fecha} $textType,
      ${ProgramacionActividadFields.horaInicio} $textType,
      ${ProgramacionActividadFields.horaFin} $textType,
      ${ProgramacionActividadFields.descripcionDelEvento} $textType,
      ${ProgramacionActividadFields.documentoQueAcreditaElEvento} $textType,
      ${ProgramacionActividadFields.dondeSeRealizoElEvento} $textType,
      ${ProgramacionActividadFields.adjuntarArchivo} $textType,
      ${ProgramacionActividadFields.anio} $textType,
      ${ProgramacionActividadFields.convenio} $textType,
      ${ProgramacionActividadFields.detalleNecesidades} $textType,
      ${ProgramacionActividadFields.laIntervencionRespondeAUnConvenio} $textType,
      ${ProgramacionActividadFields.laIntervencionesPerteneceA} $textType,
      ${ProgramacionActividadFields.ndePersonasConvocadasAParticiparEnElEvento} $textType,
      ${ProgramacionActividadFields.nplanDeTrabajo} $textType,
      ${ProgramacionActividadFields.perteneceAUnPlanDeTrabajo} $textType,
      ${ProgramacionActividadFields.plataforma} $textType,
      ${ProgramacionActividadFields.progrmacionParaOtroTambio} $textType,
      ${ProgramacionActividadFields.tipoAccion} $textType,
      ${ProgramacionActividadFields.tipoPlanDeTrabajo} $textType,
      ${ProgramacionActividadFields.unidadTerritoria} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameRegistroActividadEntidad ( 
      $constFields,

      ${RegistroEntidadActividadFields.idRegistroEntidadesYActividades} $textType,
      ${RegistroEntidadActividadFields.idProgramacionIntervenciones} $textType,
      ${RegistroEntidadActividadFields.tambo} $textType,
      ${RegistroEntidadActividadFields.distrito} $textType,
      ${RegistroEntidadActividadFields.provincia} $textType,
      ${RegistroEntidadActividadFields.departamento} $textType,
      ${RegistroEntidadActividadFields.fecha} $textType,
      ${RegistroEntidadActividadFields.horaInicio} $textType,
      ${RegistroEntidadActividadFields.horaFin} $textType,
      ${RegistroEntidadActividadFields.descripcion} $textType,
      ${RegistroEntidadActividadFields.categoria} $textType,
      ${RegistroEntidadActividadFields.descripcionDeLaActividadProgramada} $textType,
      ${RegistroEntidadActividadFields.programa} $textType,
      ${RegistroEntidadActividadFields.sector} $textType,
      ${RegistroEntidadActividadFields.servicio} $textType,
      ${RegistroEntidadActividadFields.subCategoria} $textType,
      ${RegistroEntidadActividadFields.tipoActividad} $textType,
      ${RegistroEntidadActividadFields.tipoDeUsuario} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameComboItem ( 
      $constFields,
      
      ${ComboItemFields.idTypeItem} $textType,
      ${ComboItemFields.codigo1} $textType,
      ${ComboItemFields.codigo2} $textType,
      ${ComboItemFields.descripcion} $textType
      )
    ''');

    /*
    var tableNames = (await db
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
      .map((row) => row['name'] as String)
      .toList(growable: false);*/
    /*
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
    */
  }

  Future deleteAllData() async {
    final db = await instance.database;
    db.execute("DELETE FROM $tableNameRegistroActividadEntidad");
    db.execute("DELETE FROM $tableNameProgramacionActividad");
    db.execute("DELETE FROM $tableNameTramaProyectos");
    db.execute("DELETE FROM $tableNameTramaMonitoreos");
  }

  Future deleteMonitorByEstadoENV() async {
    final db = await instance.database;
    db.execute(
        "DELETE FROM $tableNameTramaMonitoreos WHERE ${MonitorFields.estadoMonitoreo} = '${TramaMonitoreoModel.sEstadoENV}'");
  }

  Future _upgradeDB(
    Database db,
    int oldversion,
    int newversion,
  ) async {
    if (oldversion < newversion) {
      print("Version Upgrade");
    }
  }

  Future<List<ComboItemModel>> readAllComboItemByType(
    String sType,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${ComboItemFields.idTypeItem} ASC';

    dynamic result;

    String sWhere = '${ComboItemFields.idTypeItem} = ?';

    if (sWhere == '') return [];

    if (limit! > 0) {
      if (sType != '') {
        result = await db.query(
          tableNameComboItem,
          where: sWhere,
          whereArgs: [sType.toUpperCase()],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameComboItem,
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (sType != '') {
        result = await db.query(
          tableNameComboItem,
          where: sWhere,
          whereArgs: [sType.toUpperCase()],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameComboItem,
          orderBy: orderBy,
        );
      }
    }

    if (result.length == 0) return [];
    return result
        .map<ComboItemModel>((json) => ComboItemModel.fromJson(json))
        .toList();
  }

  /// PROYECTO
  Future<List<TramaProyectoModel>> readAllProyecto(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaProyectoFields.numSnip} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaProyectos,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaProyectos,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy =
        '${TramaProyectoFields.avanceFisico} ASC, ${TramaProyectoFields.numSnip} ASC';

    dynamic result;

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    if (sWhere == '') return [];

    if (limit! > 0) {
      if (search != '') {
        sWhere =
            '$sWhere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere = ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (search != '') {
        sWhere =
            '$sWhere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere = ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
        );
      }
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy =
        '${TramaProyectoFields.avanceFisico} ASC, ${TramaProyectoFields.numSnip} ASC';

    dynamic result;

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    if (sWhere == '') return [];

    if (limit! > 0) {
      if (search != '') {
        sWhere =
            '$sWhere != ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere != ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (search != '') {
        sWhere =
            '$sWhere != ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere != ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
        );
      }
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAProyectoByCUI(
    String sId,
  ) async {
    final db = await instance.database;

    dynamic result = await db.query(
      tableNameTramaProyectos,
      where: '${TramaProyectoFields.cui} = ?',
      whereArgs: [sId],
    );

    if (result.length == 0) return List.empty();
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readMonitoreoByTypePartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    final db = await instance.database;

    final orderBy = '${MonitorFields.fechaMonitoreo} ASC';

    dynamic result = await db.query(
      tableNameTramaMonitoreos,
      where:
          '${MonitorFields.snip} = ? AND ${MonitorFields.idAvanceFisicoPartida} = ?',
      whereArgs: [o.numSnip, sTypePartida],
      orderBy: orderBy,
    );

    if (result.length == 0) return List.empty();
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readMonitoreoByIdMonitor(
    String sIdMonitoreo,
  ) async {
    final db = await instance.database;

    dynamic result = await db.query(
      tableNameTramaMonitoreos,
      where: '${MonitorFields.idMonitoreo} = ?',
      whereArgs: [sIdMonitoreo],
    );

    if (result.length == 0) return List.empty();
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<TramaProyectoModel> insertProyecto(
    TramaProyectoModel o,
  ) async {
    final db = await instance.database;
    final id = await db.insert(
      tableNameTramaProyectos,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> readAllMonitoreoPorEnviar(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    final db = await instance.database;
    final orderBy = '${MonitorFields.idMonitoreo} ASC';

    String sWhere = '${MonitorFields.idEstadoMonitoreo} = ?';
    List<Object?> arg = [TramaMonitoreoModel.sIdEstadoPEN];
    if (o!.cui != "") {
      sWhere = '$sWhere AND ${MonitorFields.cui} = ?';
      arg.add(o.cui);
    }

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: sWhere,
        whereArgs: arg,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: sWhere,
        whereArgs: arg,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${MonitorFields.idMonitoreo} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${MonitorFields.idMonitoreo} ASC';

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    String sQuery = '''
    
    SELECT 
      a.*,
      b.${TramaProyectoFields.codResidente},
      b.${TramaProyectoFields.codSupervisor},
      b.${TramaProyectoFields.codCrp}
    FROM $tableNameTramaMonitoreos AS a  
    LEFT JOIN $tableNameTramaProyectos AS b 
           ON b.${TramaProyectoFields.cui} = a.${MonitorFields.cui}
    WHERE b.$sWhere != ?
    ORDER BY a.$orderBy

    ''';

    dynamic result;
    if (limit! > 0) {
      result = await db.rawQuery(sQuery, [o.codigo]);
    } else {
      result = await db.rawQuery(sQuery, [o.codigo]);
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllMonitoreoByIdProyecto(
    int? limit,
    int? offset,
    TramaProyectoModel o,
  ) async {
    final db = await instance.database;
    final orderBy = '${MonitorFields.idMonitoreo} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${MonitorFields.cui} = ?',
        whereArgs: [o.cui],
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${MonitorFields.cui} = ?',
        whereArgs: [o.cui],
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<ComboItemModel> insertMaestra(
    ComboItemModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateMaestra(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameComboItem,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<int> updateMaestra(
    ComboItemModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameComboItem,
      o.toJson(),
      where: '${ComboItemFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<TramaMonitoreoModel> insertMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateMonitoreo(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameTramaMonitoreos,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<int> updateMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameTramaMonitoreos,
      o.toJson(),
      where: '${MonitorFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteMonitoreo(
    int i,
  ) async {
    final db = await instance.database;
    return await db.delete(
      tableNameTramaMonitoreos,
      where: '${MonitorFields.id} = ?',
      whereArgs: [i],
    );
  }

  Future<int> deleteProgramaIntervencionDb(
    int i,
  ) async {
    final db = await instance.database;
    return await db.delete(
      tableNameProgramacionActividad,
      where: '${ProgramacionActividadFields.id} = ?',
      whereArgs: [i],
    );
  }

  /// USUARIO APP

  Future<List<UserModel>> readAllUser(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${UserFields.time} ASC';
    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameUsers,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameUsers,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> readUserByCode(
    String i,
  ) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.codigo} = ?',
      whereArgs: [i],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('Codigo $i no encontrado');
    }
  }

  Future<UserModel> insertUser(
    UserModel o,
  ) async {
    final db = await instance.database;
    final id = await db.insert(
      tableNameUsers,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  Future<int> updateUser(
    UserModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameUsers,
      o.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<List<ProgramacionActividadModel>> readProgramaIntervencion(
    String? id,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${ProgramacionActividadFields.time} ASC';
    dynamic result;

    if (id != "") {
      result = await db.query(
        tableNameProgramacionActividad,
        columns: ProgramacionActividadFields.values,
        where:
            '${ProgramacionActividadFields.idProgramacionIntervenciones} = ?',
        whereArgs: [id],
      );

      if (result.length > 0) {
        var aProg = result
            .map<ProgramacionActividadModel>(
                (json) => ProgramacionActividadModel.fromJson(json))
            .toList();

        var aRegAct = await db.query(
          tableNameRegistroActividadEntidad,
          columns: RegistroEntidadActividadFields.values,
          where:
              '${RegistroEntidadActividadFields.idProgramacionIntervenciones} = ?',
          whereArgs: [id],
        );

        if (aRegAct.length > 0) {
          var aFormat = aRegAct
              .map<RegistroEntidadActividadModel>(
                  (json) => RegistroEntidadActividadModel.fromJson(json))
              .toList();

          for (var oProg in aProg) {
            oProg.registroEntidadActividades = aFormat
                .where(
                  (e) => (e.idProgramacionIntervenciones ==
                      oProg.idProgramacionIntervenciones),
                )
                .toList();
          }
        }

        return aProg;
      }
    } else if (limit! > 0) {
      result = await db.query(
        tableNameProgramacionActividad,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameProgramacionActividad,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<ProgramacionActividadModel>(
            (json) => ProgramacionActividadModel.fromJson(json))
        .toList();
  }

  Future<ProgramacionActividadModel> insertProgramaIntervencion(
    ProgramacionActividadModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateProgramaIntervencion(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameProgramacionActividad,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<int> updateProgramaIntervencion(
    ProgramacionActividadModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameProgramacionActividad,
      o.toJson(),
      where: '${ProgramacionActividadFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<RegistroEntidadActividadModel> insertRegistroEntidadActividad(
    RegistroEntidadActividadModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateRegistroEntidadActividad(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameRegistroActividadEntidad,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<List<RegistroEntidadActividadModel>>
      insertRegistroEntidadActividadMasive(
    List<RegistroEntidadActividadModel> a,
  ) async {
    var result = await insertMasive(
        tableNameRegistroActividadEntidad, a, RegistroEntidadActividadFields);

    List<RegistroEntidadActividadModel> aResp = [];
    result.forEach((element) {
      aResp.add(element);
    });

    //result.cast<RegistroEntidadActividadModel>()
    return aResp;
  }

  Future<int> updateRegistroEntidadActividad(
    RegistroEntidadActividadModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameRegistroActividadEntidad,
      o.toJson(),
      where: '${RegistroEntidadActividadFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<List<dynamic>> insertMasive(
    String table,
    List<dynamic> aObject,
    dynamic oFiel,
  ) async {
    List<dynamic> listRes = [];

    final db = await instance.database;
    await db.transaction((txn) async {
      aObject.forEach((o) async {
        if (o.id != null && o.id! > 0) {
          txn.update(
            table,
            o.toJson(),
            where: '${oFiel.id} = ?',
            whereArgs: [o.id],
          );
          var oRep = o.copy(id: o.id);
          listRes.add(oRep);
        } else {
          var id = await txn.insert(
            table,
            o.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          var oRep = o.copy(id: id);
          listRes.add(oRep);
        }
      });
    });

    return listRes;
  }

  Future close() async {
    /**
     extends State<NotesPage> { ...
     @override
      void dispose() {
        DatabasePnPais.instance.close();
        Get.delete<MainController>();
        super.dispose();
      }
     */
    final db = await instance.database;
    db.close();
  }
}
