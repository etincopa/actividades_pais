class CombustibleTamboFld {
  static String idTambo = 'idTambo';
  static String flgTpoPtfma = 'flgTpoPtfma';
  static String nomDpto = 'nomDpto';
  static String nomProv = 'nomProv';
  static String nomDist = 'nomDist';
  static String nomUt = 'nomUt';
  static String nomTambo = 'nomTambo';
  static String stockCsmble = 'stockCsmble';
  static String consumoGal = 'consumoGal';
  static String saldoGal = 'saldoGal';
  static String stockCsmbleCien = 'stockCsmbleCien';
  static String asignaSoles = 'asignaSoles';
  static String compradoSoles = 'compradoSoles';
  static String saldoSoles = 'saldoSoles';
  static String alerta = 'alerta';
  static String color = 'color';
  static String ptjStock = 'ptjStock';
  static String recorridoMoto = 'recorridoMoto';
  static String recorridoCamioneta = 'recorridoCamioneta';
  static String horasDeslizador = 'horasDeslizador';
  static String horasGelectronico = 'horasGelectronico';
  static String fechaUltimoStock = 'fechaUltimoStock';
}

class CombustibleTamboModel {
  int? idTambo = 0;
  int? flgTpoPtfma = 0;
  String? nomDpto = '';
  String? nomProv = '';
  String? nomDist = '';
  String? nomUt = '';
  String? nomTambo = '';
  double? stockCsmble = 0.0;
  double? consumoGal = 0.0;
  double? saldoGal = 0.0;
  double? stockCsmbleCien = 0.0;
  double? asignaSoles = 0.0;
  double? compradoSoles = 0.0;
  double? saldoSoles = 0.0;
  int? alerta = 0;
  String? color = '';
  double? ptjStock = 0.0;
  int? recorridoMoto = 0;
  int? recorridoCamioneta = 0;
  int? horasDeslizador = 0;
  int? horasGelectronico = 0;
  String? fechaUltimoStock = '';

  CombustibleTamboModel.empty();

  CombustibleTamboModel({
    this.idTambo,
    this.flgTpoPtfma,
    this.nomDpto,
    this.nomProv,
    this.nomDist,
    this.nomUt,
    this.nomTambo,
    this.stockCsmble,
    this.consumoGal,
    this.saldoGal,
    this.stockCsmbleCien,
    this.asignaSoles,
    this.compradoSoles,
    this.saldoSoles,
    this.alerta,
    this.color,
    this.ptjStock,
    this.recorridoMoto,
    this.recorridoCamioneta,
    this.horasDeslizador,
    this.horasGelectronico,
    this.fechaUltimoStock,
  });

  CombustibleTamboModel copy({
    int? idTambo,
    int? flgTpoPtfma,
    String? nomDpto,
    String? nomProv,
    String? nomDist,
    String? nomUt,
    String? nomTambo,
    double? stockCsmble,
    double? consumoGal,
    double? saldoGal,
    double? stockCsmbleCien,
    double? asignaSoles,
    double? compradoSoles,
    double? saldoSoles,
    int? alerta,
    String? color,
    double? ptjStock,
    int? recorridoMoto,
    int? recorridoCamioneta,
    int? horasDeslizador,
    int? horasGelectronico,
    String? fechaUltimoStock,
  }) =>
      CombustibleTamboModel(
        idTambo: idTambo ?? this.idTambo,
        flgTpoPtfma: flgTpoPtfma ?? this.flgTpoPtfma,
        nomDpto: nomDpto ?? this.nomDpto,
        nomProv: nomProv ?? this.nomProv,
        nomDist: nomDist ?? this.nomDist,
        nomUt: nomUt ?? this.nomUt,
        nomTambo: nomTambo ?? this.nomTambo,
        stockCsmble: stockCsmble ?? this.stockCsmble,
        consumoGal: consumoGal ?? this.consumoGal,
        saldoGal: saldoGal ?? this.saldoGal,
        stockCsmbleCien: stockCsmbleCien ?? this.stockCsmbleCien,
        asignaSoles: asignaSoles ?? this.asignaSoles,
        compradoSoles: compradoSoles ?? this.compradoSoles,
        saldoSoles: saldoSoles ?? this.saldoSoles,
        alerta: alerta ?? this.alerta,
        color: color ?? this.color,
        ptjStock: ptjStock ?? this.ptjStock,
        recorridoMoto: recorridoMoto ?? this.recorridoMoto,
        recorridoCamioneta: recorridoCamioneta ?? this.recorridoCamioneta,
        horasDeslizador: horasDeslizador ?? this.horasDeslizador,
        horasGelectronico: horasGelectronico ?? this.horasGelectronico,
        fechaUltimoStock: fechaUltimoStock ?? this.fechaUltimoStock,
      );

  factory CombustibleTamboModel.fromJson(Map<String, dynamic> json) {
    return CombustibleTamboModel(
      idTambo: _getInt(json[CombustibleTamboFld.idTambo]),
      flgTpoPtfma: _getInt(json[CombustibleTamboFld.flgTpoPtfma]),
      nomDpto: json[CombustibleTamboFld.nomDpto],
      nomProv: json[CombustibleTamboFld.nomProv],
      nomDist: json[CombustibleTamboFld.nomDist],
      nomUt: json[CombustibleTamboFld.nomUt],
      nomTambo: json[CombustibleTamboFld.nomTambo],
      stockCsmble: _getDouble(json[CombustibleTamboFld.stockCsmble]),
      consumoGal: _getDouble(json[CombustibleTamboFld.consumoGal]),
      saldoGal: _getDouble(json[CombustibleTamboFld.saldoGal]),
      stockCsmbleCien: _getDouble(json[CombustibleTamboFld.stockCsmbleCien]),
      asignaSoles: _getDouble(json[CombustibleTamboFld.asignaSoles]),
      compradoSoles: _getDouble(json[CombustibleTamboFld.compradoSoles]),
      saldoSoles: _getDouble(json[CombustibleTamboFld.saldoSoles]),
      alerta: _getInt(json[CombustibleTamboFld.alerta]),
      color: json[CombustibleTamboFld.color],
      ptjStock: _getDouble(json[CombustibleTamboFld.ptjStock]),
      recorridoMoto: _getInt(json[CombustibleTamboFld.recorridoMoto]),
      recorridoCamioneta: _getInt(json[CombustibleTamboFld.recorridoCamioneta]),
      horasDeslizador: _getInt(json[CombustibleTamboFld.horasDeslizador]),
      horasGelectronico: _getInt(json[CombustibleTamboFld.horasGelectronico]),
      fechaUltimoStock: json[CombustibleTamboFld.fechaUltimoStock],
    );
  }

  static double _getDouble(dynamic data) {
    try {
      return data != null ? double.parse(data.toString()) : 0.000;
    } catch (oError) {
      return 0.0;
    }
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }

    return resp;
  }

  static DateTime _getDateTime(dynamic data) {
    return data != null ? DateTime.parse(data as String) : DateTime.now();
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
