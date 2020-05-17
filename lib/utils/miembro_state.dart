import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/usuario.dart';
import 'package:bniapp/services/auth_service.dart';
import 'package:bniapp/services/miembro_service.dart';
import 'package:bniapp/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MiembroState extends ChangeNotifier {
  Miembro _miembro;
  final _authService = AuthService();
  final _usuarioService = UsuarioService();
  final _miembroService = MiembroService();

  Miembro get miembro => _miembro;

  Future<void> loadMiembro() async {
    FirebaseUser _user = await _authService.getCurrentUser();
    Usuario _usuario = await _usuarioService.getById(_user.uid);
    _miembro = await _miembroService.getById(_usuario.idMiembro);
    notifyListeners();
  }

  updateMiembro(Miembro miembro) {
    _miembro = miembro;
    notifyListeners();
  }
}
