import 'dart:io';

import 'package:actividades_pais/util/image_util.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class ImagePreview extends StatelessWidget {
  String? imagen;

  ImagePreview({this.imagen});

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
        alignment: Alignment.center,
        child: ImageUtil.ImageBase64(
          imagen!,
          width: 380,
          height: 380,
        ),
      ),

/*
      FancyShimmerImage(
        imageUrl: imagen!,
        errorWidget: Container(
          alignment: Alignment.center,
          height: 100.0,
          width: 100.0,
          child: Image.asset('assets/logo circular.png'),
        ),
      ),
      */
      /*
        PhotoView(
        imageProvider: FileImage(imagen!),
        ),
      */
    );
  }
}
