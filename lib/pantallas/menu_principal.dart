import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class MenuPrincipal extends StatefulWidget{

  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuPrincipalState();

}

class _MenuPrincipalState extends State<MenuPrincipal> {
  //Propiedades para los botones
  final margenVertical = 15.0;
  final margenHorizontal = 35.0;
  final alturaBoton = 85.0;
  Color primerColorBoton = Color(0xFF6baa65);
  Color segundoColorBoton = Color(0xFFc9b457);
  Color tercerColorBoton = Colors.grey;


  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72.0,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: WordleTema.temaClaro ? Icon(Icons.nightlight_outlined) : Icon(Icons.nightlight),
              onPressed: () {
                WordleTema.cambiarTema();
                setState(() {});
              },
            ),
          ],
        ),

        body: Column(
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
                          // Acción a realizar al presionar el botón 4
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
                          // Acción a realizar al presionar el botón Modo Clásico
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WordlePaginaPrincipal()),
                          );
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
                          // Acción a realizar al presionar el botón Modo 6
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
        ),

        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('Ajustes de la cuenta'),
                  trailing: Icon(Icons.account_circle),
                  onTap: () {
                    //Ación que hace la opción,
                  },
                ),
                ListTile(
                  title: Text('Estadísticas de juego'),
                  trailing: Icon(Icons.stacked_bar_chart),
                  onTap: () {
                    //Ación que hace la opción,
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('¡Mensaje temporal!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                )
              ],
            )
          )
        )

      ),
    );
  }

}