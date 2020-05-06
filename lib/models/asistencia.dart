import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Asistencia {
  String idAsistencia;
  String idSesion;
  String idMiembro;
  DateTime fechaHora;
  bool asistio;
  String nombreCompletoMiembro;
  String lugarSesion;
  Referencia referencia;

  static const String collectionId = 'asistencias';

  Asistencia.fromSesionAndMiembro(Sesion sesion, Miembro miembro)
      : idAsistencia = sesion.idSesion + '_' + miembro.idMiembro,
        idSesion = sesion.idSesion,
        idMiembro = miembro.idMiembro,
        fechaHora = sesion.fechaHora,
        asistio = false,
        nombreCompletoMiembro = miembro.nombres + ' ' + miembro.apellidos,
        lugarSesion = sesion.lugar,
        referencia = Referencia();

  Asistencia.fromSnapshot(DocumentSnapshot snapshot)
      : idAsistencia = snapshot.documentID,
        idSesion = snapshot['idSesion'],
        idMiembro = snapshot['idMiembro'],
        fechaHora = (snapshot['fechaHora'] as Timestamp).toDate(),
        asistio = snapshot['asistio'],
        nombreCompletoMiembro = snapshot['nombreCompletoMiembro'],
        lugarSesion = snapshot['lugarSesion'],
        referencia = Referencia(
            empresa: snapshot['referencia']['empresa'],
            cargo: snapshot['referencia']['cargo'],
            nombre: snapshot['referencia']['nombre']);

  Map<String, dynamic> toMap() => {
        'idSesion': idSesion,
        'idMiembro': idMiembro,
        'fechaHora': Timestamp.fromDate(fechaHora),
        'asistio': asistio,
        'nombreCompletoMiembro': nombreCompletoMiembro,
        'lugarSesion': lugarSesion,
        'referencia': referencia.toMap(),
      };

  @override
  String toString() {
    return 'Asistencia{idAsistencia: $idAsistencia, idSesion: $idSesion, idMiembro: $idMiembro, fechaHora: $fechaHora, asistio: $asistio, nombreCompletoMiembro: $nombreCompletoMiembro, lugarSesion: $lugarSesion, referencia: $referencia}';
  }
}

class Referencia {
  String empresa;
  String cargo;
  String nombre;

  Referencia({this.empresa, this.cargo, this.nombre});

  Map<String, dynamic> toMap() =>
      {'cargo': cargo, 'empresa': empresa, 'nombre': nombre};

  @override
  String toString() {
    return 'Referencia{empresa: $empresa, cargo: $cargo, nombre: $nombre}';
  }
}
