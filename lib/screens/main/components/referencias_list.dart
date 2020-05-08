import 'package:bniapp/models/asistencia.dart';
import 'package:bniapp/screens/main/components/referencia_item.dart';
import 'package:bniapp/screens/view-referencia/view_referencia_screen.dart';
import 'package:bniapp/services/asistencia_service.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:flutter/material.dart';

class ReferenciasList extends StatefulWidget {
  @override
  _ReferenciasListState createState() => _ReferenciasListState();
}

class _ReferenciasListState extends State<ReferenciasList> {
  AsistenciaService _asistenciaService = new AsistenciaService();
  AppState _appState = AppState.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Asistencia>>(
      stream: _asistenciaService.listByIdMiembro(_appState.miembro.idMiembro),
      builder:
          (BuildContext context, AsyncSnapshot<List<Asistencia>> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            final asistencias = snapshot.data;
            return ListView.separated(
              itemCount: asistencias.length,
              itemBuilder: (BuildContext context, int index) {
                return ReferenciaItem(
                  onTap: () {
                    Navigator.pushNamed(context, ViewReferenciaScreen.id,
                        arguments: ViewReferenciaScreenArguments(
                            asistencia: asistencias[index]));
                  },
                  nombre: asistencias[index].referencia.nombre,
                  cargo: asistencias[index].referencia.cargo,
                  empresa: asistencias[index].referencia.empresa,
                  fechaHora: asistencias[index].fechaHora,
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
        }
      },
    );
  }
}
