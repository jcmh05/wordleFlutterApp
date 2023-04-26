import 'package:flutter/material.dart';

class VentanaAjustes extends StatelessWidget {

  const VentanaAjustes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        title: Center(
          child: Text('Ajustes'),
        ),
        content: SingleChildScrollView(
          child: Center(
            child: Text(
              "Ajustes por hacer",
              style: TextStyle(

              ),
            ),
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
        )

    );


  }

}