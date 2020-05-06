import 'package:bniapp/models/sesion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SesionService {
  final _firestore = Firestore.instance;

  Future<Sesion> getProximaSesion(String idGrupo) async {
    DocumentSnapshot doc = (await _firestore
            .collection(Sesion.collectionId)
            .where('idGrupo', isEqualTo: idGrupo)
            .where('fechaHora',
                isGreaterThan: Timestamp.fromDate(DateTime.now()))
            .orderBy('fechaHora')
            .limit(1)
            .getDocuments())
        .documents
        .first;

    return doc != null ? Sesion.fromSnapshot(doc) : null;
  }
}
