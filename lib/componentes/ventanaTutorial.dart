import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'componentes.dart';

class VentanaTutorial extends StatelessWidget {
  final String idioma;

  const VentanaTutorial({Key? key, required this.idioma}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Widget letra(String letra, Color fondo){
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: fondo,
              border: Border.all(color: Theme.of(context).dividerColor, width: 2)
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                letra,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          )
      );
    }

    return AlertDialog(
      title: Center(
        child: Text(S.current.tutorialTitulo),
      ),
      content: SingleChildScrollView(
        // ESTADÍSTICAS
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Ajusta el ancho del AlertDialog
          child: Column(
            children: [

              Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),

              SizedBox(height: 7,),

              Text(
                S.current.tutorialTexto,
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 7,),

              Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),

              SizedBox(height: 7,),

              // Fila letra verde
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  letra(" A ", Color(0xFF6baa65)),
                  Expanded(
                    child: Text(
                      S.current.tutorialVerde,
                        textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),

              // Fila letra amarilla
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  letra(" C ", Color(0xFFc9b457)),
                  Expanded(
                    child: Text(
                        S.current.tutorialAmarillo,
                        textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),

              // Fila letra gris
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  letra(" N ",  Color(0xFF787C7F)),
                  Expanded(
                    child: Text(
                        S.current.tutorialGris,
                        textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),

              ///////// Ejemplo solo en español (pereza hacer los demás)
              if( idioma == "es")
                Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 2,
                    ),
                    Text(
                      "EJEMPLO",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("Imagina que la palabra oculta es QUESO y empezamos introduciendo la palabra PERRO"),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded( child: letra(" P ", Color(0xFF787C7F)), ),
                        Expanded( child: letra(" E ", Color(0xFFc9b457)), ),
                        Expanded( child: letra(" R ", Color(0xFF787C7F)), ),
                        Expanded( child: letra(" R ", Color(0xFF787C7F)), ),
                        Expanded( child: letra(" O ", Color(0xFF6baa65)), ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("La letra E se colorea de amarillo porque está en la palabra QUESO pero no en esa posición\n\nLa letra O se colorea de verde porque se encuentra en la palabra y en la posición correcta"),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded( child: letra(" S ", Color(0xFFc9b457)), ),
                        Expanded( child: letra(" U ", Color(0xFF6baa65)), ),
                        Expanded( child: letra(" S ", Color(0xFFc9b457)), ),
                        Expanded( child: letra(" T ", Color(0xFF787C7F)), ),
                        Expanded( child: letra(" O ", Color(0xFF6baa65)), ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Probamos ahora con  SUSTO\n\nLas letras S se marcan en amarillo ya que en QUESO la S está en cuarta posición"),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded( child: letra(" Q ", Color(0xFF6baa65)), ),
                        Expanded( child: letra(" U ", Color(0xFF6baa65)), ),
                        Expanded( child: letra(" E ", Color(0xFF6baa65)), ),
                        Expanded( child: letra(" S ", Color(0xFF6baa65)), ),
                        Expanded( child: letra(" O ", Color(0xFF6baa65)), ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Finalmente, tras varios intentos, todas las letras deberían ser verdes")
                  ],
                ),
              //////////////////////////Fin del ejemplo en español

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