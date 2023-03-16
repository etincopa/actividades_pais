import 'dart:convert';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/clima_model.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/model/tambo_ruta_model.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapTambook extends StatefulWidget {
  const MapTambook({super.key});

  @override
  State<MapTambook> createState() => _MapTambookState();
}

class _MapTambookState extends State<MapTambook>
    with TickerProviderStateMixin<MapTambook> {
  Animation<double>? _animation;
  AnimationController? _controller;

  List<Marker> allMarkers = [];

  double currentZoom = 5.0;
  MapController mapController = MapController();
  bool darkMode = false;
  bool loadingTime = false;
  bool showCoords = false;
  bool grid = false;
  int panBuffer = 0;

  MainController mainCtr = MainController();
  late List<TambosMapaModel> oTambo = [];
  late TamboModel oTamboGeneral = TamboModel.empty();
  late List<LatLng> mapPoints = [];
  late Future<List<Marker>> marcadores;

  late ClimaModel clima = ClimaModel.empty();
  late List<RutaTamboModel> aRuta = [];
  bool isLoadingRuta = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    setState(() {});
    //buildMarkers();
    marcadores = tambosParaMapa();
  }

  Future<void> rutaTambo(int snip) async {
    isLoadingRuta = false;
    aRuta = [];
    aRuta = await mainCtr.rutaTambo(snip.toString());
    if (aRuta.isNotEmpty) await obtenerDatosClima(aRuta[0].idTambo!);
    isLoadingRuta = true;
  }

  Future<void> obtenerDatosClima(int idTambo) async {
    oTamboGeneral = await mainCtr.getTamboDatoGeneral((idTambo).toString());

    String url =
        "https://api.open-meteo.com/v1/forecast?latitude=${oTamboGeneral.yCcpp}2&longitude=${oTamboGeneral.xCcpp}&current_weather=true";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      clima =
          ClimaModel.fromJson(json.decode(response.body)['current_weather']);
    } else {
      print("Error con la respusta");
    }
  }

  Future<List<Marker>> tambosParaMapa() async {
    List<TambosMapaModel> tambos = await mainCtr.getTamboParaMapa();
    List<Marker> allMarkers = [];

    for (var point in tambos) {
      LatLng latlng = LatLng(point.latitud!, point.longitud!);
      allMarkers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: latlng,
          builder: (ctx) => GestureDetector(
            onTap: () async {
              await rutaTambo(point.snip!);

              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (BuildContext context) => buildSuccessDialog(
                  context,
                  title: point.tambo!,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.brightness_medium_outlined,
                                    size: 15),
                              ),
                              const TextSpan(
                                text: " CLIMA: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "${clima.temp ?? ''} °",
                                style: const TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: " Región: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "${point.departamento ?? ''}  ",
                                style: const TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: " PROVINCIA: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "${point.provincia ?? ''}  ",
                                style: const TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: " DISTRITO: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "${point.distrito ?? ''}  ",
                                style: const TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.person, size: 15),
                              ),
                              const TextSpan(
                                text: " GESTOR: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${oTamboGeneral.gestorNombre ?? ''} ${oTamboGeneral.gestorApellidos ?? ''} ",
                                style: const TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.map_outlined,
                                  size: 15,
                                ),
                              ),
                              TextSpan(
                                text: " COMO LLEGAR: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      for (var oRuta in aRuta)
                        Column(
                          children: [
                            Text(
                              oRuta.cidNombre ?? '',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                oRuta.txtDescripcion ?? '',
                                textAlign: TextAlign.justify,
                              ),
                              subtitle: Text(
                                oRuta.txtEncuenta ?? '',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const Divider(color: colorI),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.location_on,
              size: 30,
              color: Colors.blueAccent,
            ),
          ),
        ),
      );
    }
    setState(() {});
    return allMarkers;
  }

  void _zoomMas() {
    currentZoom = currentZoom + 1;
    mapController.move(
        LatLng(-8.840959270481326, -74.82263875411157), currentZoom);
  }

  void _zoomMenos() {
    currentZoom = currentZoom - 1;
    mapController.move(
        LatLng(-8.840959270481326, -74.82263875411157), currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_10o15,
      body: FutureBuilder<List<Marker>>(
          future: tambosParaMapa(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(-8.840959270481326, -74.82263875411157),
                  zoom: currentZoom,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    tileBuilder: tileBuilder,
                    tilesContainerBuilder:
                        darkMode ? darkModeTilesContainerBuilder : null,
                    panBuffer: panBuffer,
                  ),
                  MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      anchor: AnchorPos.align(AnchorAlign.center),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                        maxZoom: 15,
                      ),
                      markers: snapshot.data!,
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  /*MarkerLayer(
                    markers: snapshot.data!,
                  ),*/
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /*FloatingActionButton.extended(
            heroTag: 'zoom',
            label: const Text(
              'zoom',
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.add_circle_outline_outlined),
            onPressed: () => _zoomMas(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'zoom',
            label: const Text(
              'zoom',
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.remove_circle_outline_rounded),
            onPressed: () => _zoomMenos(),
          ),
          const SizedBox(height: 8),*/
          FloatingActionButton.extended(
            heroTag: 'dark-light',
            label: Text(
              darkMode ? 'Normal' : 'Oscuro',
              textAlign: TextAlign.center,
            ),
            icon: Icon(darkMode ? Icons.brightness_high : Icons.brightness_2),
            onPressed: () => setState(() => darkMode = !darkMode),
          ),
          /*const SizedBox(height: 8),
          FloatingActionButton.extended(
            backgroundColor: colorP,
            heroTag: 'Salir',
            label: const Text(
              'Salir',
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),*/
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget tileBuilder(BuildContext context, Widget tileWidget, Tile tile) {
    final coords = tile.coords;

    return Container(
      decoration: BoxDecoration(
        border: grid ? Border.all() : null,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          tileWidget,
          if (loadingTime || showCoords)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showCoords)
                  Text(
                    '${coords.x.floor()} : ${coords.y.floor()} : ${coords.z.floor()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                if (loadingTime)
                  Text(
                    tile.loaded == null
                        ? 'Loading'
                        // sometimes result is negative which shouldn't happen, abs() corrects it
                        : '${(tile.loaded!.millisecond - tile.loadStarted.millisecond).abs()} ms',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildSuccessDialog(
    BuildContext context, {
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.00,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              title ?? '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: color_01,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            child: child,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: const <Widget>[
        /*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  colorS,
                ),
              ),
              child: const Text("Aceptar"),
            ),
          ],
        ),

        */
      ],
    );
  }
}
