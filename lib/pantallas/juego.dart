import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Wordel/componentes/componentes.dart';
import 'package:Wordel/modelos/modelos.dart';
import 'package:Wordel/funciones/funciones.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';


class Juego extends StatefulWidget{
  final int modoDeJuego;  // Nº de letras de la palabra
  final String idioma;
  const Juego({Key? key, required this.modoDeJuego, required this.idioma}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JuegoState();

}

class _JuegoState extends State<Juego> {
  static Soundpool _pool = Soundpool(streamType: StreamType.music);
  bool juegoTerminado = false;

  final Map<String, List<String>> teclados = {
    'es': ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'],
    'en': ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'],
    'fr': ['A','Z', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Q', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'W', 'X', 'C', 'V', 'B', 'N', 'BORRAR'],
    'it': ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'],
    'ca': ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', ' ','X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'],
    'da': ['Q','W', 'E', 'R', 'T', 'Z', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Y', ' ','X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'],
    'zh': ['手','田', '水', '口', '廿', '卜', '山', '戈', '人', '心', '日', '尸', '木', '火', '土', '竹', '十', '大', '中', '難', ' ', ' ','金', '女', '月', '弓','BORRAR']
  };

  // PARÁMETROS JUEGO
  late EstadoJuego estadoJuego;
  var filaActual;
  var palabra;
  var teclado;

  // Lista de los colores de cada tecla del teclado
  var listaEstados;

  ConfettiController _controller = ConfettiController();

  // Lista de letras con la fila que se está escribiendo
  List<String> letrasFilaActual = [];

  // Lista de las letras que ya se han comprobado
  List<String> letrasComprobadas = [];



  @override
  void initState(){
    teclado = teclados[widget.idioma];
    listaEstados = List<int>.filled(teclado.length, 0);
    filaActual = 0;
    palabra = " ";
    estadoJuego = EstadoJuego(wordLength: widget.modoDeJuego, idioma: widget.idioma);
    estadoJuego.init().then((_) {
      palabra = estadoJuego.palabra;
    });
  }

  // Muestra un toast informativo por pantalla
  void mostrarMensaje(String mensaje) {
    Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  // Si ganamos, actualiza el top de mejores partidas
  void actualizaMejoresPartidas(double puntuacion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtiene la lista de los 9 mejores puntajes y sus nombres asociados
    List<double> mejoresPuntajes = List.generate( 9, (index) => prefs.getDouble('top${index + 1}Valor') ?? 0.0, );
    List<String> mejoresNombres = List.generate(9, (index) => prefs.getString('top${index + 1}Nombre') ?? '', );

    // Busca el primer puntaje en la lista que sea menor que la puntuación
    int indiceMenorPuntaje = mejoresPuntajes.indexWhere((puntaje) => puntaje <= puntuacion);

    // Si la puntuación es mayor que alguno de los puntajes en la lista
    if (indiceMenorPuntaje >= 0) {
      // Agrega la puntuación y el nombre en la posición correspondiente en la lista
      mejoresPuntajes.insert(indiceMenorPuntaje, puntuacion);
      mejoresNombres.insert(indiceMenorPuntaje, palabra);
      // Elimina el último elemento de la lista
      mejoresPuntajes.removeLast();
      mejoresNombres.removeLast();
    }

    // Guarda los mejores puntajes y nombres en SharedPreferences
    for (int i = 0; i < 9; i++) {
      prefs.setDouble('top${i + 1}Valor', mejoresPuntajes[i]);
      prefs.setString('top${i + 1}Nombre', mejoresNombres[i]);
    }
  }

  // Actualiza las estadísticas según el resultado de la partida
  void actualizaEstadisticas(bool victoria) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int partidas = prefs.getInt('partidas') ?? 0;
    int ganadas = prefs.getInt('ganadas') ?? 0;
    int perdidas = prefs.getInt('perdidas') ?? 0;
    int racha = prefs.getInt('racha') ?? 0;
    int mejorRacha = prefs.getInt('mejorRacha') ?? 0;
    partidas++;

    if( victoria ){
      ganadas++;
      prefs.setInt('ganadas',(ganadas));
      prefs.setInt('racha',racha+1);
      if( (racha+1) > mejorRacha ){
        prefs.setInt('mejorRacha',racha+1);
      }
    }
    else{
      prefs.setInt('perdidas',(perdidas+1));
      prefs.setInt('racha',0);
    }

    prefs.setInt('porcentaje', ((ganadas/partidas)*100).ceil() );
    prefs.setInt('partidas',partidas);
  }

  // Reproduce sonidos de interfaz de forma asíncrona
  static void sonidoInterfaz(String nombre) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool activado = prefs.getBool("sonidosInterfaz") ?? true;

    if( activado ){
      int soundId = await rootBundle
          .load("assets/${nombre}")
          .then((ByteData soundData) {
        return _pool.load(soundData);
      });
      int streamId = await _pool.play(soundId);
    }
  }

  // Gestiona que sonido debe sonar para cada tecla
  void sonidoTecla(String tecla) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool activado = prefs.getBool("sonidosTeclado") ?? true;
    if( activado ){
      if( tecla == "BORRAR" ){
        sonidoInterfaz("sounds_space.wav");
      }else{
        List<String> sounds = [
          'sounds_key01.wav',
          'sounds_key02.wav',
          'sounds_key03.wav',
          'sounds_key04.wav',
          'sounds_key05.wav',
          'sounds_key06.wav',
        ];

        String randomSound = sounds[Random().nextInt(sounds.length)];
        int soundId = await rootBundle
            .load("assets/${randomSound}")
            .then((ByteData soundData) {
          return _pool.load(soundData);
        });
        int streamId = await _pool.play(soundId);
      }
    }
  }

