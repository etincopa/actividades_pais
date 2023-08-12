import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:get/get.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

const options = ['BAJO', 'MEDIO', 'ALTO'];

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key, required this.datoProyecto})
      : super(key: key);

  final TramaProyectoModel datoProyecto;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late TramaProyectoModel _oProject;

  late final _numSnip;
  late final _cui;
  late final _latitud;
  late final _longitud;
  late final _departamento;
  late final _provincia;
  late final _distrito;
  late final _tambo;
  late final _centroPoblado;
  late final _estado;
  late final _subEstado;
  late final _estadoSaneamiento;
  late final _modalidad;
  late final _fechaInicio;
  late final _fechaTerminoEstimado;
  late final _inversion;
  late final _costoEjecutado;
  late final _costoEstimadoFinal;
  late final _avanceFisico;
  late final _residente;
  late final _supervisor;
  late final _crp;
  late final _codResidente;
  late final _codSupervisor;
  late final _codCrp;

  @override
  void initState() {
    _oProject = widget.datoProyecto;
    _numSnip = TextEditingController(text: _oProject.numSnip);
    _cui = TextEditingController(text: _oProject.cui);
    _latitud = TextEditingController(text: _oProject.latitud);
    _longitud = TextEditingController(text: _oProject.longitud);
    _departamento = TextEditingController(text: _oProject.departamento);
    _provincia = TextEditingController(text: _oProject.provincia);
    _distrito = TextEditingController(text: _oProject.distrito);
    _tambo = TextEditingController(text: _oProject.tambo);
    _centroPoblado = TextEditingController(text: _oProject.centroPoblado);
    _estado = TextEditingController(text: _oProject.estado);
    _subEstado = TextEditingController(text: _oProject.subEstado);
    _estadoSaneamiento =
        TextEditingController(text: _oProject.estadoSaneamiento);
    _modalidad = TextEditingController(text: _oProject.modalidad);
    _fechaInicio = TextEditingController(text: _oProject.fechaInicio);
    _fechaTerminoEstimado =
        TextEditingController(text: _oProject.fechaTerminoEstimado);
    _inversion = TextEditingController(text: _oProject.inversion);
    _costoEjecutado = TextEditingController(text: _oProject.costoEjecutado);
    _costoEstimadoFinal =
        TextEditingController(text: _oProject.costoEstimadoFinal);
    _avanceFisico =
        TextEditingController(text: (_oProject.avanceFisico).toString());
    _residente = TextEditingController(text: _oProject.residente);
    _supervisor = TextEditingController(text: _oProject.supervisor);
    _crp = TextEditingController(text: _oProject.crp);
    _codResidente = TextEditingController(text: _oProject.codResidente);
    _codSupervisor = TextEditingController(text: _oProject.codSupervisor);
    _codCrp = TextEditingController(text: _oProject.codCrp);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final _questionCtrl = TextEditingController();
  final _questionCtrl2 = TextEditingController();
  final _dateinput = TextEditingController();
  final _optionCtrls = options.map((o) => TextEditingController()).toList();
  final _question = {'value': '', 'correct': options[0], 'options': options};

  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      "Info!",
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    for (var ctrl in _optionCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: WidgetCustoms.appBar(
        'ProjectDetailTitle'.tr,
        context: context,
        iconAct: Icons.monitor,
        onPressedAct: () {},
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(padding: const EdgeInsets.all(32), children: [
          Text(
            'FldProyect001'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _cui,

            ///CÓDIGO ÚNICO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect002'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _numSnip,

            ///CÓDIGO DE SNIP
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect003'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _latitud,

            ///LATITUD DE LA UBICACIÓN DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect004'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _longitud,

            ///LONGITUD DE LA UBICACIÓN DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect005'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _departamento,

            ///NOMBRE DEL DEPARTAMENTO DEL UBIGEO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect005'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _provincia,

            ///NOMBRE DE LA PROVINCIA DEL UBIGEO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect007'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _distrito,

            ///NOMBRE DEL DISTRITO DEL UBIGEO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect008'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _tambo,

            ///NOMBRE DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect009'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _centroPoblado,

            ///NOMBRE DEL CENTRO POBLADO DEL UBIGEO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect010'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _estado,

            ///ESTADO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect011'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _subEstado,

            ///SUB ESTADO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect012'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _estadoSaneamiento,

            ///ESTADO DE SANEAMIENTO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect013'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _modalidad,

            ///MODALIDAD DE CONTRATACIÓN DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect014'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _fechaInicio,

            ///FECHA DE INICIO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect015'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _fechaTerminoEstimado,

            ///FECHA DE TÉRMINO ESTIMADO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect016'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _inversion,

            ///MONTO DE INVERSIÓN DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect017'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _costoEjecutado,

            ///COSTO EJECUTADO ACUMULADO DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect018'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _costoEstimadoFinal,

            ///COSTO ESTIMADO FINAL DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect019'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _avanceFisico,

            ///% AVANCE FÍSICO ACUMULADO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect020'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _residente,

            ///NOMBRE DEL RESIDENTE
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect021'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _supervisor,

            ///NOMBRE DEL SUPERVISOR
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect022'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _crp,

            ///NOMBRE DEL COORDINADOR REGIONAL DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect023'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _codResidente,

            ///CÓDIGO DEL RESIDENTE
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect024'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _codSupervisor,

            ///CÓDIGO DEL SUPERVISOR
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 10),
          Text(
            'FldProyect025'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            controller: _codCrp,

            ///CÓDIGO DEL COORDINADOR REGIONAL DEL PROYECTO
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
