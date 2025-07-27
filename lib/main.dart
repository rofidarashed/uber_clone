import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/google_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Google Sign-In
  // Replace these with your actual client IDs from Google Cloud Console
  await GoogleAuthService.initialize(
    clientId: 'your-client-id.googleusercontent.com', // Optional: for iOS/Android
    serverClientId: 'your-server-client-id.googleusercontent.com', // Optional: for server auth
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign In Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = 'Not signed in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign In with Google'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('Sign Out'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _disconnect,
              child: Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      final userCredential = await GoogleAuthService.signInWithGoogle();
      if (userCredential != null) {
        setState(() {
          _status = 'Signed in: ${userCredential.user?.displayName ?? 'Unknown'}';
        });
      } else {
        setState(() {
          _status = 'Sign in cancelled';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Sign in failed: $e';
      });
    }
  }

  Future<void> _signOut() async {
    await GoogleAuthService.signOut();
    setState(() {
      _status = 'Signed out';
    });
  }

  Future<void> _disconnect() async {
    await GoogleAuthService.disconnect();
    setState(() {
      _status = 'Disconnected';
    });
  }
}

