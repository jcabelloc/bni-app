import 'package:bniapp/components/miembro_card.dart';
import 'package:bniapp/models/asistencia.dart';
import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:bniapp/screens/save_referencia/save_referencia_screen.dart';
import 'package:bniapp/services/asistencia_service.dart';
import 'package:flutter/material.dart';

class ReferenciaPage extends StatefulWidget {
  final Miembro miembro;
  final Sesion proximaSesion;
  ReferenciaPage({this.miembro, this.proximaSesion});

  @override
  _ReferenciaPageState createState() => _ReferenciaPageState();
}

class _ReferenciaPageState extends State<ReferenciaPage> {
  final _asistenciaService = new AsistenciaService();
  Asistencia proximaAsistencia;

  @override
  void initState() {
    initData();
  }

  void initData() async {
    if (widget.miembro != null && widget.proximaSesion != null) {
      proximaAsistencia = await _asistenciaService.getById(
          widget.proximaSesion.idSesion, widget.miembro.idMiembro);
    }
    setState(() {
      proximaAsistencia = proximaAsistencia;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MiembroCard(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: InkWell(
              splashColor: Theme.of(context).primaryColor.withAlpha(30),
              onTap: () async {
                var result =
                    await Navigator.pushNamed(context, SaveReferenciaScreen.id);
                if (result != null) initData();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Mi referencia ingresada',
                      style: Theme.of(context).textTheme.headline.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  Divider(
                    height: 4,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text(proximaAsistencia?.referencia?.empresa ?? ''),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text(proximaAsistencia?.referencia?.cargo ?? ''),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(proximaAsistencia?.referencia?.nombre ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
