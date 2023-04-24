import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> loadWords(int wordLength) async {
  String jsonString = await rootBundle.loadString('assets/dictionary.json');
  List<String> words = List<String>.from(json.decode(jsonString));
  List<String> filteredWords = words.where((word) => word.length == wordLength).toList();
  return filteredWords;
}