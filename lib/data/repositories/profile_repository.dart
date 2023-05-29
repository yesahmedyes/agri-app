import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseAuth _firebaseAuth;

  ProfileRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  updateProfile({String? displayName, String? email}) async {
    if (displayName != null && displayName.isNotEmpty) await _firebaseAuth.currentUser!.updateDisplayName(displayName);
    if (email != null && email.isNotEmpty) await _firebaseAuth.currentUser!.updateEmail(email);
  }

  User? get user {
    return _firebaseAuth.currentUser;
  }
}
