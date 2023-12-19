import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:friendzy/modeles/centre_dinteret_modele.dart';
import 'package:friendzy/modeles/utilisateur_modele.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:path/path.dart" as Path;

class ServicesDauthentifications {
  final authentification = FirebaseAuth.instance;
  final stockage = FirebaseStorage.instance.ref();
  final utilisateurCollection =
      FirebaseFirestore.instance.collection("utilisateur");
  final centreDinteretsCollection =
      FirebaseFirestore.instance.collection("centreDinterets");

  User? get utilisateurActuel => authentification.currentUser;

  Stream<User?> get estConnecter => authentification.authStateChanges();

  Stream<UtilisateurModel> get donneesDeLutilisateur {
    return utilisateurCollection.doc(utilisateurActuel?.uid).snapshots().map(
        (utilisateur) => UtilisateurModel.deJSON(
            utilisateur.data() as Map<String, dynamic>));
  }

  /// enregistre un utilisateur dans la base de donneé
  Future<void> enregistrerUnUtilisateur(UtilisateurModel utilisateur) async {
    try {
      await utilisateurCollection.doc(utilisateur.id).set(utilisateur.aMap());
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  /// Recupere l'utilisateur courant via son id
  Future<UtilisateurModel?> recupererUnUtilisateur(
      {String? idDeLutilisateur}) async {
    try {
      if (idDeLutilisateur == null) {
        idDeLutilisateur = utilisateurActuel?.uid;
      }
      final utilisateur = await utilisateurCollection
          .where("id", isEqualTo: idDeLutilisateur)
          .get();
      if (utilisateur.docs.length < 0) {
        return UtilisateurModel();
      } else {
        return UtilisateurModel.deJSON(utilisateur.docs.first.data());
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<CentreDinteretModel>> tousLesCentresDinterets() async {
    try {
      final centreDinterets = await centreDinteretsCollection.get();
      return centreDinterets.docs
          .map((e) => CentreDinteretModel.deJSON(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      print(e.code);
      return [];
    }
  }

  Future<List<dynamic>?> connexionViaGoogle() async {
    try {
      final GoogleSignInAccount? utilisateur = await GoogleSignIn().signIn();

      if (utilisateur != null) {
        final GoogleSignInAuthentication userAuth =
            await utilisateur.authentication;

        final credentiel = GoogleAuthProvider.credential(
          accessToken: userAuth.accessToken,
          idToken: userAuth.idToken,
        );

        return [credentiel, utilisateur];
      }
    } on FirebaseAuthException catch (e) {
      print("Google auth erro je veux voir $e");
      return null;
    }
    return null;
  }

  /// Mettre a jour les informations de l'utilisateur

  Future<bool?> miseAJourDesInformationsDeMonUtilisateur(
      UtilisateurModel utilisateur) async {
    try {
      await utilisateurCollection
          .doc(utilisateur.id)
          .update(utilisateur.aMap());
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return false;
    }
  }

  Reference cheminDaccessDeMonImage(File image, String lienDeMonImage) {
    final nomDeBaseDeMonImage = Path.basename(image.path);
    return stockage.child(
        "images/user${utilisateurActuel?.uid}/$lienDeMonImage/$nomDeBaseDeMonImage");
  }

  UploadTask telechargerUneTache(Reference reference, File image) {
    return reference.putFile(image);
  }

  Future<String?> telechargerUneImage(File image, String cheminDansFirebase,
      {int? userImagesIndex, String? imageName}) async {
    try {
      final nomDeMonImage = Path.basename(image.path);
      final ref = stockage.child(
          "images/user${utilisateurActuel?.uid}/$cheminDansFirebase/$nomDeMonImage");
      return await _apercuDeLaTache(ref, image);
    } on FirebaseException {
      return "";
    }
  }

  Future<String?> _apercuDeLaTache(Reference reference, File image) async {
    TaskSnapshot telechargement = await reference.putFile(image);

    if (telechargement.state == TaskState.success) {
      return await reference.getDownloadURL();
    } else {
      return "";
    }
  }
}
