import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  String idGrupo;
  String nombre;
  String diaSesion;
  GeoPoint ubicacionSesion;
  String direccionSesion;
  String lugarSesion;
  String horaSesion;
  int ultimaGeneracion;
  String avatarUrl;

  static const String collectionId = 'grupos';

  Grupo.fromSnapshot(DocumentSnapshot snapshot)
      : idGrupo = snapshot.documentID,
        nombre = snapshot['nombre'],
        diaSesion = snapshot['diaSesion'],
        ubicacionSesion = snapshot['ubicacionSesion'],
        direccionSesion = snapshot['direccionSesion'],
        lugarSesion = snapshot['lugarSesion'],
        horaSesion = snapshot['horaSesion'],
        ultimaGeneracion = snapshot['ultimaGeneracion'],
        avatarUrl = snapshot['avatarUrl'];

  Map<String, dynamic> toMap() => {
        'nombre': nombre,
        'diaSesion': diaSesion,
        'ubicacionSesion': ubicacionSesion,
        'direccionSesion': direccionSesion,
        'lugarSesion': lugarSesion,
        'horaSesion': horaSesion,
        'ultimaGeneracion': ultimaGeneracion,
        'avatarUrl': avatarUrl,
      };

  @override
  String toString() {
    return 'Miembro{idMiembro: $idGrupo, nombre: $nombre, diaSesion: $diaSesion, ubicacionSesion: $ubicacionSesion, direccionSesion: $direccionSesion, '
        'lugarSesion: $lugarSesion, horaSesion: $horaSesion, ultimaGeneracion: $ultimaGeneracion, avatarUrl: $avatarUrl}';
  }
}
