class AtencionesFields {
  static String title = 'title';
  static String imagePath = 'imagePath';
  static String total = 'total';
}

class AtencionesModel {
  String? title;
  String? imagePath;
  int? total;

  AtencionesModel.empty() {}

  AtencionesModel({
    this.title,
    this.imagePath,
    this.total,
  });

  factory AtencionesModel.fromJson(Map<String, dynamic> json) {
    return AtencionesModel(
      title: json[AtencionesFields.title],
      imagePath: json[AtencionesFields.imagePath],
      total: json[AtencionesFields.total],
    );
  }

  static List<AtencionesModel> categoryList = <AtencionesModel>[
    AtencionesModel(
      imagePath: '',
      title: 'Tambos prestando servicio',
      total: 486,
    ),
    AtencionesModel(
      imagePath: '',
      title: 'intervenciones',
      total: 486,
    ),
  ];
}
