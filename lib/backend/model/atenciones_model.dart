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
      title: 'TAMBOS QUE PRESTAN SERVICIO',
      total: 488,
    ),
    AtencionesModel(
      imagePath: '',
      title: 'INTERVENCIONES 2023',
      total: 160174,
    ),
  ];
}
