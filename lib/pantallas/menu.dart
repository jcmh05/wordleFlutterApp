import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantalla_estadisticas.dart';
import '../pantallas/pantallas.dart';

class Menu extends StatefulWidget{
  final Function actualizarTema;
  const Menu({Key? key, required this.actualizarTema}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();

}

class _MenuState extends State<Menu> {

  //Propiedades para los botones
  final margenVertical = 30.0;
  final margenHorizontal = 35.0;
  final alturaBoton = 85.0;
  Color primerColorBoton = Color(0xFF6baa65);
  Color segundoColorBoton = Color(0xFFc9b457);
  Color tercerColorBoton = Colors.grey;


  String teclasPulsadas = " ";

  // Función que se llamará al pulsar cada botón del menú
  void cambiarHaciaJuego(int modoDeJuego) async {
    bool actualizar = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WordlePaginaPrincipal(modoDeJuego: modoDeJuego)),
    );

    if (actualizar){
      widget.actualizarTema();
    }
  }

  // Parámetros y funciones para cambiar la escala de los botones al pulsarlos
  var _tecla1presionada;
  var _tecla2presionada;
  var _tecla3presionada;

  @override
  void initState() {
    _tecla1presionada = false;
    _tecla2presionada = false;
    _tecla3presionada = false;
  }

  void _tecla1Pulsada(PointerUpEvent){ setState(() { _tecla1presionada = true; }); }
  void _tecla1Soltada(PointerDownEvent){ setState(() { _tecla1presionada = false; }); }
  void _tecla2Pulsada(PointerUpEvent){ setState(() { _tecla2presionada = true; }); }
  void _tecla2Soltada(PointerDownEvent){ setState(() { _tecla2presionada = false; }); }
  void _tecla3Pulsada(PointerUpEvent){ setState(() { _tecla3presionada = true; }); }
  void _tecla3Soltada(PointerDownEvent){ setState(() { _tecla3presionada = false; }); }

  @override
  Widget build( BuildContext context) {


    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Image.asset(
            'assets/logo2.png',
            fit: BoxFit.contain,
          ),
        ),

        Spacer(),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón "Modo 4"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal,vertical: margenVertical),
              child: Listener(
                onPointerDown: _tecla1Pulsada,
                onPointerUp: _tecla1Soltada,
                child: Transform.scale(
                  scale: _tecla1presionada ? 0.95 : 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(4);
                    },
                    child: Text(
                        'MODO 4',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 30.0, // Tamaño fuente
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
              )
            ),

            // Botón "Clásico"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
              child: Listener(
                onPointerDown: _tecla2Pulsada,
                onPointerUp: _tecla2Soltada,
                child: Transform.scale(
                  scale: _tecla2presionada ? 0.95 : 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(5);
                    },
                    child: Text(
                        'CLÁSICO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 30.0, // Tamaño fuente
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
              ),
            ),

            // Botón "Modo 6"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
              child: Listener(
                onPointerDown: _tecla3Pulsada,
                onPointerUp: _tecla3Soltada,
                child: Transform.scale(
                  scale: _tecla3presionada ? 0.95 : 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      cambiarHaciaJuego(6);
                    },
                    child: Text(
                        'MODO 6',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 30.0, // Tamaño fuente
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
              ),
            ),
          ],
        ),

        Spacer(),

        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Botón estadísticas
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0), // Espacio uniforme alrededor del botón
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => PantallaEstadisticas()),
                      );
                    },
                    child: Text(
                      '📊',
                      style: TextStyle(
                        fontSize: 30.0, // Tamaño fuente
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      minimumSize: Size(0, alturaBoton-(alturaBoton/4)),
                    ),
                  ),
                ),
            ),

            // Botón Ajustes
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0), // Espacio uniforme alrededor del botón
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '🛠',
                      style: TextStyle(
                        fontSize: 30.0, // Tamaño fuente
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      minimumSize: Size(0, alturaBoton-(alturaBoton/4)),
                    ),
                  ),
                ),
            ),
          ],
        ),

        Spacer(),

      ],
    );

  }
}