import 'package:bniapp/screens/main/components/referencias_list.dart';
import 'package:bniapp/screens/main/components/referencias_search_page.dart';
import 'package:flutter/material.dart';

class ReferenciasPage extends StatefulWidget {
  @override
  _ReferenciasPageState createState() => _ReferenciasPageState();
}

class _ReferenciasPageState extends State<ReferenciasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Busqueda de Referencias'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ReferenciasSearchPage());
            },
          ),
        ],
      ),
      body: ReferenciasList(),
    );
  }
}
