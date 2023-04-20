import 'package:flutter/material.dart';

class CasillaDeLetra extends StatelessWidget {
  final String letra;
  final tamano_letra = 0.8;
  const CasillaDeLetra({Key? key,required this.letra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor, width: 2)
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                letra,
                style: TextStyle(
                  fontSize: constraints.maxHeight * tamano_letra,
                ),
              ),
            ),
          )
        );
      },
    );


  }
}