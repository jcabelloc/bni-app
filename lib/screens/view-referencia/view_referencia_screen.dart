import 'package:bniapp/models/asistencia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'components/text_container.dart';

class ViewReferenciaScreen extends StatelessWidget {
  static const String id = 'view_referencia_screen';

  @override
  Widget build(BuildContext context) {
    final ViewReferenciaScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Referencia'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    textContainer(
                      "Nombre : " + args.asistencia.referencia.nombre,
                    ),
                    textContainer(
                      "Cargo : " + args.asistencia.referencia.cargo,
                    ),
                    textContainer(
                      "Empresa : " + args.asistencia.referencia.empresa,
                    ),
                    textContainer(
                      "Lugar : " + args.asistencia.lugarSesion,
                    ),
                    textContainer(
                      "Fecha : " +
                          DateFormat("dd 'de' MMMM 'del' yyyy", 'es')
                              .format(args?.asistencia?.fechaHora),
                    ),
                    textContainer(
                      "Hora : " +
                          DateFormat("HH':'mm", 'es')
                              .format(args?.asistencia?.fechaHora),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewReferenciaScreenArguments {
  final Asistencia asistencia;

  ViewReferenciaScreenArguments({this.asistencia});
}
