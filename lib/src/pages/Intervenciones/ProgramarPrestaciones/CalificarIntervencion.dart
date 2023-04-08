import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:flutter/material.dart';

class CalificarIntervencion extends StatefulWidget {
  final Evento event;

  CalificarIntervencion(this.event);

  @override
  State<CalificarIntervencion> createState() => _CalificarIntervencionState();
}

class _CalificarIntervencionState extends State<CalificarIntervencion> {
  List<bool> _isOpenList = List.generate(3, (_) => false);
  final _controller = TextEditingController();
  final _controllerIntervencionPertenecea = TextEditingController();
  final _horaInicio = TextEditingController();
  final _horaFin = TextEditingController();
  String tipoPlataforma = '';
  String unidadTerritorial = '';
  var _maxLines = 1;
  Listas listas = Listas();
  bool _isLoading = false;
  List<Funcionarios>? _posts = [];
  bool _showAddPageButton = true;
  bool isLoading = false;
  bool isMostar = false;
  var pageIndex = 1;
  int _currentPage = 1;
  @override
  void initState() {
    super.initState();
    CargarCampos();
    _loadData();
   // inicio();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: utils().ConfgAppBar(
        titulo: "INTERVENCIÓN DE PRESTACIONES",
        leading: () => Navigator.pop(context),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              enabled: true,
              controller: _controller,
              maxLines: _maxLines,
              decoration: InputDecoration(
                hintText:
                    "¿QUÉ SE HIZO? ¿CUÁL ES LA FINALIDAD? ¿QUIÉN LO HIZO? ¿A QUIÉN ESTA DIRIGIDO? ",
                labelText: 'DESCRIPCIÓN DEL EVENTO',
                //   counterText: "$_currentLength",
              ),
            ),
            textoCampo("LA INTERVENCION PERTENECE A",
                _controllerIntervencionPertenecea),
            Container(
              //  width: width / 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width / 4,
                    child: textoCampo("HORA INICIO", _horaInicio),
                  ),
                  Container(
                    width: width / 4,
                    child: textoCampo("HORA FIN", _horaFin),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: Container(
                height: 40,
                width: width / 1,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.view_agenda_outlined),
                      Text(
                        'VER IMAGENES',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (index, isOpen) {
                setState(() {
                  _isOpenList[index] = !isOpen;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return ListTile(
                      title: Text('ENTIDAD'),
                    );
                  },
                  body: ListTile(
                    title: FutureBuilder<List<Accion>>(
                      future: ProviderRegistarInterv()
                          .getListaAcciones(widget.event.idProgramacion),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Accion>> snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data!;
                          return Column(
                            children: [
                              for (var nombre in items)
                                listas.cardAccion(nombre, () async {}, context),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error al obtener datos de la API: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  isExpanded: _isOpenList[0],
                ),
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return ListTile(
                      title: Text('FUNCIONARIOS'),
                    );
                  },
                  body: ListTile(
                    title: FutureBuilder<List<Funcionarios>>(
                      future: ProviderRegistarInterv()
                          .getListaFuncionarios(widget.event.idProgramacion ),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Funcionarios>> snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data!;
                          return Column(
                            children: [
                              for (var nombre in items)
                                listas.banTitleFuncionaros(nombre),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error al obtener datos de la API: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  isExpanded: _isOpenList[1],
                ),
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return ListTile(
                      title: Text('Total de Participantes : 1'),
                    );
                  },
                  body:
                 Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _posts!.length + (_showAddPageButton ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _posts!.length) {
                      if (_isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        print("_posts?.length ${_posts?.length}");
                        return _buildAddPageButton();
                      }
                    } else {
                      var post = _posts![index];
                      return Listas().banTitleFuncionaros(
                        _posts![index],

                      );

                    }
                  },

                  ///  controller: controller,
                  //scrollDirection: ,
                  //  onScrollEndDrag: ,
                ),


        ),
                  isExpanded: _isOpenList[2],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _addPage() {
    _loadData();
  }
  _onlistener() async {
    setState(() {
      isLoading = true;
      pageIndex = pageIndex + 1;
    });
    await traerPaguinado(10, pageIndex);
    setState(() {
      isLoading = false;
    });
  }
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _onlistener();
    try {
      var posts = await ProviderRegistarInterv()
          .getListaParticipantes(widget.event.idProgramacion, pageIndex, 15);

      //   Iterable<DatosPlanMensual> iterableDatos = posts != null ? Iterable<DatosPlanMensual>.of(posts) : Iterable.empty();
      Iterable<Funcionarios> iterableDatos = posts != null
          ? List<Funcionarios>.from(posts)
          : const Iterable.empty();

      /*ProviderAprobacionPlanes()
                .ListarAprobacionPlanTrabajo(filtroDataPlanMensual)*/
      _posts = [];
      setState(() {
        _posts?.addAll(iterableDatos);

        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }
  Widget _buildAddPageButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: _addPage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (_posts!.isNotEmpty)
                ? const Icon(Icons.add_circle_outline_sharp, size: 50)
                : const Center(
              child: Text("¡No existen registros"),
            ),
          ],
        ),
      ),
    );
  }
  Future<Null> traerPaguinado(pageSize, pageIndex) async {
   // filtroDataPlanMensual.pageSize = pageSize;
   // filtroDataPlanMensual.pageIndex = pageIndex;
    setState(() {});
  }
  CargarCampos() async {
    final rp = await ProviderRegistarInterv()
        .getntervencionDetalle(widget.event.idProgramacion);
    _horaInicio.text = rp["hora_inicio"];
    _horaFin.text = rp["hora_fin"];
    final textPainter = TextPainter(
      text: TextSpan(text: rp["descripcion_intervencion"]),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 32);
    final lines = textPainter.size.height / textPainter.preferredLineHeight;
    _controller.text = rp["descripcion_intervencion"];
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    _controller.selection = TextSelection.collapsed(offset: 0);
    _maxLines = lines.ceil() + 2;

    final lst = await ProviderRegistarInterv().getTipoIntervencion();
    final tipoIntervencion = lst.firstWhere(
        (t) => t.idTipoIntervencion == int.parse(rp["id_tipo_intervencion"]),
        orElse: () => null);
    if (tipoIntervencion != null) {
      _controllerIntervencionPertenecea.text =
          tipoIntervencion.nombreTipoIntervencion;
    }
    setState(() {});
   }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      setState(() {
        if (abc.isNotEmpty) {
          tipoPlataforma = abc[0].tipoPlataforma;
          unidadTerritorial = abc[0].unidTerritoriales;
        }
      });
    }
  }

  textoCampo(labelText, controller) {
    return TextFormField(
      enabled: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        // hintText: labelText,
      ),
      onTap: () {},
    );
  }

  CargarTablaAccion() {}
}