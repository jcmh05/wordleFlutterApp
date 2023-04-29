import 'package:flutter/material.dart';

class VentanaAjustes extends StatefulWidget {
  const VentanaAjustes({Key? key}) : super(key: key);

  @override
  _VentanaAjustesState createState() => _VentanaAjustesState();
}

class _VentanaAjustesState extends State<VentanaAjustes> {
  bool _ajuste1 = false;
  bool _ajuste2 = true;

  void _ajuste1Changed(bool value) {
    setState(() {
      _ajuste1 = value;
    });
    // Llamar a una función al cambiar el estado de _ajuste1
    _handleAjuste1(_ajuste1);
  }

  void _ajuste2Changed(bool value) {
    setState(() {
      _ajuste2 = value;
    });
    // Llamar a una función al cambiar el estado de _ajuste2
    _handleAjuste2(_ajuste2);
  }

  // Función que se llama al cambiar el estado de _ajuste1
  void _handleAjuste1(bool value) {
    print('Ajuste 1 cambió a $value');
  }

  // Función que se llama al cambiar el estado de _ajuste2
  void _handleAjuste2(bool value) {
    print('Ajuste 2 cambió a $value');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Ajustes'),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Ajuste 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ajuste 1'),
                Switch(
                  value: _ajuste1,
                  onChanged: _ajuste1Changed,
                ),
              ],
            ),
            // Ajuste 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ajuste 2'),
                Switch(
                  value: _ajuste2,
                  onChanged: _ajuste2Changed,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
