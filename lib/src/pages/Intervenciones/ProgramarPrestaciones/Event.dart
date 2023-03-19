// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Evento {
  final String idProgramacion;
  final DateTime fecha;
  final String descripcion;
  final String idPlataforma;
  final String plataformaDescripcion;
  final String tipoProgramacion;
  final String estadoProgramacion;
  final String puntos;
  final String idUnidadesTerritoriales;

  Evento({
    required this.idProgramacion,
    required this.fecha,
    required this.descripcion,
    required this.idPlataforma,
    required this.plataformaDescripcion,
    required this.tipoProgramacion,
    required this.estadoProgramacion,
    required this.puntos,
    required this.idUnidadesTerritoriales,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idProgramacion: json['id_programacion'],
      fecha: DateTime.parse(json['fecha']),
      descripcion: json['descripcion'],
      idPlataforma: json['id_plataforma'],
      plataformaDescripcion: json['plataforma_descripcion'],
      tipoProgramacion: json['tipo_programacion'],
      estadoProgramacion: json['estado_programacion'],
      puntos: json['puntos'],
      idUnidadesTerritoriales: json['id_unidades_territoriales'],
    );
  }
}
/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);