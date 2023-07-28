import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:flutter/material.dart';

class SuspenderIntervencion extends StatefulWidget {
  String idProgramacion = "";

  SuspenderIntervencion({super.key, this.idProgramacion =""});

  @override
  State<SuspenderIntervencion> createState() => _SuspenderIntervencionState();
}

class _SuspenderIntervencionState extends State<SuspenderIntervencion> {
  final _formKey = GlobalKey<FormState>();

  var controllerDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Suspender Intervencion"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            const Text(
              "¿Por que desea suspender esta Intervencion? ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese por que desea suspender esta Intervencion';
                }
                return null;
              },
              controller: controllerDescripcion,
              maxLines: 8,
              onChanged: (value) {
                //_currentLength = value.length;
                //setState(() {});
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var resp = await ProviderRegistarInterv().suspender(
                          widget.idProgramacion, controllerDescripcion.text);
                      if (resp == 200) {
                        Navigator.pop(context);
                        Navigator.pop(context, 'refrescar');
                      }
                    }
                  },
                  child: SizedBox(
                    height: 40,
                    width: width / 3,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.save),
                          Text(
                            'SUSPENDER',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: 1.5,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 40,
                    width: width / 3,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.cancel_presentation_outlined),
                          Text(
                            'CANCELAR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              letterSpacing: 1.5,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
