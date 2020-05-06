import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String uid;
  String nombres;
  String apellidos;
  String email;
  String idMiembro;
  bool esAdmin;
  String avatarUrl;

  static const String collectionId = 'usuarios';

  Usuario.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.documentID,
        nombres = snapshot['nombres'],
        apellidos = snapshot['apellidos'],
        email = snapshot['email'],
        idMiembro = snapshot['idMiembro'],
        esAdmin = snapshot['esAdmin'],
        avatarUrl = snapshot['avatarUrl'];

  Map<String, dynamic> toMap() => {
        'nombres': nombres,
        'apellidos': apellidos,
        'email': email,
        'idMiembro': idMiembro,
        'esAdmin': esAdmin,
        'avatarUrl': avatarUrl
      };
}
