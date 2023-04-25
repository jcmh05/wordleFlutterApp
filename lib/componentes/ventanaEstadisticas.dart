import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VentanaEstadisticas extends StatelessWidget {

  const VentanaEstadisticas({Key? key}) : super(key: key);


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

    Widget barraProgreso( String numero, int porcentaje){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numero,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: porcentaje / 100,
                minHeight: 20,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                semanticsValue: porcentaje.toString() + "%",
              ),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      title: Center(
        child: Text('Estadísticas de juego'),
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
                  containerDatos("0", "🕹️ PARTIDAS\nJUGADAS"),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  containerDatos("0", "🏆 PARTIDAS\nGANADAS"),
                ],
              ),
              SizedBox(height: 16.0), // Espacio entre filas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerDatos("0", "📈 VICTORIAS\n(%)"),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  containerDatos("0", "💎 MEJOR\nINTENTO"),
                ],
              ),
              SizedBox(height: 16.0), // Espacio entre filas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerDatos("0", "🔥 RACHA\nACTUAL"),
                  SizedBox(width: 8.0), // Espacio entre los contenedores
                  containerDatos("0", "⚡ MEJOR\nRACHA"),
                ],
              ),
              SizedBox(height: 25.0), // Espacio entre filas

              // TOP #10
              Center(
                child: Text(
                  'Mejores partidas',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre filas

              barraProgreso("#1", 20),
              barraProgreso("#2", 25),
              barraProgreso("#3", 40),
              barraProgreso("#4", 45),
              barraProgreso("#5", 50),
              barraProgreso("#6", 80),
              barraProgreso("#7", 82),
              barraProgreso("#8", 85),
              barraProgreso("#9", 90),

              SizedBox(height: 16.0), // Espacio entre filas

              ElevatedButton(
                onPressed: () {
                  // Acción a realizar al presionar el botón
                  mostrarMensaje("Estadísticas borradas");
                },
                child: Text(
                  'Restablecer estadísticas',
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
          child: Text('Compartir'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );



  }

}