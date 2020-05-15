import 'package:bniapp/models/asistencia.dart';
import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/screens/main/components/referencia_item.dart';
import 'package:bniapp/screens/view-referencia/view_referencia_screen.dart';
import 'package:bniapp/services/asistencia_service.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenciasList extends StatelessWidget {
  final AsistenciaService _asistenciaService = new AsistenciaService();

  @override
  Widget build(BuildContext context) {
    Miembro miembro = Provider.of<MiembroState>(context, listen: false).miembro;
    return StreamBuilder<List<Asistencia>>(
      stream: _asistenciaService.listByIdMiembro(miembro.idMiembro),
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
