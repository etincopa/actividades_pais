import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class ImagenMostar extends StatelessWidget {
  String imagen;

  ImagenMostar({super.key, this.imagen = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          child: PhotoView(
        imageProvider: FileImage(File(imagen)),
      )),
    );
  }
}
