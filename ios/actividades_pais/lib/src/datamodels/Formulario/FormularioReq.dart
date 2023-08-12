import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';

class FormularioReq {
  static Color primaryColor = const Color(0xFF3949AB);

  static Color secondaryColor = const Color(0xFF3949AB);
  String validateEmails(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Ingrese un correo valido';
    } else {
      return '';
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: primaryColor),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
  Servicios servicios = Servicios();

  textinputdet(String text, TextEditingController controller,
      TextCapitalization textCapitalization, TextInputType textInputType, enabled,{validator}) {
    return Container(

   // decoration: servicios.myBoxDecoration(),
    //  decoration: FormularioReq().myBoxDecoration(),
      child: TextFormField(

        textAlign: TextAlign.justify,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        controller: controller,
        enabled: enabled,
          validator: validator,
        //obscureText: true,/*    decoration: InputDecoration(
        //                             labelText: 'Your Name',
        //                             border: const OutlineInputBorder(),
        //                             // Display the number of entered characters
        //                             counterText: '${_enteredText.length.toString()} character(s)'),*/
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),

          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
          ),
          labelText: text,

          //   suffixIcon: Icon(Icons.https, color: primaryColor)
        ),
      ),
    );
  }

  ccboTipoDocumento({itemsTipoDOC, onChanged, mySelectionTipoDoc}) {
    return Container(
      decoration: FormularioReq().myBoxDecoration(),
      child: DropdownButtonFormField<dynamic>(
          items: itemsTipoDOC, value: mySelectionTipoDoc, onChanged: onChanged),
    );
  }

  textIngresoDc({controllerNDocumento, maxLengthDOC, onSubmitted, labelText,onEditingComplete,onChanged, enabled, validator }) {
    return Container(
         child: TextFormField(
          keyboardType: TextInputType.phone,
          controller: controllerNDocumento,
          enabled: enabled,
          maxLength: maxLengthDOC,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
           validator:validator,
          //obscureText: true,
        //  onSubmitted: onSubmitted,

          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0EA1E8)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0EA1E8)),
            ),

            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0EA1E8)),
            ),
            labelText: labelText,

            //   suffixIcon: Icon(Icons.https, color: primaryColor)
          ),
        /*  decoration: InputDecoration(


            labelText: 'N° DOCUMENTO IDENTIDAD',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),

              //   suffixIcon: Icon(Icons.https, color: primaryColor)
            ),
          ),*/
        ));
  }
}
