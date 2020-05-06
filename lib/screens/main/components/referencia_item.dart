import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReferenciaItem extends StatelessWidget {
  final String nombre;
  final String cargo;
  final String empresa;
  final DateTime fechaHora;
  final Function onTap;

  ReferenciaItem(
      {this.nombre, this.cargo, this.empresa, this.fechaHora, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nombre,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  cargo + ' en ' + empresa,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Expanded(
              child: Text(
                DateFormat("dd 'de' MMM", 'es').format(fechaHora),
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
