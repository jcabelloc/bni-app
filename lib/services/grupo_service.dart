import 'package:bniapp/models/grupo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GrupoService {
  final CollectionReference gruposRef =
      Firestore.instance.collection(Grupo.collectionId);

  final StorageReference gruposAvatarReference =
      FirebaseStorage().ref().child('avatar_grupos');

  Future<dynamic> getAvatarUrl(String idGrupo) async {
    StorageReference ref = gruposAvatarReference.child(idGrupo);
    return ref.getDownloadURL();
  }
}
