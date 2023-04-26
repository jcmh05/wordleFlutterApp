import 'package:flutter/material.dart';
import 'package:wordle/componentes/componentes.dart';
import 'package:wordle/modelos/modelos.dart';
import 'package:wordle/funciones/funciones.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:confetti/confetti.dart';


class Juego extends StatefulWidget{
  final int modoDeJuego;  // Nº de letras de la palabra
  const Juego({Key? key, required this.modoDeJuego}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JuegoState();

}

class _JuegoState extends State<Juego> {

  // CONFIGURACIÓN IDIOMA
  final int idioma = 0; //0-Español  1-Inglés  2-Francés

  final tecladoEspanol = ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'];
  final tecladoIngles = ['Q','W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BORRAR'];
  final tecladoFrances = ['A','Z', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Q', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'W', 'X', 'C', 'V', 'B', 'N', 'BORRAR'];

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
    teclado = idioma== 0 ? tecladoEspanol : idioma==1 ? tecladoIngles : tecladoFrances;
    listaEstados = List<int>.filled(teclado.length, 0);
    filaActual = 0;
    palabra = " ";
    estadoJuego = EstadoJuego(wordLength: widget.modoDeJuego);
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

  @override
  Widget build( BuildContext context) {

    // Función llamada con cada tecla pulsada
    final teclaPulsada = (String tecla) {
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

    // Función que actualiza los colores del teclado
    void actualizaTeclado(String palabraIntroducida){
      // Recorremos todas las letras
      for( int i=0 ; i<teclado.length; i++){
        var letra = teclado[i].toLowerCase();
        if ( palabraIntroducida.contains(letra)){
          // Para cada letra de la palabra introducida
          int color = devolverColor(palabra, palabraIntroducida, palabraIntroducida.indexOf(letra));
          listaEstados[i] = listaEstados[i]==3 ? 3 : color;
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
          _controller.play();
          showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: true, palabra: palabra, resultado: letrasComprobadas);});
        }else if( filaActual == (widget.modoDeJuego+1) ){
          // Si se nos acaban los intentos
          showDialog(context: context, builder:(context){return VentanaFinDeJuego(victoria: false, palabra: palabra, resultado: letrasComprobadas);});
        }
      });
    }

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
            // Acción de enviar
            if( letrasFilaActual.length < widget.modoDeJuego){
              // Si la palabra no está completa
              mostrarMensaje("No hay suficientes letras");
            }else{
              // Si la palabra está completa
              String concatenacion = letrasFilaActual.reduce((value, element) => value + element).toLowerCase();
              if ( estadoJuego.estaEnDiccionario(concatenacion) ){
                letraEnviada(concatenacion);
              }else{
                mostrarMensaje( concatenacion + " no está en nuestro diccionario");
              }
            }
          },
          child: Text(
            'ENVIAR',
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