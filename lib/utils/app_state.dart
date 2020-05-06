import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/usuario.dart';
import 'package:bniapp/services/auth_service.dart';
import 'package:bniapp/services/miembro_service.dart';
import 'package:bniapp/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  FirebaseUser user;
  Usuario usuario;
  Miembro miembro;

  static final AppState _instance = AppState._privateConstructor();

  static AppState get instance => _instance;

  AppState._privateConstructor();

  Future<void> initAppState() async {
    final _authService = AuthService();
    final _usuarioService = UsuarioService();
    final _miembroService = MiembroService();
    user = await _authService.getCurrentUser();
    usuario = await _usuarioService.getById(user.uid);
    miembro = await _miembroService.getById(usuario.idMiembro);
  }
}
