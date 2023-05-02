import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';


class VentanaEstadisticas extends StatelessWidget {

  const VentanaEstadisticas({Key? key}) : super(key: key);

  Future<int> obtenerDatosInt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(value) ?? 0;
  }

  Future<double> obtenerDatosDouble(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(value) ?? 0;
  }

  Future<String> obtenerDatosString(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(value) ?? " ";
  }

  void borrarEstadisticas() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 1; i <= 9; i++) {
      prefs.setDouble('top${i}Valor', 0.0);
      prefs.setString('top${i}Nombre', ' ');
    }
    prefs.setInt('porcentaje', 0 );
    prefs.setInt('partidas',0);
    prefs.setInt('ganadas',0);
    prefs.setInt('racha',0);
    prefs.setInt('mejorRacha',0);
    prefs.setInt('perdidas',0);
    prefs.setInt('racha',0);
  }


  // Muestra un toast informativo por pantalla
  void mostrarMensaje(String mensaje) {
    Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  Widget build(BuildContext context) {

    Color colorContainer = Color(0xFFF3d3d3d);

    Widget containerDatos(String numero, String descripcion){
      return Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFFFE0e0e0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  numero,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: colorContainer,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  descripcion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: colorContainer,
                  ),
                ),
              ],
            ),
          )
      );
    }

    Widget FutureContainer(String dato, String texto){
      return FutureBuilder<int>(
        future: obtenerDatosInt(dato),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return containerDatos("${snapshot.data}", texto);
          }
        },
      );
    }

    Widget nombrePalabra( String numero ){
      return FutureBuilder<String>(
        future: obtenerDatosString("top${numero}Nombre"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Text( snapshot.data.toString().toUpperCase());
          }
        },
      );
    }

    Widget barraProgreso( String numero){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "#" + numero,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
            FutureBuilder<double>(
              future: obtenerDatosDouble("top${numero}Valor"),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: LinearProgressIndicator(
                      value: (snapshot.data ?? 0) / 100,
                      minHeight: 20,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      title: Center(
        child: Text(S.current.tituloEstadisticas),
      ),
      content: SingleChildScrollView(
        // ESTADÍSTICAS
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Ajusta el ancho del AlertDialog
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureContainer("partidas",S.current.partidas),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  FutureContainer("ganadas",S.current.ganadas),
                ],
              ),
              SizedBox(height: 16.0), // Espacio entre filas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureContainer("porcentaje",S.current.porcentaje),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  FutureContainer("perdidas",S.current.perdidas),
                ],
              ),
              SizedBox(height: 16.0), // Espacio entre filas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureContainer("racha",S.current.racha),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  FutureContainer("mejorRacha",S.current.mejorRacha),
                ],
              ),
              SizedBox(height: 25.0), // Espacio entre filas

              // TOP #10
              Center(
                child: Text(
                  S.current.tituloTop,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre filas

              barraProgreso("1"),
              nombrePalabra("1"),
              barraProgreso("2"),
              nombrePalabra("2"),
              barraProgreso("3"),
              nombrePalabra("3"),
              barraProgreso("4"),
              nombrePalabra("4"),
              barraProgreso("5"),
              nombrePalabra("5"),
              barraProgreso("6"),
              nombrePalabra("6"),
              barraProgreso("7"),
              nombrePalabra("7"),
              barraProgreso("8"),
              nombrePalabra("8"),
              barraProgreso("9"),
              nombrePalabra("9"),

              SizedBox(height: 16.0), // Espacio entre filas

              ElevatedButton(
                onPressed: () {
                  // Acción a realizar al presionar el botón
                  mostrarMensaje(S.current.confirmarFormateo);
                  borrarEstadisticas();
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.current.botonFormateo,
                  style: TextStyle(color: Colors.blue),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.blue)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              )



            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.current.cerrar),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );



  }

}