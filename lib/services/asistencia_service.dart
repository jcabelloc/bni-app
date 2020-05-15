import 'dart:async';

import 'package:bniapp/models/asistencia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AsistenciaService {
  CollectionReference asistenciasRef =
      Firestore.instance.collection(Asistencia.collectionId);

  Future<Asistencia> getById(String idSesion, String idMiembro) async {
    DocumentSnapshot doc =
        await asistenciasRef.document('${idSesion}_$idMiembro').get();
    return (doc.data != null) ? Asistencia.fromSnapshot(doc) : null;
  }

  Future<void> save(Asistencia asistencia) async {
    DocumentReference ref = asistenciasRef.document(asistencia.idAsistencia);
    asistenciasRef.firestore.runTransaction((Transaction tx) async {
      await tx.set(ref, asistencia.toMap());
    });
  }

  Stream<List<Asistencia>> listByIdMiembro(String idMiembro) {
    return asistenciasRef
        .where('idMiembro', isEqualTo: idMiembro)
        .orderBy('fechaHora', descending: true)
        .snapshots()
        .map((e) =>
            e.documents.map((ds) => Asistencia.fromSnapshot(ds)).toList());
  }
}