  // Función que actualiza los colores del teclado
  void actualizaTeclado(String palabraIntroducida){
    // Recorremos todas las letras
    for( int i=0 ; i<teclado.length; i++){
      var letra = teclado[i].toLowerCase();
      // Si la letra del teclado está en la palabraIntroducida
      if ( palabraIntroducida.contains(letra)){
        // Para cada letra de ese tipo en la palabra
        for(int j=0; j<palabraIntroducida.length; j++){
          if(letra == palabraIntroducida[j]){
            int color = devolverColor(palabra, palabraIntroducida, j);
            listaEstados[i] = listaEstados[i]==3 ? 3 : color;
          }
        }
      }
    }
  }

  // Función llamada cada vez que se envía una palabra
  void letraEnviada(String palabraIntroducida){
    // Si la palabra está en el diccionario
    setState(() {
      filaActual++;
      letrasComprobadas.addAll(letrasFilaActual);
      letrasFilaActual = [];
      actualizaTeclado(palabraIntroducida);
      // Comprobamos si la palabra es acertada
      if( palabraIntroducida == palabra){
        int n_intentos = letrasComprobadas.length ~/ palabra.length;
        int n_maximos = palabra.length == 4 ? 5 : palabra.length==5 ? 6 : 7;
        _controller.play();
        actualizaEstadisticas(true);
        actualizaMejoresPartidas( 100 - ((n_intentos/n_maximos)*100) );
        juegoTerminado = true;
        letrasFilaActual = List.filled(palabra.length, " ");
        showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: true, palabra: palabra, resultado: letrasComprobadas);});
      }else if( filaActual == (widget.modoDeJuego+1) ){
        // Si se nos acaban los intentos
        actualizaEstadisticas(false);
        showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: false, palabra: palabra, resultado: letrasComprobadas);});
      }
    });
  }

  @override
  Widget build( BuildContext context) {

    // Función anónima llamada con cada tecla pulsada
    final teclaPulsada = (String tecla) {
      sonidoTecla(tecla);
      if( letrasFilaActual.length > 0 && tecla == 'BORRAR'){
        letrasFilaActual.removeLast();
      }else if ( tecla != "BORRAR"){
        // Si tenemos todas las letras, borramos la última para sustituirla
        if( letrasFilaActual.length == widget.modoDeJuego){
          letrasFilaActual.removeLast();
        }

        // Añadimos la nueva tecla a la lista y actualizamos la pantalla
        letrasFilaActual.add(tecla);
      }
      setState(() { });

      // DESVELAR PALABRA SI SE ESCRIBE "DIME"
      if (letrasFilaActual.length == 4 && letrasFilaActual.join('') == 'DIME') {
        mostrarMensaje(palabra);
      }

    };

    return Column(
      children: [

        // Stack que contendrá el efecto del confetti al ganar
        Stack(
          children: [
            // other widgets here
            ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              // more configuration options here
            ),
          ],
        ),

        //Matriz de casillas
        Expanded(child: GridsSuperiores(
            numero_columnas: widget.modoDeJuego,
            letrasComprobadas: letrasComprobadas,
            letrasFilaActual: letrasFilaActual,
            palabra: palabra, filaActual: filaActual
          )
        ),

        //Botón de enviar
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.green.shade800; // Color cuando el botón está presionado
                return Colors.green; // Color por defecto
              },
            ),
            shape: MaterialStateProperty.all<OutlinedBorder?>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          onPressed: () {
            sonidoInterfaz('sonidoEnviar.mp3');
            if (!juegoTerminado){
              // Acción de enviar
              if( letrasFilaActual.length < widget.modoDeJuego){
                // Si la palabra no está completa
                mostrarMensaje(S.current.palabraInsuficiente);
              }else{
                // Si la palabra está completa
                String concatenacion = letrasFilaActual.reduce((value, element) => value + element).toLowerCase();
                if ( estadoJuego.estaEnDiccionario(concatenacion) ){
                  letraEnviada(concatenacion);
                }else{
                  mostrarMensaje( concatenacion + S.current.palabraInexistente);
                }
              }
            }
          },
          child: Text(
            S.current.enviar,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 25,
            ),
          ),
        ),

        // Teclado
        Keyboard(
          TeclaPulsada: teclaPulsada,
          palabra: palabra,
          teclado: teclado,
          listaEstados: listaEstados,
        ),

        SizedBox(height: 10.0), //Agregar espacio entre el teclado y el borde inferior de la pantalla
      ],
    );
  }
}

