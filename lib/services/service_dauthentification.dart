import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzy/modeles/utilisateur_model.dart';

class ServicesDauthentifications {
  final authentification = FirebaseAuth.instance;
  final utilisateurCollection =
      FirebaseFirestore.instance.collection("utilisateur");
  User? get utilisateurActuel => authentification.currentUser;

  Stream<User?> get estConnecter => authentification.authStateChanges();

  Stream<UtilisateurModel> get donneesDeLutilisateur {
    return utilisateurCollection.doc(utilisateurActuel?.uid).snapshots().map(
        (utilisateur) => UtilisateurModel.deJSON(
            utilisateur.data() as Map<String, dynamic>));
  }
}
