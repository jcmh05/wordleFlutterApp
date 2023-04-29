import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class EstadoJuego {
  List<String> _words = [];
  String? _selectedWord;
  final int wordLength;
  final String idioma;

  EstadoJuego({required this.wordLength, required this.idioma});

  Future<void> init() async {
    _words = await loadWords(wordLength);
    _selectedWord = _words[Random().nextInt(_words.length-1)];
  }

  Future<List<String>> loadWords(int wordLength) async {
    String jsonString = await rootBundle.loadString('assets/dictionary_${idioma}.json');
    List<String> words = List<String>.from(json.decode(jsonString));
    List<String> filteredWords = words.where((word) => word.length == wordLength).toList();
    return filteredWords;
  }

  String? get palabra => _selectedWord;

  bool estaEnDiccionario(String word) {
    return _words.contains(word);
  }
}
