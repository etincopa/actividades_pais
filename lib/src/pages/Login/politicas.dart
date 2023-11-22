import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class Politicas extends StatefulWidget {
  const Politicas({super.key});

  @override
  State<Politicas> createState() => _PoliticasState();
}

class _PoliticasState extends State<Politicas>
    with TickerProviderStateMixin<Politicas> {
  Animation<double>? _animation;
  AnimationController? _controller;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Políticas de privacidad'),
        ),
        backgroundColor: color_10o15,
        body: SingleChildScrollView(child: cardDatosGenerales()));
  }

  Padding cardDatosGenerales() {
    String contenido = '''
OBJETO
Las presentes condiciones generales regulan el uso de las aplicaciones informáticas móviles y web (en adelante, la “Aplicación”) del Programa Nacional PAIS, (en adelante “PN-PAIS”).
Al acceder y utilizar esta Aplicación, usted (“Usuario”) reconoce que ha leído y aceptado estas Condiciones Generales de Uso, y se compromete a cumplir con todos sus términos y condiciones. Asimismo, el Usuario reconoce y acepta que el acceso y uso de esta Aplicación estará sujeto a las Condiciones Generales de Uso que se encuentren en vigor en el momento en que acceda a la misma. El PN-PAIS se reserva el derecho de modificar en cualquier momento las presentes Condiciones Generales de Uso, difundiendo la respectiva versión vigente a través de su portal web. Asimismo, se reserva el derecho a suspender, interrumpir o dejar de operar la Aplicación en cualquier momento.

CONTENIDOS
A través de la Aplicación, el PN-PAIS facilita al Usuario diversos servicios de consultas y/o registro (en adelante, el “Servicio”). La Aplicación, facilita al Usuario el acceso a diversos contenidos, información y datos proporcionados por el PN-PAIS en relación con el Servicio (en adelante, los “Contenidos”). El PN-PAIS se reserva el derecho a modificar en cualquier momento la presentación, la configuración y ubicación de la Aplicación, así como las correspondientes condiciones de acceso y uso, difundiendo la versión vigente de estas últimas a través de su portal web. El PN-PAIS no garantiza que los Contenidos proporcionados a través de la Aplicación serán, en todos los casos, actualizados al momento exacto de consulta.

ACCESO Y USO
La Aplicación está dirigida exclusivamente a usuarios residentes en Perú. Los usuarios que residan en el extranjero y que decidan acceder y/o utilizar esta Aplicación, lo harán bajo su propia responsabilidad debiendo asegurarse que tal acceso y/o utilización cumple con la legislación local aplicable.
El Usuario podrá acceder a la Aplicación de forma libre y gratuita, además reconoce y acepta que el acceso y uso de la Aplicación tiene lugar libre y conscientemente, bajo su exclusiva responsabilidad. La información difundida por el PN-PAIS, respecto de los diferentes registros jurídicos a su cargo, es de acceso público; por tanto, el PN-PAIS no se responsabiliza por el uso que se dé a dicha información.
El Usuario se compromete a hacer un uso adecuado y lícito de la Aplicación de conformidad con la legislación aplicable, las presentes Condiciones Generales de Uso, la moral y buenas costumbres y el orden público. El Usuario deberá abstenerse de (i) hacer un uso no autorizado o fraudulento de la Aplicación; (ii) acceder o intentar acceder a recursos restringidos de la Aplicación; (iii) utilizar la Aplicación con fines o efectos ilícitos, ilegales, contrarios a lo establecido en las presentes Condiciones Generales de Uso, a la buena fe y al orden público, lesivos de los derechos e intereses de terceros, o que de cualquier forma puedan dañar, inutilizar o sobrecargar o impedir la normal utilización de la Aplicación; (iv) provocar daños en la Aplicación; (v) introducir o difundir virus informáticos o cualesquiera otros sistemas físicos o lógicos que sean susceptibles de provocar daños en los sistemas del PN-PAIS, (vi) intentar acceder, utilizar y/o manipular los datos del PN-PAIS; (vii) reproducir o copiar, enlazar, distribuir, permitir el acceso del público a través de cualquier modalidad de comunicación pública, transformar o modificar los Contenidos, a menos que se cuente con la autorización del titular de los derechos o ello esté legalmente permitido; (viii) obtener o intentar obtener los contenidos empleando para ello medios o procedimientos distintos de los que se hayan puesto a su disposición para este efecto.
El Usuario únicamente podrá acceder a la Aplicación a través de los medios autorizados. El PN-PAIS no será responsable en caso de que el Usuario no disponga de un dispositivo compatible o haya accedido a la Aplicación a través de un medio no autorizado.

SOBRE LOS DATOS RECOPILADOS
Como usuario de esta Aplicación, ponemos en su conocimiento que los datos que recopilamos son utilizados única y exclusivamente para garantizar el buen funcionamiento de la misma y estos no se comparten ni revelan a terceros sin su respectiva autorización.
La recopilación de datos se obtiene de las siguientes maneras:
 
1. Información que usted nos proporciona: Para poder hacer uso de algunos de nuestros servicios, usted necesita proporcionarnos datos personales como:
 
a. Correo electrónico
b. Operador y número de celular
c. Apellidos y nombres
d. Tipo y número de documento de identidad
e. Dirección
 
2. Información que obtenemos del uso de la Aplicación: Esta información podría incluir::
 
a. Información del dispositivo: Podemos recopilar información específica sobre el dispositivo (como su modelo de terminal, versión del sistema operativo, identificadores únicos de dispositivo e información de la red).
b. Información del uso: Cuando usa nuestra Aplicación, recopilaremos la información sobre el uso de los diferentes servicios brindados dentro la misma.
c. Información de la ubicación: Si utiliza el servicio, podremos recopilar y procesar información sobre su ubicación real, como señales de GPS enviadas por su dispositivo móvil.

SOBRE EL TRATAMIENTO DE LOS DATOS
La información que se recopila en nuestros servidores se utiliza con fines estrictamente informativos para la generación de datos sobre el uso de nuestros diferentes servicios ofrecidos a través de nuestra Aplicación. Esta información es utilizada única y exclusivamente por el PN-PAIS, para por ejemplo hacerles llegar información de interés sobre nuevos productos o servicios registrales. Al acceder y utilizar esta Aplicación, el Usuario autoriza al PN-PAIS a compartir dicha información con otras entidades públicas de la República del Perú que así lo soliciten, dentro de los límites y condiciones previstos en el ordenamiento jurídico peruano.
Una vez que la información es recepcionada por el PN-PAIS, ésta deberá tratarla de acuerdo a las materias de su competencia, conforme a lo señalado en el Texto Único Ordenado de la Ley de Telecomunicaciones, aprobado por Decreto Supremo N° 013-93-TCC, y el Texto Único Ordenado de su reglamento, aprobado por Decreto Supremo N° 020-2007-MTC, así como la Ley N° 29733 y su reglamento aprobado por Decreto Supremo N° 003-93-JUS.
Aparte de las autorizaciones establecidas anteriormente, será obligación del PN-PAIS mantener la debida confidencialidad de los datos personales obtenidos en virtud de la utilización de la Aplicación, los que no recibirán un tratamiento distinto al indicado en las presentes Políticas de Privacidad, así como tampoco serán compartidos ni transmitidos a terceros, excepto cuando deban entregarse en razón de un mandato legal o una orden emanada de los Tribunales de Justicia que así lo requiera.

DERECHOS DE PROPIEDAD INTELECTUAL
El Usuario reconoce y acepta que todos los derechos de propiedad intelectual sobre la Aplicación, los contenidos y/o cualesquiera otros elementos insertados en la Aplicación (marcas, logotipos, nombres comerciales, textos, imágenes, gráficos, diseños, sonidos, bases de datos, software, diagramas de flujo, presentación, audio y vídeo), pertenecen al PN-PAIS.
El PN-PAIS autoriza al Usuario a utilizar y visualizar los contenidos y/o los elementos insertados en la Aplicación exclusivamente para su uso personal, y no lucrativo, absteniéndose de realizar sobre los mismos cualquier acto de descompilación, ingeniería inversa, modificación, divulgación, enlace, o suministro.
Cualquier otro uso o explotación de los contenidos y/o otros elementos insertados en la Aplicación, distinto de los que aquí expresamente se señalan, estará sujeto a la autorización previa del PN-PAIS.

EXCLUSIÓN DE GARANTÍAS Y RESPONSABILIDAD
El PN-PAIS no garantiza la disponibilidad y continuidad del funcionamiento de la Aplicación. En consecuencia, el PN-PAIS no será responsable por cualesquiera daños y perjuicios que puedan derivarse de: (i) la falta de disponibilidad o accesibilidad a la Aplicación; (ii) la interrupción en el funcionamiento de la Aplicación o fallos informáticos, averías telefónicas, desconexiones, retrasos o bloqueos causados por deficiencias o sobrecargas en las líneas telefónicas, centros de datos, en el sistema de Internet o en otros sistemas electrónicos, producidos en el curso de su funcionamiento; y (iii) otros daños que puedan ser causados por terceros mediante intromisiones no autorizadas ajenas al control del PN-PAIS.
El PN-PAIS no garantiza la ausencia de virus ni de otros elementos en la Aplicación, introducidos por terceros ajenos al PN-PAIS, que puedan producir alteraciones en los sistemas físicos o lógicos del Usuario o en los documentos electrónicos y ficheros almacenados en sus sistemas. En consecuencia, el PN-PAIS no será en ningún caso responsable de cualesquiera daños y perjuicios de toda naturaleza que pudieran derivarse de la presencia de virus u otros elementos introducidos por terceros en la Aplicación, que puedan producir alteraciones en los sistemas físicos o lógicos, documentos electrónicos o ficheros del Usuario.
El PN-PAIS adopta diversas medidas para proteger la Aplicación y los contenidos contra ataques informáticos de terceros. No obstante, el PN-PAIS no garantiza que terceros no autorizados puedan conocer las condiciones, características y circunstancias en las cuales el Usuario accede a la Aplicación. En consecuencia, PN-PAIS no será en ningún caso responsable de los daños y perjuicios que pudieran derivarse de dicho acceso no autorizado.
Con la suscripción de las presentes Condiciones Generales de Uso, usted declara que se mantendrá indemne frente a cualquier reclamación al PN-PAIS del (i) incumplimiento por parte del Usuario de cualquier disposición contenida las presentes Condiciones Generales de Uso o de cualquier ley o regulación aplicable a las mismas, (ii) incumplimiento del uso permitido de la Aplicación.

LEY APLICABLE Y JURISDICCIÓN
Las presentes Condiciones Generales de Uso, así como la relación entre el PN-PAIS y el Usuario, se regirán e interpretarán con arreglo a la legislación peruana. Las partes acuerdan someterse a la jurisdicción exclusiva de los juzgados y tribunales de la República del Perú, para la resolución de cualquier controversia en relación con las presentes Condiciones Generales de Uso o la relación entre las mismas.

LIBRO DE RECLAMACIONES
En caso el usuario no esté conforme con el servicio de la Aplicación, podrá acceder al correspondiente Libro de Reclamaciones, el mismo que de acuerdo con lo dispuesto en el artículo N° 150 de la Ley N° 29571, Código de Protección y Defensa del Consumidor, y al Reglamento del Libro de Reclamaciones, aprobado por Decreto Supremo N° 011-2011-PCM, podrá ser ubicado en forma física en las instalaciones de cada local de atención del PN-PAIS a nivel nacional, y en forma virtual en el portal web del PN-PAIS.
MODIFICACIÓN DE LAS POLITICAS DE PRIVACIDAD
El PN-PAIS se reserva el derecho a modificar estas Políticas de Privacidad, según su propio criterio, o motivado por un cambio legislativo o jurisprudencial que así lo amerite, difundiendo la respectiva versión vigente a través de su portal web.
''';

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        child: Column(
          children: [
            const Text(
              'POLÍTICAS DE PRIVACIDAD PARA APLICACIONES MÓVILES Y WEB',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              contenido,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
