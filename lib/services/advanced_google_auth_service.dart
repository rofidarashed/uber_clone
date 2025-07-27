import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AdvancedGoogleAuthService {
  static GoogleSignIn? _googleSignIn;
  static bool _isInitialized = false;
  static StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;
  
  // Stream controller to notify about authentication state changes
  static final StreamController<GoogleSignInAccount?> _authStateController = 
      StreamController<GoogleSignInAccount?>.broadcast();
  
  // Public stream to listen to authentication state changes
  static Stream<GoogleSignInAccount?> get authStateChanges => 
      _authStateController.stream;

  // Initialize GoogleSignIn instance with authentication event handling
  static Future<void> initialize({
    String? clientId,
    String? serverClientId,
  }) async {
    if (_isInitialized) return;
    
    _googleSignIn = GoogleSignIn.instance;
    
    // Initialize the GoogleSignIn instance
    await _googleSignIn!.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );

    // Listen to authentication events
    _authSubscription = _googleSignIn!.authenticationEvents
        .listen(_handleAuthenticationEvent)
        .onError(_handleAuthenticationError);

    // Attempt lightweight authentication (silent sign-in)
    unawaited(_googleSignIn!.attemptLightweightAuthentication());
    
    _isInitialized = true;
  }

  // Handle authentication events from the stream
  static Future<void> _handleAuthenticationEvent(
      GoogleSignInAuthenticationEvent event) async {
    GoogleSignInAccount? user;
    
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        user = event.user;
        print('User signed in: ${user.displayName}');
        break;
      case GoogleSignInAuthenticationEventSignOut():
        user = null;
        print('User signed out');
        break;
    }

    // Notify listeners about the authentication state change
    _authStateController.add(user);

    // If user signed in, also sign in to Firebase
    if (user != null) {
      await _signInToFirebase(user);
    } else {
      await FirebaseAuth.instance.signOut();
    }
  }

  // Handle authentication errors
  static Future<void> _handleAuthenticationError(Object error) async {
    print('Authentication error: $error');
    _authStateController.add(null);
  }

  // Sign in to Firebase using Google credentials
  static Future<UserCredential?> _signInToFirebase(GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Firebase sign-in error: $e');
      return null;
    }
  }

  // Explicit sign-in method
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Ensure GoogleSignIn is initialized
      if (!_isInitialized || _googleSignIn == null) {
        await initialize();
      }

      GoogleSignInAccount? googleUser;
      
      if (_googleSignIn!.supportsAuthenticate()) {
        // Use the new authenticate method for supported platforms
        googleUser = await _googleSignIn!.authenticate();
      } else {
        // Fallback to the old signIn method for unsupported platforms
        googleUser = await _googleSignIn!.signIn();
      }

      if (googleUser == null) return null;

      // Firebase sign-in will be handled by the authentication event stream
      // But we can also return the Firebase credential immediately
      return await _signInToFirebase(googleUser);
      
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
      // Firebase sign-out will be handled by the authentication event stream
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  // Disconnect method (removes all permissions)
  static Future<void> disconnect() async {
    try {
      await _googleSignIn?.disconnect();
      // Firebase sign-out will be handled by the authentication event stream
    } catch (e) {
      print("Disconnect error: $e");
    }
  }

  // Check if user is currently signed in
  static GoogleSignInAccount? get currentUser => _googleSignIn?.currentUser;

  // Check if GoogleSignIn is initialized
  static bool get isInitialized => _isInitialized;

  // Dispose resources
  static Future<void> dispose() async {
    await _authSubscription?.cancel();
    await _authStateController.close();
    _isInitialized = false;
  }
}