import 'package:bniapp/screens/update_miembro/update_miembro_screen.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiembroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MiembroState>(
      builder: (context, miembroState, child) {
        return GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, UpdateMiembroScreen.id);
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
                      backgroundImage: miembroState.miembro?.avatarUrl != null
                          ? NetworkImage(miembroState.miembro?.avatarUrl ?? '')
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
                        (miembroState.miembro?.nombres ?? '') +
                            ' ' +
                            (miembroState.miembro?.apellidos ?? ''),
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
                            miembroState.miembro?.nombreGrupo ?? '',
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
                            miembroState.miembro?.email ?? '',
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
      },
    );
  }
}
