import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

import '../generated/l10n.dart';

class VentanaAjustes extends StatefulWidget {
  final AudioPlayer player;
  const VentanaAjustes({Key? key, required this.player}) : super(key: key);

  @override
  _VentanaAjustesState createState() => _VentanaAjustesState();
}

class _VentanaAjustesState extends State<VentanaAjustes> {
  bool sonidosInterfaz = true;
  bool sonidosTeclado = false;
  double _volumen = 0.5; // valor de volumen predeterminado
  bool musica = true;
  String _cancionSeleccionada = "Elevator1.mp3";
  final _scrollController = FixedExtentScrollController();
  List<String> canciones = ["Elevator Music #1","Elevator Music #2","Jazz #1","Jazz #2","Blue Label"];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sonidosInterfaz = prefs.getBool('sonidosInterfaz') ?? true;
      sonidosTeclado= prefs.getBool('sonidosTeclado') ?? true;
      musica = prefs.getBool('musica') ?? false;
      _volumen = prefs.getDouble('volumenMusica') ?? 0.5;
      _cancionSeleccionada = prefs.getString("cancionEscogida") ?? "Elevator1.mp3";
    });
  }

  void _setSonidosInterfaz(bool value) async{
    setState(() {
      sonidosInterfaz = value;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("sonidosInterfaz", value);
  }

  void _setSonidosTeclado(bool value) async{
    setState(() {
      sonidosTeclado = value;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("sonidosTeclado", value);
  }

  void _setMusica(bool value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("musica", value);
    if( !value ){
      // Paramos la música
      widget.player.stop();
    }else{
      String cancion = prefs.getString("cancionEscogida") ?? 'Elevator1.mp3';
      double volumen = prefs.getDouble("volumenMusica") ?? 0.15;
      await widget.player.setVolume(volumen);
      await widget.player.play(AssetSource(cancion));
      await widget.player.setReleaseMode(ReleaseMode.loop);
    }
    setState(() {
      musica = value;
    });
  }

  void _volumenMusica(double volumen) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volumenMusica', volumen);
    widget.player.setVolume(volumen);
  }

  void cancionElegida(String seleccion) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String cancion = "Elevator1.mp3";
    if( seleccion == "Elevator Music #2"){ cancion = "Elevator2.mp3"; }
    if( seleccion == "Jazz #1"){ cancion = "Jazz1.mp3"; }
    if( seleccion == "Jazz #2"){ cancion = "Jazz2.mp3"; }
    if( seleccion == "Blue Label"){ cancion = "Elegant.mp3"; }

    await prefs.setString('cancionEscogida', cancion);
    if( musica ){
      await widget.player.stop();
      await widget.player.play(AssetSource(cancion));
      await widget.player.setReleaseMode(ReleaseMode.loop);
    }
    setState(() {
      _cancionSeleccionada = cancion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(S.current.ajustes),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Ajusta el ancho del AlertDialog
          child: Column(
            children: [
              // Ajuste 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.current.sonidosInterfaz),
                  Switch(
                    value: sonidosInterfaz,
                    onChanged: _setSonidosInterfaz,
                  ),
                ],
              ),

              // Ajuste 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.current.sonidosTeclado),
                  Switch(
                    value: sonidosTeclado,
                    onChanged: _setSonidosTeclado,
                  ),
                ],
              ),
              // Ajuste 3

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.current.musica),
                  Switch(
                    value: musica,
                    onChanged: _setMusica,
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    _volumen == 0 ? "🔇" : _volumen <= 0.15 ? "🔈": _volumen <= 0.5 ? "🔉" : "🔊",
                  ),
                  Expanded(
                    child: Slider(
                      value: _volumen,
                      min: 0.0,
                      max: 1.0,
                      divisions: 20,
                      label: S.current.volumenMusica + " ${(_volumen * 100).toInt()}%",
                      onChanged: (value) {
                        setState(() {
                          _volumen = value;
                        });
                      },
                      onChangeEnd: (value) {
                        _volumenMusica(value);
                      },
                    ),
                  ),
                ]
              ),
              SizedBox(height: 16),
              Text(S.current.cancion),
              SizedBox(height: 15),
              DropdownButton<String>(
                hint: Text(S.current.cancionHint),
                value: _cancionSeleccionada == "Elevator1.mp3" ? "Elevator Music #1" : _cancionSeleccionada == "Elevator2.mp3" ? "Elevator Music #2" : _cancionSeleccionada == "Jazz1.mp3" ? "Jazz #1" : _cancionSeleccionada == "Jazz2.mp3" ? "Jazz #2" : "Blue Label",
                onChanged: (newValue) {
                  cancionElegida(newValue!);
                },
                items: canciones.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
