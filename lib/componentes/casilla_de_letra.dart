import 'package:flutter/material.dart';

class CasillaDeLetra extends StatelessWidget {
  final double anchura;
  final double altura;
  const CasillaDeLetra({Key? key, required this.anchura, required this.altura}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: anchura,
      height: altura,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2)
      ),
    );
  }
}