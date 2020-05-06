import 'package:bniapp/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioService {
  CollectionReference usuariosRef =
      Firestore.instance.collection(Usuario.collectionId);

  Future<Usuario> getById(String uid) async {
    return Usuario.fromSnapshot(await usuariosRef.document(uid).get());
  }

  Future<void> save(Usuario usuario) async {
    DocumentReference usuarioRef = usuariosRef.document(usuario.uid);
    usuariosRef.firestore.runTransaction(
        (tx) async => await tx.set(usuarioRef, usuario.toMap()));
  }
}
