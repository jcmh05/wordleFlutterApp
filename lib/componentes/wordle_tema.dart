import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordleTema {

  // Almacenar este bool después para recordar la configuración
  static bool _temaClaro = true;
  static bool get temaClaro => _temaClaro;
  static Soundpool _pool = Soundpool(streamType: StreamType.music);

  static void sonidoInterfaz() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool activado = prefs.getBool("sonidosInterfaz") ?? true;

    if( activado ){
      String sonido = temaClaro ? "assets/off.mp3" : "assets/on.mp3";
      int soundId = await rootBundle
          .load(sonido)
          .then((ByteData soundData) {
        return _pool.load(soundData);
      });
      int streamId = await _pool.play(soundId);
    }
  }

  static void setTema(bool tema){
    _temaClaro = tema;
  }

  static void cambiarTema() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _temaClaro = !_temaClaro;
    prefs.setBool("modoClaro", _temaClaro);
    sonidoInterfaz();
  }


  static TextTheme temaTextoClaro = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme temaTextoOscuro = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData claro() {
    return ThemeData(
      dividerColor: Colors.grey, //Color para borde de las casillas_letra
      accentColor: Colors.black,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white60)
        ),
      ),

      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      textTheme: temaTextoClaro,
    );
  }

  static ThemeData oscuro() {
    return ThemeData(
      dividerColor: Colors.white, //Color para borde de las casillas_letra
      accentColor: Colors.white38,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
        ),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      textTheme: temaTextoOscuro,
    );
  }
}