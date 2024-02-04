import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:com.jc.wordel/componentes/componentes.dart';
import 'package:com.jc.wordel/modelos/modelos.dart';
import 'package:com.jc.wordel/funciones/funciones.dart';
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
  DateTime now = DateTime.now();

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
  var filaActual = 0;
  var palabra;
  var teclado;

  // Lista de los colores de cada tecla del teclado
  List<int> listaEstados = List<int>.empty();

  ConfettiController _controller = ConfettiController();

  // Lista de letras con la fila que se está escribiendo
  List<String> letrasFilaActual = [];

  // Lista de las letras que ya se han comprobado
  List<String> letrasComprobadas = [];

  @override
  void initState(){
    super.initState();
    teclado = teclados[widget.idioma];
    listaEstados = List<int>.filled(teclado.length, 0);
    estadoJuego = EstadoJuego(wordLength: widget.modoDeJuego, idioma: widget.idioma, entrenamiento: false);
    loadPreferences();
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Comprobamos si es un día nuevo
    String diaActual = now.day.toString() + now.month.toString() + now.year.toString();
    String diaGuardado = prefs.getString("diaGuardado_" + widget.idioma) ?? "0";


    if( diaActual != diaGuardado){
      // Reseteamos la palabra del día
      prefs.setStringList("letrasComprobadas_" + widget.idioma, []);
      prefs.setInt("filaActual_" + widget.idioma, 0);
      prefs.setString("palabra_" + widget.idioma, " ");
      prefs.remove("listaEstados_" + widget.idioma);
      prefs.setBool("juegoTerminado_" + widget.idioma, false);
    }

    // Comprobamos si el juego ya estaba empezado o no
    palabra = prefs.getString("palabra_" + widget.idioma) ?? " ";
    if ( palabra == " "){

      // Si el juego no está empezado buscamos nueva palabra y guardamos el día
      estadoJuego.init().then((_) {
        palabra = estadoJuego.palabra;
      });
      prefs.setString("diaGuardado_" + widget.idioma, now.day.toString() + now.month.toString() + now.year.toString());

    }else{

      // Si el juego está empezado tan solo inicializamos el diccionario
      estadoJuego.init();

    }

    // Recuperamos la lista de estados
    List<String> listaString = (prefs.getStringList('listaEstados_' + widget.idioma) ?? List<String>.filled(teclado.length, "0") );

    setState(() {
      letrasComprobadas = prefs.getStringList("letrasComprobadas_" + widget.idioma) ?? [];
      filaActual = prefs.getInt("filaActual_" + widget.idioma) ?? 0;
      juegoTerminado = prefs.getBool("juegoTerminado_" + widget.idioma) ?? false;
      listaEstados = listaString.map((i) => int.parse(i)).toList();
    });

  }

  void compartirTexto( String texto ) {
    Share.share(texto);
  }

  String textoAlCompartir( ){
    int n_intentos = letrasComprobadas.length ~/ palabra.length;
    int n_maximos = palabra.length == 4 ? 5 : palabra.length==5 ? 6 : 7;
    String texto = "WORDEL " + S.current.bandera +" - " + n_intentos.toString() + "/" + n_maximos.toString();

    List<String> emojis = ['😀', '😁', '😂', '🤠', '😄', '🤑', '😆', '😴', '🐄', '😉', '😊', '🤯', '😌', '🥴', '😎'];
    Random random = Random();
    String emojiAleatorio = emojis[random.nextInt(emojis.length)];
    texto += n_intentos==n_maximos ? "😅\n\n" : n_intentos<=2 ? "🥱🥱🥱\n\n" : emojiAleatorio + "\n\n";

    for( int i=0; i<letrasComprobadas.length; i++){
      if ( i%palabra.length == 0 && i>0){
        texto += "\n";
      }

      int indice = (i % palabra.length).toInt();
      String palabraIntroducida = "";
      for(int j=0; j<palabra.length; j++){
        palabraIntroducida += letrasComprobadas[(i-indice)+j].toLowerCase();
      }

      int numero = devolverColor(palabra, palabraIntroducida, indice);
      String color = numero==1 ? "⬜" : numero==2 ? "🟨" : "🟩";
      texto += color + " ";
    }

    return texto;
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
      mejoresNombres.insert(indiceMenorPuntaje, now.day.toString() + "/" + now.month.toString() + "/" + now.year.toString() +": " + palabra);
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

  // Guarda la comprobación en la memoria del dispositivo
  void _actualizarMemoria() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("letrasComprobadas_" + widget.idioma, letrasComprobadas);
    prefs.setInt("filaActual_" + widget.idioma, filaActual);
    prefs.setString("palabra_" + widget.idioma, palabra);
    prefs.setBool("juegoTerminado_" + widget.idioma, juegoTerminado);
    prefs.setStringList("listaEstados_" + widget.idioma, listaEstados.map((i) => i.toString()).toList());
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
        showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: true,entrenamiento: false,palabra: palabra, resultado: letrasComprobadas);});
      }else if( filaActual == (widget.modoDeJuego+1) ){
        // Si se nos acaban los intentos
        actualizaEstadisticas(false);
        juegoTerminado = true;
        showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: false,entrenamiento: false,palabra: palabra, resultado: letrasComprobadas);});
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

        //Botón enviar
        Transform.scale(
          scale: juegoTerminado ? 0.7 : 0.6,
          child: ClickyButton(
            child: Text(
              juegoTerminado ? S.current.compartir.toUpperCase() : S.current.enviar,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: juegoTerminado ? 25 : 40,
              ),
            ),
            color: Colors.green,
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
                    _actualizarMemoria();
                  }else{
                    mostrarMensaje( concatenacion + S.current.palabraInexistente);
                  }
                }
              }else{
                compartirTexto(textoAlCompartir());
              }
            },
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

