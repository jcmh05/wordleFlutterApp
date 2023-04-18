import 'package:flutter/material.dart';
import '../pantallas/pantallas.dart';

class Menu extends StatefulWidget{
  final Function actualizarTema;
  const Menu({Key? key, required this.actualizarTema}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();

}

class _MenuState extends State<Menu> {

  String teclasPulsadas = " ";


  @override
  Widget build( BuildContext context) {
    //Propiedades para los botones
    final margenVertical = 15.0;
    final margenHorizontal = 35.0;
    final alturaBoton = 85.0;
    Color primerColorBoton = Color(0xFF6baa65);
    Color segundoColorBoton = Color(0xFFc9b457);
    Color tercerColorBoton = Colors.grey;

    //Función que se llamará al pulsar cada botón del menú
    void cambiarHaciaJuego(int modoDeJuego) async {
      bool actualizar = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WordlePaginaPrincipal(modoDeJuego: modoDeJuego)),
      );

      if (actualizar){
        widget.actualizarTema();
      }
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: margenHorizontal,vertical: margenVertical),
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(4);
                    },
                    child: Text(
                        'MODO 4',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 24.0, // Tamaño fuente
                          color: Colors.white,
                          fontFamily: 'Arial', // Fuente
                        )
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primerColorBoton, // Color de fondo del botón
                      onPrimary: tercerColorBoton,
                      minimumSize: Size(double.infinity, alturaBoton),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(5);
                    },
                    child: Text(
                        'CLÁSICO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 24.0, // Tamaño fuente
                          color: Colors.white,
                          fontFamily: 'Arial', // Fuente
                        )
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: segundoColorBoton, // Color de fondo del botón
                      onPrimary: tercerColorBoton,
                      minimumSize: Size(double.infinity, alturaBoton),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(6);
                    },
                    child: Text(
                        'MODO 6',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 24.0, // Tamaño fuente
                          color: Colors.white,
                          fontFamily: 'Arial', // Fuente
                        )
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: tercerColorBoton, // Color de fondo del botón
                      onPrimary: primerColorBoton,
                      minimumSize: Size(double.infinity, alturaBoton),
                    ),
                  ),
                ),
              ],
            )
        ),
        Text(
          "©Juan carlos Montilla - Manuel Ruiz Toribio",
          textAlign: TextAlign.left,
        )
      ],
    );

  }
}