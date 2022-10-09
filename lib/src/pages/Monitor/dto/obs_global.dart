import 'package:get/get.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

/*
   SAMPLE USE:
   ObsGlobal c = Get.put(ObsGlobal());
   c.proyectos.value //Get
   c.getUsuario() // Get
   */
class ObsGlobal extends GetxController {
  final active = false.obs;
  final user = UserModel().obs;
  final proyecto = TramaProyectoModel().obs;
  final moniteo = TramaMonitoreoModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  UserModel getUsuario() {
    return user.value;
  }

  TramaProyectoModel getProyecto() {
    return proyecto.value;
  }

  TramaMonitoreoModel getMonitoreo() {
    return moniteo.value;
  }

  void setUsuario(UserModel o) {
    user.value = o;
    update();
  }

  void setProyecto(TramaProyectoModel o) {
    proyecto.value = o;
    update();
  }

  void setMonitoreo(TramaMonitoreoModel o) {
    moniteo.value = o;
    update();
  }

  //remove (index) => users.removeAt(index);

}
