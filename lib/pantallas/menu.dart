import 'package:Wordel/componentes/AudioPlayerController.dart';
import 'package:flutter/material.dart';
import 'package:Wordel/componentes/componentes.dart';
import 'package:Wordel/componentes/ventanaEstadisticas.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';
import '../pantallas/pantallas.dart';
import 'package:soundpool/soundpool.dart';
import 'package:audioplayers/audioplayers.dart';


class Menu extends StatefulWidget{
  final Function actualizarTema;
  final String idioma;
  const Menu({Key? key, required this.actualizarTema, required this.idioma}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();

}

class _MenuState extends State<Menu> {
  static Soundpool _pool = Soundpool(streamType: StreamType.music);
  AudioPlayer player = AudioPlayer();
  late AudioPlayerController audioPlayerController;

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
      MaterialPageRoute(builder: (context) => PantallaJuego(modoDeJuego: modoDeJuego, idioma: widget.idioma)),
    );

    if (actualizar){
      widget.actualizarTema();
    }
  }

  // Parámetros y funciones para cambiar la escala de los botones al pulsarlos
  var _tecla1presionada;
  var _tecla2presionada;
  var _tecla3presionada;

  void reproducir() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool musicaActivada = prefs.getBool("musica") ?? true;

    if( musicaActivada){
      double volumen = prefs.getDouble("volumenMusica") ?? 0.15;
      String cancion = prefs.getString("cancionEscogida") ?? "Elevator1.mp3";
      await player.setVolume(volumen);
      await player.play(AssetSource(cancion));
      await player.setReleaseMode(ReleaseMode.loop);
    }
  }

  @override
  void initState() {
    super.initState();
    reproducir();
    audioPlayerController = AudioPlayerController(audioPlayer: player);
    _tecla1presionada = false;
    _tecla2presionada = false;
    _tecla3presionada = false;
  }

  @override
  void dispose() {
    audioPlayerController.dispose();
    super.dispose();
  }

  void _tecla1Pulsada(PointerUpEvent){ setState(() { _tecla1presionada = true; }); }
  void _tecla1Soltada(PointerDownEvent){ setState(() { _tecla1presionada = false; }); }
  void _tecla2Pulsada(PointerUpEvent){ setState(() { _tecla2presionada = true; }); }
  void _tecla2Soltada(PointerDownEvent){ setState(() { _tecla2presionada = false; }); }
  void _tecla3Pulsada(PointerUpEvent){ setState(() { _tecla3presionada = true; }); }
  void _tecla3Soltada(PointerDownEvent){ setState(() { _tecla3presionada = false; }); }

  static void sonidoInterfaz(String nombre) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool activado = prefs.getBool("sonidosInterfaz") ?? true;

    if( activado ){
      int soundId = await rootBundle
          .load("assets/${nombre}.mp3")
          .then((ByteData soundData) {
        return _pool.load(soundData);
      });
      int streamId = await _pool.play(soundId);
    }
  }

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
                      sonidoInterfaz('start');
                      cambiarHaciaJuego(4);
                    },
                    child: Text(
                        S.current.boton1menu,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 26.0, // Tamaño fuente
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
                      sonidoInterfaz('start');
                      cambiarHaciaJuego(5);
                    },
                    child: Text(
                        S.current.boton2menu,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 26.0, // Tamaño fuente
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
                      sonidoInterfaz('start');
                      cambiarHaciaJuego(6);
                    },
                    child: Text(
                        S.current.boton3menu,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Fuente botón
                          fontSize: 26.0, // Tamaño fuente
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

        Padding(
          padding: EdgeInsets.only(bottom: 45.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Botón estadísticas
              IconButton(
                iconSize: 35.0,
                splashColor: primerColorBoton,
                icon: Icon(Icons.bar_chart_sharp),
                onPressed: () {
                  sonidoInterfaz('click_on');
                  showDialog(context: context, builder:(context){return VentanaEstadisticas();}).then((result) {
                    sonidoInterfaz('click_off');
                  });
                },
              ),

              // Botón Ajustes
              IconButton(
                iconSize: 35.0,
                splashColor: primerColorBoton,
                icon: Icon(Icons.settings),
                onPressed: () {
                  sonidoInterfaz('click_on');
                  showDialog(context: context, builder:(context){return VentanaAjustes(player: player);}).then((result) {
                    sonidoInterfaz('click_off');
                  });
                },
              ),
            ],
          ),
        ),


        Spacer(),

      ],
    );

  }


}