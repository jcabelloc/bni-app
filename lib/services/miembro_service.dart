import 'dart:io';

import 'package:bniapp/models/miembro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MiembroService {
  final CollectionReference miembrosRef =
      Firestore.instance.collection(Miembro.collectionId);

  final StorageReference miembrosAvatarReference =
      FirebaseStorage().ref().child('avatar_miembros');

  Future<Miembro> getById(String idMiembro) async {
    return Miembro.fromSnapshot(await miembrosRef.document(idMiembro).get());
  }

  Future<void> save(Miembro miembro) async {
    DocumentReference miembroRef = miembrosRef.document(miembro.idMiembro);
    miembrosRef.firestore.runTransaction(
        (tx) async => await tx.set(miembroRef, miembro.toMap()));
  }

  Future<StorageTaskSnapshot> uploadAvatar(String idMiembro, File file) async {
    StorageReference ref = miembrosAvatarReference.child(idMiembro);
    final StorageUploadTask uploadTask = ref.putFile(file);
    return uploadTask.onComplete;
  }

  Future<dynamic> getAvatarUrl(String idMiembro) async {
    StorageReference ref = miembrosAvatarReference.child(idMiembro);
    return ref.getDownloadURL();
  }
}
