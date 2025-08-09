import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmail(
    String email,
    String password,
    String username,
  ) async {
    try {
      // Check if username is already taken
      final usernameQuery = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.toLowerCase())
          .get();

      if (usernameQuery.docs.isNotEmpty) {
        throw 'Username is already taken';
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Create user document in Firestore
        await _createUserDocument(result.user!, username, email);
      }

      return result;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw 'Google sign-in was cancelled';
      }

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        // Check if user document exists, create if not
        final userDoc = await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .get();

        if (!userDoc.exists) {
          String username = result.user!.displayName
                  ?.toLowerCase()
                  .replaceAll(' ', '_') 
              ?? 'user_${DateTime.now().millisecondsSinceEpoch}';
          
          // Ensure unique username
          username = await _getUniqueUsername(username);
          
          await _createUserDocument(
            result.user!, 
            username, 
            result.user!.email!,
          );
        }
      }

      return result;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw 'Failed to sign out: $e';
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(
    User user, 
    String username, 
    String email,
  ) async {
    final now = DateTime.now();
    
    final userModel = UserModel(
      id: user.uid,
      email: email,
      username: username.toLowerCase(),
      displayName: user.displayName,
      age: 18, // Default age, user will update in profile setup
      gender: Gender.preferNotToSay,
      interestedIn: Gender.preferNotToSay,
      relationshipType: RelationshipType.casual,
      minAge: 18,
      maxAge: 99,
      maxDistance: 50.0,
      lastSeen: now,
      createdAt: now,
      updatedAt: now,
    );

    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toJson());
  }

  // Get unique username
  Future<String> _getUniqueUsername(String baseUsername) async {
    String username = baseUsername;
    int counter = 1;

    while (true) {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (query.docs.isEmpty) {
        return username;
      }

      username = '${baseUsername}_$counter';
      counter++;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      if (currentUser != null) {
        // Delete user document from Firestore
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .delete();

        // Delete authentication account
        await currentUser!.delete();
      }
    } catch (e) {
      throw 'Failed to delete account: $e';
    }
  }

  // Handle authentication exceptions
  String _handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This operation is not allowed.';
        default:
          return e.message ?? 'An authentication error occurred.';
      }
    }
    return e.toString();
  }

  // Get user document from Firestore
  Future<UserModel?> getUserDocument(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw 'Failed to get user document: $e';
    }
  }

  // Update user document
  Future<void> updateUserDocument(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      throw 'Failed to update user document: $e';
    }
  }
}
