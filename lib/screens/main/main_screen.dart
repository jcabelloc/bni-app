import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:bniapp/models/usuario.dart';
import 'package:bniapp/screens/main/components/inicio_page.dart';
import 'package:bniapp/screens/main/components/referencia_page.dart';
import 'package:bniapp/screens/main/components/referencias_page.dart';
import 'package:bniapp/services/grupo_service.dart';
import 'package:bniapp/services/sesion_service.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appState = AppState.instance;
  final _sesionService = new SesionService();
  final _grupoService = new GrupoService();

  FirebaseUser loggedInUser;
  Usuario usuario;
  Miembro miembro;
  Sesion proximaSesion;
  String avatarGrupoUrl;
  List<Widget> _opcionesWidget = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    loggedInUser = _appState.user;
    usuario = _appState.usuario;
    miembro = _appState.miembro;
    _opcionesWidget = [InicioPage(), ReferenciaPage(), ReferenciasPage()];
    initData();
  }

  void initData() async {
    proximaSesion = await _sesionService.getProximaSesion(miembro.idGrupo);
    avatarGrupoUrl = await _grupoService.getAvatarUrl(miembro.idGrupo);
    setState(() {
      _opcionesWidget = [
        InicioPage(
          miembro: miembro,
          proximaSesion: proximaSesion,
          avatarGrupoUrl: avatarGrupoUrl,
        ),
        ReferenciaPage(
          miembro: miembro,
          proximaSesion: proximaSesion,
        ),
        ReferenciasPage()
      ];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: _opcionesWidget[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Registro'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Buscar'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
