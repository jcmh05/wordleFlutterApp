import 'package:flutter/material.dart';

class CasillaDeLetra extends StatelessWidget {
  const CasillaDeLetra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 60,
      height: 60,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2)
      ),
    );

  }
}
