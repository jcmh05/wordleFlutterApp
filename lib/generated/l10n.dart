// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WORD OF THE DAY`
  String get boton1menu {
    return Intl.message(
      'WORD OF THE DAY',
      name: 'boton1menu',
      desc: '',
      args: [],
    );
  }

  /// `TRAINING`
  String get boton2menu {
    return Intl.message(
      'TRAINING',
      name: 'boton2menu',
      desc: '',
      args: [],
    );
  }

  /// `TUTORIAL`
  String get boton3menu {
    return Intl.message(
      'TUTORIAL',
      name: 'boton3menu',
      desc: '',
      args: [],
    );
  }

  /// `Game Statistics`
  String get tituloEstadisticas {
    return Intl.message(
      'Game Statistics',
      name: 'tituloEstadisticas',
      desc: '',
      args: [],
    );
  }

  /// `🕹 GAMES\nPLAYED`
  String get partidas {
    return Intl.message(
      '🕹 GAMES\nPLAYED',
      name: 'partidas',
      desc: '',
      args: [],
    );
  }

  /// `🏆 GAMES\nWON`
  String get ganadas {
    return Intl.message(
      '🏆 GAMES\nWON',
      name: 'ganadas',
      desc: '',
      args: [],
    );
  }

  /// `📈 VICTORIES\n(%)`
  String get porcentaje {
    return Intl.message(
      '📈 VICTORIES\n(%)',
      name: 'porcentaje',
      desc: '',
      args: [],
    );
  }

  /// `🥀 GAMES\nLOST`
  String get perdidas {
    return Intl.message(
      '🥀 GAMES\nLOST',
      name: 'perdidas',
      desc: '',
      args: [],
    );
  }

  /// `🔥 CURRENT\nSTREAK`
  String get racha {
    return Intl.message(
      '🔥 CURRENT\nSTREAK',
      name: 'racha',
      desc: '',
      args: [],
    );
  }

  /// `⚡ BEST\nSTREAK`
  String get mejorRacha {
    return Intl.message(
      '⚡ BEST\nSTREAK',
      name: 'mejorRacha',
      desc: '',
      args: [],
    );
  }

  /// `Top Games`
  String get tituloTop {
    return Intl.message(
      'Top Games',
      name: 'tituloTop',
      desc: '',
      args: [],
    );
  }

  /// `Format Stats`
  String get botonFormateo {
    return Intl.message(
      'Format Stats',
      name: 'botonFormateo',
      desc: '',
      args: [],
    );
  }

  /// `Stats Erased`
  String get confirmarFormateo {
    return Intl.message(
      'Stats Erased',
      name: 'confirmarFormateo',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get cerrar {
    return Intl.message(
      'Close',
      name: 'cerrar',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get compartir {
    return Intl.message(
      'Share',
      name: 'compartir',
      desc: '',
      args: [],
    );
  }

  /// `SEND`
  String get enviar {
    return Intl.message(
      'SEND',
      name: 'enviar',
      desc: '',
      args: [],
    );
  }

  /// ` is not in our dictionary`
  String get palabraInexistente {
    return Intl.message(
      ' is not in our dictionary',
      name: 'palabraInexistente',
      desc: '',
      args: [],
    );
  }

  /// `Not enough letters`
  String get palabraInsuficiente {
    return Intl.message(
      'Not enough letters',
      name: 'palabraInsuficiente',
      desc: '',
      args: [],
    );
  }

  /// `You won! 🏆`
  String get tituloVictoria {
    return Intl.message(
      'You won! 🏆',
      name: 'tituloVictoria',
      desc: '',
      args: [],
    );
  }

  /// `You lost! 😢`
  String get tituloDerrota {
    return Intl.message(
      'You lost! 😢',
      name: 'tituloDerrota',
      desc: '',
      args: [],
    );
  }

  /// `The word was: `
  String get textoDerrota {
    return Intl.message(
      'The word was: ',
      name: 'textoDerrota',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!\n \nShare the result with all your friends`
  String get textoVictoria {
    return Intl.message(
      'Congratulations!\n \nShare the result with all your friends',
      name: 'textoVictoria',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!\n\nPlay again as much as you want`
  String get textoVictoriaEntrenamiento {
    return Intl.message(
      'Congratulations!\n\nPlay again as much as you want',
      name: 'textoVictoriaEntrenamiento',
      desc: '',
      args: [],
    );
  }

  /// `Statistics are only stored for games played in the word of the day`
  String get avisoEstadisticas {
    return Intl.message(
      'Statistics are only stored for games played in the word of the day',
      name: 'avisoEstadisticas',
      desc: '',
      args: [],
    );
  }

  /// `Back to menu`
  String get volverAlMenu {
    return Intl.message(
      'Back to menu',
      name: 'volverAlMenu',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get ajustes {
    return Intl.message(
      'Settings',
      name: 'ajustes',
      desc: '',
      args: [],
    );
  }

  /// `📱 Interface sounds`
  String get sonidosInterfaz {
    return Intl.message(
      '📱 Interface sounds',
      name: 'sonidosInterfaz',
      desc: '',
      args: [],
    );
  }

  /// `⌨ Keyboard sounds`
  String get sonidosTeclado {
    return Intl.message(
      '⌨ Keyboard sounds',
      name: 'sonidosTeclado',
      desc: '',
      args: [],
    );
  }

  /// `🎵 Music`
  String get musica {
    return Intl.message(
      '🎵 Music',
      name: 'musica',
      desc: '',
      args: [],
    );
  }

  /// `Music volume:`
  String get volumenMusica {
    return Intl.message(
      'Music volume:',
      name: 'volumenMusica',
      desc: '',
      args: [],
    );
  }

  /// `Selected song:`
  String get cancion {
    return Intl.message(
      'Selected song:',
      name: 'cancion',
      desc: '',
      args: [],
    );
  }

  /// `Select a song`
  String get cancionHint {
    return Intl.message(
      'Select a song',
      name: 'cancionHint',
      desc: '',
      args: [],
    );
  }

  /// `MODE 4`
  String get modo4 {
    return Intl.message(
      'MODE 4',
      name: 'modo4',
      desc: '',
      args: [],
    );
  }

  /// `CLASSIC`
  String get modo5 {
    return Intl.message(
      'CLASSIC',
      name: 'modo5',
      desc: '',
      args: [],
    );
  }

  /// `MODE 6`
  String get modo6 {
    return Intl.message(
      'MODE 6',
      name: 'modo6',
      desc: '',
      args: [],
    );
  }

  /// `Practice unlimitedly!`
  String get textoEntrenamiento {
    return Intl.message(
      'Practice unlimitedly!',
      name: 'textoEntrenamiento',
      desc: '',
      args: [],
    );
  }

  /// `HOW TO PLAY`
  String get tutorialTitulo {
    return Intl.message(
      'HOW TO PLAY',
      name: 'tutorialTitulo',
      desc: '',
      args: [],
    );
  }

  /// `The game consists of guessing the hidden word. The word changes every day and will always be the same for everyone.\n\nEach attempt must be a valid word. When entering a word, each letter is colored based on whether it is present or not in the word, and whether it is in the correct position.`
  String get tutorialTexto {
    return Intl.message(
      'The game consists of guessing the hidden word. The word changes every day and will always be the same for everyone.\n\nEach attempt must be a valid word. When entering a word, each letter is colored based on whether it is present or not in the word, and whether it is in the correct position.',
      name: 'tutorialTexto',
      desc: '',
      args: [],
    );
  }

  /// `GREEN means the letter is in the word and is in the CORRECT position`
  String get tutorialVerde {
    return Intl.message(
      'GREEN means the letter is in the word and is in the CORRECT position',
      name: 'tutorialVerde',
      desc: '',
      args: [],
    );
  }

  /// `YELLOW means the letter is present in the word but is in the WRONG position`
  String get tutorialAmarillo {
    return Intl.message(
      'YELLOW means the letter is present in the word but is in the WRONG position',
      name: 'tutorialAmarillo',
      desc: '',
      args: [],
    );
  }

  /// `GRAY means the letter is NOT present in the word`
  String get tutorialGris {
    return Intl.message(
      'GRAY means the letter is NOT present in the word',
      name: 'tutorialGris',
      desc: '',
      args: [],
    );
  }

  /// `🇬🇧`
  String get bandera {
    return Intl.message(
      '🇬🇧',
      name: 'bandera',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
