import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/detalleProyecto.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class ImageView extends StatefulWidget {
  ImageView({super.key, this.galleria, required this.datoProyecto});
  Image? galleria;
  TramaProyectoModel datoProyecto;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List imageList = [];
  @override
  Widget build(BuildContext context) {
    imageList = [
      widget.galleria!.image,
    ];
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        widget.datoProyecto.tambo ?? '',
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetalleProyecto(datoProyecto: widget.datoProyecto),
              ));
        },
      ),
      body: Container(
        color: Colors.white,
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          enableRotation: true,
          imageProvider: widget.galleria!.image,
          maxScale: 200.0,
        ),
      ),
      /* body: PhotoViewGallery.builder(
        itemCount: imageList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imageList[index],
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ), */
    );
  }
}
