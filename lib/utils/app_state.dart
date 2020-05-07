import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/usuario.dart';
import 'package:bniapp/services/auth_service.dart';
import 'package:bniapp/services/miembro_service.dart';
import 'package:bniapp/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  FirebaseUser _user;
  Usuario _usuario;
  Miembro _miembro;

  static final AppState _instance = AppState._privateConstructor();

  static AppState get instance => _instance;

  AppState._privateConstructor();

  Future<void> loadAppState() async {
    final _authService = AuthService();
    final _usuarioService = UsuarioService();
    final _miembroService = MiembroService();
    _user = await _authService.getCurrentUser();
    _usuario = await _usuarioService.getById(user.uid);
    _miembro = await _miembroService.getById(usuario.idMiembro);
  }

  FirebaseUser get user => _user;
  Usuario get usuario => _usuario;
  Miembro get miembro => _miembro;
}
