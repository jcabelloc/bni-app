import 'package:bniapp/components/miembro_card.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:bniapp/utils/constants.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatelessWidget {
  final Sesion proximaSesion;
  final String avatarGrupoUrl;

  InicioPage({this.proximaSesion, this.avatarGrupoUrl});

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
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: 200,
                  height: 190,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    backgroundImage: avatarGrupoUrl != null
                        ? NetworkImage(avatarGrupoUrl)
                        : AssetImage('images/default-avatar-group.jpg'),
                  ),
                ),
                Text(
                  Provider.of<MiembroState>(context, listen: false)
                      .miembro
                      .nombreGrupo,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  padding: EdgeInsets.only(left: 32.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Próxima Sesión",
                    style: TextStyle(
                        color: kPrimaryColorDark, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(proximaSesion?.fechaHora == null
                                    ? ' '
                                    : DateFormat("dd 'de' MMM", 'es')
                                        .format(proximaSesion?.fechaHora)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    proximaSesion?.fechaHora == null
                                        ? ' '
                                        : DateFormat("HH':'mm", 'es')
                                            .format(proximaSesion?.fechaHora),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30.0,
                                child: VerticalDivider(
                                  color: kPrimaryColorDark,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(proximaSesion?.direccion ?? ''),
                                      Text(proximaSesion?.lugar ?? '')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
