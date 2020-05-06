import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/screens/update_miembro/update_miembro_screen.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:flutter/material.dart';

class MiembroCard extends StatefulWidget {
  @override
  _MiembroCardState createState() => _MiembroCardState();
}

class _MiembroCardState extends State<MiembroCard> {
  AppState _appState = AppState.instance;
  Miembro miembro;

  @override
  void initState() {
    miembro = _appState.miembro;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result = await Navigator.pushNamed(context, UpdateMiembroScreen.id);
        if (result != null) setState(() => miembro = _appState.miembro);
      },
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  backgroundImage: miembro?.avatarUrl != null
                      ? NetworkImage(miembro?.avatarUrl ?? '')
                      : AssetImage('images/avatar-placeholder.gif'),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    (miembro?.nombres ?? '') + ' ' + (miembro?.apellidos ?? ''),
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        size: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        miembro?.nombreGrupo ?? '',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        miembro?.email ?? '',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
