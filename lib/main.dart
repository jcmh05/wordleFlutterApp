import 'package:flutter/material.dart';
import 'package:com.jc.wordel/pantallas/pantallas.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const PantallaPrincipal());
  });
}