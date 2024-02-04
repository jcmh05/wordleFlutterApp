import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class EstadoJuego {
  List<String> _words = [];
  String? _selectedWord;
  final int wordLength;
  final String idioma;
  final bool entrenamiento;
  DateTime now = DateTime.now();

  EstadoJuego({required this.wordLength, required this.idioma, required this.entrenamiento});

  Future<void> init() async {
    _words = await loadWords(wordLength);
    String dateString = now.day.toString() + now.month.toString() + now.year.toString();

    if( (idioma.contains("es") || idioma.contains("en") ) && wordLength == 5 ){
      List<String> _palabras = await loadWords5(wordLength);
      int index = dateString.hashCode % (_palabras.length-1);
      _selectedWord = entrenamiento ? _palabras[Random().nextInt(_palabras.length-1)] : _palabras[index];
    }else{
      int index = dateString.hashCode % (_words.length-1);
      _selectedWord = entrenamiento ? _words[Random().nextInt(_words.length-1)] : _words[index];
    }

  }

  // Carga todas las palabras de una misma longitud del diccionario global
  Future<List<String>> loadWords(int wordLength) async {
    String jsonString = await rootBundle.loadString('assets/dictionary_${idioma}.json');
    List<String> words = List<String>.from(json.decode(jsonString));
    List<String> filteredWords = words.where((word) => word.length == wordLength).toList();
    return filteredWords;
  }

  // Carga las palabras de 5 letras de un diccionario de palabras más comunes
  Future<List<String>> loadWords5(int wordLength) async {
    String jsonString = await rootBundle.loadString('assets/dic5_${idioma}.json');
    List<String> words = List<String>.from(json.decode(jsonString));
    List<String> filteredWords = words.where((word) => word.length == wordLength).toList();
    return filteredWords;
  }

  String? get palabra => _selectedWord;

  bool estaEnDiccionario(String word) {
    return _words.contains(word);
  }
}
