// ignore_for_file: sized_box_for_whitespace, unnecessary_new


import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfiguracionUsuarioPage extends StatefulWidget {
  String titulo;

  ConfiguracionUsuarioPage({super.key, 
    this.titulo = '',
  });

  @override
  _ConfiguracionUsuarioPageState createState() =>
      _ConfiguracionUsuarioPageState();
}

class _ConfiguracionUsuarioPageState extends State<ConfiguracionUsuarioPage> {
  var _image;
  String fotonomm = 'assets/pegasologo.png';

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController password = new TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 1,
      ),
      body: _formulario(),
    );
  }

  imputField(texto, controladors) {
    return TextFormField(
      textInputAction: TextInputAction.go,
      onChanged: (value) {},
      cursorColor: const Color(0xFF3949AB),
      controller: controladors,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          labelText: texto,
          fillColor: const Color(0xFF3949AB),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: texto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hoverColor: const Color(0xFF3949AB),
          focusColor: const Color(0xFF3949AB)),
    );
  }

  guardar() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.blue[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          /*    print(password.text);
          var result = await Provider().changePassword(password: password.text);

          if (result == 200) {
            var s = await DatabasePr.db.eliminarTokn();
            print(s);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          } */
        },
        child: Text("Guardar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  _formulario() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 0.0),
            Column(
              children: <Widget>[
                //  _tomarImagen,
                const SizedBox(height: 20.0),
                imputField('Cambiar Password', password),
                const SizedBox(height: 20.0),
                const SizedBox(
                  height: 20.0,
                ),
                guardar()
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ]),
    );
  }

/*  Widget get _tomarImagen {
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 180,
            width: 180,
            margin: EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(200.0),
              child: new ClipRRect(
                  borderRadius: new BorderRadius.circular(200.0),
                  child: _image == null
                      ? new GestureDetector(
                          onTap: () {},
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : new GestureDetector(
                          onTap: () {},
                          child: new Container(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  } */
}
