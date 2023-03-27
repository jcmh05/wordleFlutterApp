import 'package:flutter/material.dart';
import './pantallas/pantallas.dart';

class WordleApp extends StatelessWidget{
  const WordleApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue,),
        home: WordlePaginaPrincipal(),
    );
  }
}