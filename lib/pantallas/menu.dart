import 'package:com.jc.wordel/componentes/AudioPlayerController.dart';
import 'package:flutter/material.dart';
import 'package:com.jc.wordel/componentes/componentes.dart';
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


  String teclasPulsadas = " ";

  // Función que se llamará al pulsar cada botón del menú
  void cambiarHaciaJuego(int modoDeJuego, bool entrenamiento_) async {
    bool actualizar = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PantallaJuego(modoDeJuego: modoDeJuego, idioma: widget.idioma,entrenamiento: entrenamiento_)),
    );

    if (actualizar){
      widget.actualizarTema();
    }
  }

  void reproducir() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool musicaActivada = prefs.getBool("musica") ?? false;

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
  }

  @override
  void dispose() {
    audioPlayerController.dispose();
    super.dispose();
  }

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
            // Botón "Jugar"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal,vertical: margenVertical),
              child: Button3d(
                  style: Button3dStyle(
                    topColor: Color(0xFF6baa65),
                    backColor: Color(0xFF276507),
                  ),
                  onPressed: () {
                    sonidoInterfaz('start');
                    cambiarHaciaJuego(5, false);
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
                  width: MediaQuery.of(context).size.width
              ),
            ),

            // Botón "Entrenamiento"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
              child: Button3d(
                  style: Button3dStyle(
                    topColor: Color(0xFFc9b457),
                    backColor: Color(0xFF8F8D00),
                  ),
                  onPressed: () {
                    sonidoInterfaz('click_on');
                    showDialog(context: context, builder:(context){return VentanaEntrenamiento();}).then((result) {
                      if( result != null ){
                        cambiarHaciaJuego(result, true);
                        sonidoInterfaz('start');
                      }else{
                        sonidoInterfaz('click_off');
                      }
                    });
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
                  width: MediaQuery.of(context).size.width
              ),
            ),

            // Botón "Tutorial"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: margenHorizontal, vertical: margenVertical),
              child: Button3d(
                  style: Button3dStyle(
                    topColor: Colors.grey,
                    backColor: Color(0xFF2C2C2C),
                  ),
                  onPressed: () {
                    sonidoInterfaz('click_on');
                    showDialog(context: context, builder:(context){return VentanaTutorial(idioma: widget.idioma,);}).then((result) {
                      sonidoInterfaz('click_off');
                    });
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
                  width: MediaQuery.of(context).size.width
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
                splashColor: Color(0xFF6baa65),
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
                splashColor: Color(0xFF6baa65),
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