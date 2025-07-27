import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static GoogleSignIn? _googleSignIn;
  static bool _isInitialized = false;

  // Initialize GoogleSignIn instance (call this once in your app)
  static Future<void> initialize({
    String? clientId,
    String? serverClientId,
  }) async {
    if (_isInitialized) return;
    
    _googleSignIn = GoogleSignIn.instance;
    await _googleSignIn!.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );
    _isInitialized = true;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Ensure GoogleSignIn is initialized
      if (!_isInitialized || _googleSignIn == null) {
        await initialize();
      }

      // Check if the platform supports authenticate method
      GoogleSignInAccount? googleUser;
      
      if (_googleSignIn!.supportsAuthenticate()) {
        // Use the new authenticate method for supported platforms
        googleUser = await _googleSignIn!.authenticate();
      } else {
        // Fallback to the old signIn method for unsupported platforms
        googleUser = await _googleSignIn!.signIn();
      }

      if (googleUser == null) return null;

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      return await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e, t) {
      print("Google sign-in error: $e");
      print("Stack trace: $t");
      return null;
    }
  }

  // Sign out method
  static Future<void> signOut() async {
    try {
      await _googleSignIn?.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  // Disconnect method (removes all permissions)
  static Future<void> disconnect() async {
    try {
      await _googleSignIn?.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Disconnect error: $e");
    }
  }

  // Check if user is currently signed in
  static GoogleSignInAccount? get currentUser => _googleSignIn?.currentUser;

  // Check if GoogleSignIn is initialized
  static bool get isInitialized => _isInitialized;
}