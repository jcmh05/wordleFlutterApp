import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> loadWords(int wordLength) async {
  // Asume que el archivo JSON se encuentra en la carpeta 'assets' y se llama 'diccionario_espanol.json'
  String jsonString = await rootBundle.loadString('assets/dictionary.json');
  List<String> words = List<String>.from(json.decode(jsonString));
  List<String> filteredWords = words.where((word) => word.length == wordLength).toList();
  return filteredWords;
}