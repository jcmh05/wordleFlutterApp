import 'package:flutter/material.dart';
import 'package:com.jc.wordel/pantallas/pantallas.dart';
import 'package:com.jc.wordel/componentes/componentes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';



class PantallaPrincipal extends StatefulWidget{

  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PantallaPrincipalState();

}


enum MenuOptions { opcion1, opcion2, opcion3 }

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  static Soundpool _pool = Soundpool(streamType: StreamType.music);
  String idiomaSeleccionado = "es";

  void _cambiarIdioma(String nuevoIdioma) async{
    sonidoInterfaz('pop2');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("idioma", nuevoIdioma);
    Locale idioma = Locale('$nuevoIdioma');
    setState(() {
      idiomaSeleccionado = nuevoIdioma;
      S.load(idioma);
    });
  }

  void actualizarMenu() {
    setState(() {});
  }

  void cargarPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nuevoIdioma = prefs.getString('idioma') ?? 'es';
    Locale idioma = Locale('$nuevoIdioma');
    idiomaSeleccionado = nuevoIdioma;
    bool modoClaro = prefs.getBool("modoClaro") ?? true;
    setState(() {
      S.load(idioma);
      if ( !modoClaro ){
        WordleTema.setTema(false);
      }
    });


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cargarPreferencias();
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
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72.0,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              onSelected: _cambiarIdioma,
              icon: Image.asset('assets/bandera_${idiomaSeleccionado}.png'),
              itemBuilder: (BuildContext context) {
                sonidoInterfaz('pop1');
                return [
                  PopupMenuItem<String>(
                    value: 'es',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_es.png', width: 24),
                        SizedBox(width: 8),
                        Text('Español'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_en.png', width: 24),
                        SizedBox(width: 8),
                        Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'fr',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_fr.png', width: 24),
                        SizedBox(width: 8),
                        Text('Français'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'ca',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_ca.png', width: 24),
                        SizedBox(width: 8),
                        Text('Català'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'it',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_it.png', width: 24),
                        SizedBox(width: 8),
                        Text('Italiano'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'da',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_da.png', width: 24),
                        SizedBox(width: 8),
                        Text('Deutsch'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'zh',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_zh.png', width: 24),
                        SizedBox(width: 8),
                        Text('中国人'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
          actions: [
            IconButton(
              icon: WordleTema.temaClaro ? Icon(Icons.nightlight_outlined) : Icon(Icons.nightlight),
              onPressed: () {
                WordleTema.cambiarTema();
                actualizarMenu();
              },
            ),
          ],
        ),
        body: Menu(
            actualizarTema: actualizarMenu,
            idioma: idiomaSeleccionado,
        ),
      ),
    );
  }

}