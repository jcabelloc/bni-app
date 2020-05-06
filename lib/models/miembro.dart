import 'package:cloud_firestore/cloud_firestore.dart';

class Miembro {
  String idMiembro;
  String nombres;
  String apellidos;
  String telefono;
  String nombreEmpresa;
  String profesion;
  String email;
  String idGrupo;
  String nombreGrupo;
  String avatarUrl;
  bool esLider;

  static const String collectionId = 'miembros';

  Miembro(
      {this.nombres,
      this.apellidos,
      this.telefono,
      this.nombreEmpresa,
      this.profesion,
      this.email,
      this.idGrupo,
      this.nombreGrupo,
      this.avatarUrl,
      this.esLider});

  Miembro.fromSnapshot(DocumentSnapshot snapshot)
      : idMiembro = snapshot.documentID,
        nombres = snapshot['nombres'],
        apellidos = snapshot['apellidos'],
        telefono = snapshot['telefono'],
        nombreEmpresa = snapshot['nombreEmpresa'],
        profesion = snapshot['profesion'],
        email = snapshot['email'],
        idGrupo = snapshot['idGrupo'],
        nombreGrupo = snapshot['nombreGrupo'],
        avatarUrl = snapshot['avatarUrl'],
        esLider = snapshot['esLider'];

  Map<String, dynamic> toMap() => {
        'nombres': nombres,
        'apellidos': apellidos,
        'telefono': telefono,
        'nombreEmpresa': nombreEmpresa,
        'profesion': profesion,
        'email': email,
        'idGrupo': idGrupo,
        'nombreGrupo': nombreGrupo,
        'avatarUrl': avatarUrl,
        'esLider': esLider,
      };

  @override
  String toString() {
    return 'Miembro{idMiembro: $idMiembro, nombres: $nombres, apellidos: $apellidos, telefono: $telefono, nombreEmpresa: $nombreEmpresa, profesion: $profesion, email: $email, idGrupo: $idGrupo, nombreGrupo: $nombreGrupo, avatarUrl: $avatarUrl, esLider: $esLider}';
  }
}
