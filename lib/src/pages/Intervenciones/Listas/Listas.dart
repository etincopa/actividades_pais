import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEquipos.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../datamodels/Clases/Uti/ListaEquipoInformatico.dart';

class Listas {
  BuildContext? get context => null;

  ListTile banTitleFuncionaros(Funcionarios band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.nombres + ' ' + band.apellidoPaterno}',
          style: TextStyle(fontSize: 13)),
      subtitle: new Text('${band.dni}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.cargo}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.telefono}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  ListTile banTitleParticipantes(Participantes band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.primerNombre! + ' ' + band.segundoNombre!}',
          style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.fechaNacimiento}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.entidad}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.dni}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  ListTile banTitlePartExtrangeros(PartExtrangeros band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.nombre + ' ' + band.nombre2}',
          style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.fecha_nacimiento}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.entidad}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.dni}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Card miCardLisPartExtrangeros(Participantes band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.primerNombre! + ' ' + band.apellidoPaterno!}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text('${band.dni}',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.pais}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Text(
                  ' ${band.tipoDocumento}',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card miCardLisReportPias(ReportesPias band, onpresses) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Image.asset(
                'assets/iconusuario.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.contain,
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text('${band.puntoAtencion}',
                  style: TextStyle(fontSize: 13, color: Colors.black)),
              subtitle: new Text('${band.clima}',
                  style: TextStyle(fontSize: 12, color: Colors.black)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    child: Text(
                      '${band.fechaParteDiario}',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: 70,
                    child: Text(
                      ' ',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  Text(
                    ' ${band.plataforma}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
              onTap: onpresses)
        ],
      ),
    );
  }

  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('dd/MM/yyyy');

  Card miCardParticipantes(Participantes band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(
                '${band.primerNombre! + ' ' + band.segundoNombre! + ' ' + band.apellidoPaterno! + ' ' + band.apellidoMaterno!}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            // formatter.format(picked),

            subtitle: new Text(
                '${formatter.format(DateTime.parse(band.fechaNacimiento!))}',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Edad: ${band.edad}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ]),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 80,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Doc: ${band.dni}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ]),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Card cardFuncionarios(Funcionarios band) {
    var valordocumento = '';
    if (band.dni == '') {
      valordocumento = band.numDocExtranjero;
    } else {
      valordocumento = band.dni;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            )
            /* Icon(

              Icons.person,
              color: Colors.black,
            ) */
            ,
            //new (band.dni == '')? Text('${band.dni}', style: TextStyle(fontSize: 12, color: Colors.black)) : new Container(),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.nombres + ' ' + band.apellidoPaterno}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text('${valordocumento}',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.cargo}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Text(
                  ' ${band.telefono}',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardActividadesPias(ActividadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.descripcion}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIncidentes(ActividadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.descripcion}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIncidentesPias(IncidentesNovedadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.incidentes}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIntervenciones(TramaIntervencion band, callback) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.tambo} \n ${band.codigoIntervencion}',
                style: TextStyle(fontSize: 13)),
            subtitle: new Text('${band.tipoGobierno}',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.fecha}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  ' ${band.estado}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }

  Card cardSincronizarPias(ReportesPias band, callback) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.puntoAtencion} \n ${band.codigoUbigeo}',
                style: TextStyle(fontSize: 13)),
            subtitle:
                new Text('${band.plataforma}', style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.fechaParteDiario}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  ' ${band.clima}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }

  Card cardParqueInformatico(ListaEquipoInformatico band, callback) {
    bool light0 = true;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              child: Row(
                children: [
                  (band.estado == 'INACTIVO')
                      ? Icon(
                          Icons.computer,
                          color: Colors.black,
                          size: 35,
                        )
                      : Icon(
                          Icons.computer,
                          color: Colors.black,
                          size: 35,
                        ),
                  //  SizedBox(height: 5),
                  SizedBox(width: 12),
                  Container(
                      width: 2.0,
                      height: 50.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(color: Colors.grey))
                ],
              ),
              width: 49,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${band.descripcionEquipoInformatico}',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                )
              ],
            ),
            subtitle: new Text(
                '${band.descripcionMarca} - ${band.color} \nSERIE - ${band.serie}\n${band.descripcionModelo}\n',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //  DateFormat('yyyy-MM-dd kk:mm:ss').format(now) + '.000';
                Text(
                  ' ${band.codigoPatrimonial}',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 5),
                // Text(band.fecFinGarantiaProveedor!),
                if (band.fecFinGarantiaProveedor != '') ...[
                  Text(
                    ' ${DateFormat('dd/MM/yy').format(DateTime.parse(band.fecFinGarantiaProveedor.toString()))}',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.end,
                  )
                ],

                ///   band.fecFinGarantiaProveedor!='' || band.fecFinGarantiaProveedor!=null?   :new Container(),
                SizedBox(height: 10),

                Container(
                  child: band.estado == "ACTIVO"
                      ? ToggleSwitch(
                          minWidth: 55.0,
                          minHeight: 15,
                          initialLabelIndex: 1,
                          cornerRadius: 10.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          activeBgColor: Colors.green,
                          changeOnTap: false,
                          fontSize: 7.5,
                          labels: ['INACTIVO', 'ACTIVO'],
                          //     icons: Icon(Icons.abc),
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        )
                      : ToggleSwitch(
                          minWidth: 55.0,
                          minHeight: 15,
                          initialLabelIndex: 0,
                          cornerRadius: 10.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          activeBgColor: Colors.red,
                          changeOnTap: false,
                          fontSize: 7.5,
                          labels: ['INACTIVO', 'ACTIVO'],

                          //     icons: Icon(Icons.abc),
                          onToggle: (index) {
                            print('switched to: $index');
                          },
                        ),
                )
                /*   Container(
                  child: band.estado == "ACTIVO"
                      ? Text(
                          '${band.estado}',
                          style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        )
                      : Text(
                          ' ${band.estado}',
                          style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                )*/
                /*   Text(
                  ' ${band.codigoPatrimonial}',
                  style: TextStyle(fontSize: 10,),textAlign: TextAlign.end,
                ),

                Text(
                  ' ${band.fecFinGarantiaProveedor}',
                  style: TextStyle(fontSize: 10),textAlign: TextAlign.end
                ),
                SizedBox(height: 5,),

                Text(
                  ' ${band.estado}',
                  style: TextStyle(fontSize: 10),
                ),*/
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }

  //dynamic
  Card cardHistrialTambosInter(
      TamboServicioIntervencionesGeneral band, callback) {
    return Card(
      color: AppConfig.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(20),
      elevation: 7,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.white,
            //color of divider
            height: 5,
            //height spacing of divider
            thickness: 3,
            //thickness of divier line
            indent: 0,
            //spacing at the start of divider
            endIndent: 0, //spacing at the end of divider
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(25, 5, 25, 15),
            title: Row(
              children: [
                SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/icons/icons8-male-user-100.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Container(
                  width: 240,
                  child: Text('${band.tambo}\n${band.idProgramacion}',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                SizedBox(height: 10),
                Text(
                    textAlign: TextAlign.justify,
                    '${band.descripcion}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 10),
                Image.network('${band.pathImagen}'),
                SizedBox(height: 8),
                InkWell(
                  onTap: callback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.download, color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//dynamic
  Card cardParqueInformaticoTicket(
      ListaEquiposInformaticosTicket band, callback) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.idTicket} \n${band.usuarioAsignado}',
                style: TextStyle(fontSize: 13)),
            subtitle:
                new Text('${band.material}', style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    '${band.material}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    '${band.repuesto}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  '${band.estado}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }

  Card cardAprobacionPlanTrabajo(DatosPlanMensual band, callback) {
    return Card(
      color: AppConfig.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(20),
      elevation: 7,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(25, 5, 25, 15),
            title: Row(
              children: [
                SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        width: 40,
                        'assets/icons/icon_account_balance.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.5,
                ),
                Container(
                  width: 120,
                  child: Text(
                      '${band.plataformaDescripcion}\n'
                      '${band.idProgramacion}\n'
                      '${band.tipoPlan}\n',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 120,
                  child: Text(
                      '${band.codigoPlan}\n'
                      '${band.nombreSector}\n'
                      '${DateFormat('dd/MM/yy').format(DateTime.parse(band.fecha.toString()))}\n',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                SizedBox(height: 5),
                Divider(
                  color: Colors.white,
                  //color of divider
                  height: 5,
                  //height spacing of divider
                  thickness: 3,
                  //thickness of divier line
                  indent: 0,
                  //spacing at the start of divider
                  endIndent: 0, //spacing at the end of divider
                ),
                SizedBox(height: 10),
                Text('${band.nombrePrograma}',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                    textAlign: TextAlign.justify,
                    '${band.descripcionIntervencion}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 10),
                InkWell(
                  onTap: callback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
/*              <mat-icon style="color: rgb(218, 58, 19);" *ngIf="dataintervencion.id_evaluacion == 0" >radio_button_checked</mat-icon>
                                <mat-icon style="color: rgb(118, 233, 64);" *ngIf="dataintervencion.id_evaluacion == '1'"> radio_button_checked</mat-icon>
                                <mat-icon style="color: rgb(0, 0, 0);" *ngIf="dataintervencion.id_evaluacion == '2'"> radio_button_checked</mat-icon>
                                <mat-icon style="color: rgb(128, 87, 206);" *ngIf="dataintervencion.id_evaluacion == '3'"> radio_button_checked</mat-icon>*/
                      if (band.idEvaluacion == "0") ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child:  Row(
                            children: [
                              Icon(Icons.radio_button_checked_outlined,
                                  color: Colors.red),
                              Text(" PROGRAMADO")
                            ],
                          ),
                        ),
                      ] else if (band.idEvaluacion == "1") ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_checked_outlined,
                                  color: Colors.green),
                              Text(" APROBADO")
                            ],
                          ),
                        ),
                      ] else if (band.idEvaluacion == "2") ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_checked_outlined,
                                  color: Colors.black),
                              Text(" OBSERVADO")
                            ],
                          ),
                        ),
                      ]else if (band.idEvaluacion == "3") ...[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_checked_outlined,
                                  color: Colors.deepPurpleAccent),
                              Text(" SUBSANADO")
                            ],
                          ),
                        ),
                      ],
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.fact_check_outlined,
                            color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
/*

  Card cardAprobacionPlanTrabajo(DatosPlanMensual band, callback, BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Orientation orientation = MediaQuery.of(context).orientation;

    bool light0 = true;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(5),child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [Text("data")],
              ),
              Column(
                children: [Text("data")],
              ),
              Column(
                children: [Text("data")],
              )
            ],
          ),),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: size.width*0.82,
                child: Text("${band.descripcionIntervencion}",textAlign: TextAlign.justify),
              )
            ],
          ),
        ],
      ),
    );
  }
  */
}
