import 'package:bniapp/components/miembro_card.dart';
import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  final Miembro miembro;
  final Sesion proximaSesion;

  InicioPage({this.miembro, this.proximaSesion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MiembroCard(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    width: 128,
                    child: Image.asset('images/bni_logo.jpg'),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Recuerde que su próxima sesión es el dia Jueves 3 de Mayo del 2020 ' +
                        (proximaSesion?.fechaHora ?? DateTime.now())
                            .toIso8601String(),
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
