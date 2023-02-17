import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
  late List<LatLng> mapPoints = [];
  late Future<List<Marker>> marcadores;

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

  Future<List<Marker>> tambosParaMapa() async {
    List<TambosMapaModel> tambos = await mainCtr.getTamboParaMapa();
    List<Marker> allMarkers = [];
    for (var point in tambos) {
      LatLng latlng = LatLng(point.latitud!, point.longitud!);
      allMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: latlng,
          builder: (ctx) => GestureDetector(
            onTap: () {
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
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.brightness_medium_outlined,
                                    size: 15),
                              ),
                              TextSpan(
                                text: " CLIMA: ",
                                style: TextStyle(
                                  color: color_01,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "CALIDO",
                                style: TextStyle(
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
                      RichText(
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.map_outlined, size: 15),
                            ),
                            TextSpan(
                              text: " COMO LLEGAR: ",
                              style: TextStyle(
                                color: color_01,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "PASAR POR CHOSICA, MATUCANA, SAN MATEO, ...",
                              style: TextStyle(
                                color: color_01,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
                  MarkerLayer(
                    markers: snapshot.data!,
                  ),
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
          FloatingActionButton.extended(
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
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'dark-light',
            label: Text(
              darkMode ? 'Normal' : 'Oscuro',
              textAlign: TextAlign.center,
            ),
            icon: Icon(darkMode ? Icons.brightness_high : Icons.brightness_2),
            onPressed: () => setState(() => darkMode = !darkMode),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            backgroundColor: colorP,
            heroTag: 'Salir',
            label: const Text(
              'Salir',
              textAlign: TextAlign.center,
            ),
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
