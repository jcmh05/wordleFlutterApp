import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'componentes.dart';

class VentanaEntrenamiento extends StatelessWidget {

  const VentanaEntrenamiento({Key? key}) : super(key: key);

  static const double padding =20;
  static const double avatarRadio =45;



  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: padding,top: avatarRadio + padding, right: padding,bottom: padding ),
          margin: EdgeInsets.only(top: avatarRadio),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color:  WordleTema.temaClaro ? Colors.white : Color(0xFF303030),
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [ BoxShadow(color: Colors.black,offset: Offset(0,10), blurRadius: 10) ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(S.current.textoEntrenamiento,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),

              // BOTÓN MODO 4
              Button3d(
                  style: Button3dStyle(
                    topColor: Colors.grey,
                    backColor: Color(0xFF2C2C2C),
                  ),
                  onPressed: () {
                    Navigator.pop(context,4);
                  },
                  child: Text(
                      S.current.modo4,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Fuente botón
                        fontSize: 22.0, // Tamaño fuente
                        color: Colors.white,
                        fontFamily: 'Arial', // Fuente
                      )
                  ),
              ),


              SizedBox(height: 15,),

              // BOTÓN MODO CLÁSICO
              Button3d(
                style: Button3dStyle(
                  topColor: Color(0xFFc9b457),
                  backColor: Color(0xFF8F8D00),
                ),
                onPressed: () {
                  Navigator.pop(context,5);
                },
                child: Text(
                    S.current.modo5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Fuente botón
                      fontSize: 22.0, // Tamaño fuente
                      color: Colors.white,
                      fontFamily: 'Arial', // Fuente
                    )
                ),
              ),

              SizedBox(height: 15,),

              // BOTÓN MODO 6
              Button3d(
                style: Button3dStyle(
                  topColor: Color(0xFF6baa65),
                  backColor: Color(0xFF276507),
                ),
                onPressed: () {
                  Navigator.pop(context,6);
                },
                child: Text(
                    S.current.modo6,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Fuente botón
                      fontSize: 22.0, // Tamaño fuente
                      color: Colors.white,
                      fontFamily: 'Arial', // Fuente
                    )
                ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(S.current.cerrar)),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadio,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatarRadio)),
                child: WordleTema.temaClaro ? Image.asset("assets/bt2_white.jpg") : Image.asset("assets/bt2_dark.jpg"),
            ),
          ),
        ),
      ],
    );
  }

}