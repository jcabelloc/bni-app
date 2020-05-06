import 'package:cloud_firestore/cloud_firestore.dart';

class Sesion {
  String idSesion;
  String lugar;
  String direccion;
  DateTime fechaHora;
  String idGrupo;
  GeoPoint ubicacion;

  static const String collectionId = 'sesiones';

  Sesion.fromSnapshot(DocumentSnapshot snapshot)
      : idSesion = snapshot.documentID,
        lugar = snapshot['lugar'],
        direccion = snapshot['direccion'],
        fechaHora = (snapshot['fechaHora'] as Timestamp).toDate(),
        idGrupo = snapshot['idGrupo'],
        ubicacion = snapshot['ubicacion'];

  @override
  String toString() {
    return 'Sesion{idSesion: $idSesion, lugar: $lugar, direccion: $direccion, fechaHora: $fechaHora, idGrupo: $idGrupo, ubicacion: $ubicacion}';
  }
}
