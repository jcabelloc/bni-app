import 'package:bniapp/models/asistencia.dart';
import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/screens/main/components/referencia_item.dart';
import 'package:bniapp/screens/view-referencia/view_referencia_screen.dart';
import 'package:bniapp/services/asistencia_service.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenciasSearchPage extends SearchDelegate {
  AsistenciaService _asistenciaService = new AsistenciaService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
            final asistenciasSugeridas = query.isEmpty
                ? asistencias
                : asistencias
                    .where((e) =>
                        e.referencia.nombre
                            .toString()
                            .toUpperCase()
                            .contains(query.toUpperCase()) ||
                        e.referencia.empresa
                            .toString()
                            .toUpperCase()
                            .contains(query.toUpperCase()) ||
                        e.referencia.cargo
                            .toString()
                            .toUpperCase()
                            .contains(query.toUpperCase()))
                    .toList();
            return ListView.separated(
              itemCount: asistenciasSugeridas.length,
              itemBuilder: (BuildContext context, int index) {
                return ReferenciaItem(
                  onTap: () {
                    Navigator.pushNamed(context, ViewReferenciaScreen.id,
                        arguments: ViewReferenciaScreenArguments(
                            asistencia: asistenciasSugeridas[index]));
                  },
                  nombre: asistenciasSugeridas[index].referencia.nombre,
                  cargo: asistenciasSugeridas[index].referencia.cargo,
                  empresa: asistenciasSugeridas[index].referencia.empresa,
                  fechaHora: asistenciasSugeridas[index].fechaHora,
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
        }
      },
    );
  }
}
