# Google Sign-In Migration Guide (7.0+)

## Key Changes in google_sign_in 7.0+

### 1. **Initialization Required**
- You must now call `GoogleSignIn.instance.initialize()` before using any other methods
- This should be done once in your app, typically in `main()`

### 2. **New Authentication Methods**
- `authenticate()` method replaces `signIn()` on supported platforms
- Use `supportsAuthenticate()` to check platform support
- Fallback to `signIn()` for unsupported platforms

### 3. **Stream-Based Authentication Events**
- New `authenticationEvents` stream for listening to sign-in/sign-out events
- `attemptLightweightAuthentication()` for silent sign-in attempts

## Updated Code Structure

### Basic Implementation (`GoogleAuthService`)

```dart
// Initialize once in main()
await GoogleAuthService.initialize(
  clientId: 'your-client-id.googleusercontent.com',
  serverClientId: 'your-server-client-id.googleusercontent.com',
);

// Use in your app
final userCredential = await GoogleAuthService.signInWithGoogle();
```

### Advanced Implementation (`AdvancedGoogleAuthService`)

The advanced service includes:
- Stream-based authentication event handling
- Automatic lightweight authentication attempts
- Real-time authentication state changes
- Better error handling

```dart
// Initialize once in main()
await AdvancedGoogleAuthService.initialize(
  clientId: 'your-client-id.googleusercontent.com',
  serverClientId: 'your-server-client-id.googleusercontent.com',
);

// Listen to authentication state changes
AdvancedGoogleAuthService.authStateChanges.listen((user) {
  if (user != null) {
    print('User signed in: ${user.displayName}');
  } else {
    print('User signed out');
  }
});

// Sign in
final userCredential = await AdvancedGoogleAuthService.signInWithGoogle();
```

## Migration Steps

### 1. Update Dependencies
Ensure you have the latest version of `google_sign_in`:

```yaml
dependencies:
  google_sign_in: ^6.2.1  # or latest version
  firebase_auth: ^4.15.3   # or latest version
```

### 2. Update Your Code
Replace your old `GoogleAuthService` with the updated version provided.

### 3. Initialize in main()
Add initialization to your `main()` function:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Initialize Google Sign-In
  await GoogleAuthService.initialize(
    clientId: 'your-client-id.googleusercontent.com',
    serverClientId: 'your-server-client-id.googleusercontent.com',
  );
  
  runApp(MyApp());
}
```

### 4. Update Configuration Files
Make sure your platform-specific configuration files are properly set up:

#### Android (`android/app/google-services.json`)
- Download from Firebase Console
- Place in `android/app/` directory

#### iOS (`ios/Runner/GoogleService-Info.plist`)
- Download from Firebase Console  
- Add to Xcode project

#### Web
Update `web/index.html` with your Google client ID:

```html
<meta name="google-signin-client_id" content="your-client-id.googleusercontent.com">
```

## Error Handling

The new version includes better error handling with specific exception types:

```dart
try {
  final userCredential = await GoogleAuthService.signInWithGoogle();
  // Handle success
} on GoogleSignInException catch (e) {
  switch (e.code) {
    case GoogleSignInExceptionCode.canceled:
      print('Sign in was canceled');
      break;
    case GoogleSignInExceptionCode.networkError:
      print('Network error occurred');
      break;
    default:
      print('Google Sign-In error: ${e.description}');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## Platform Differences

### Web
- Must use SDK-rendered button on some platforms
- Access tokens expire after 1 hour and need refresh
- Use `kIsWeb` to detect web platform

### Mobile (iOS/Android)
- Supports both `authenticate()` and `signIn()` methods
- Better offline support
- Persistent authentication state

## Best Practices

1. **Initialize Early**: Call `initialize()` in your `main()` function
2. **Handle Platform Differences**: Use `supportsAuthenticate()` to check method availability
3. **Listen to Events**: Use the advanced service for real-time authentication updates
4. **Error Handling**: Implement proper error handling for different scenarios
5. **Cleanup**: Call `dispose()` when your app is closing (for advanced service)

## Testing

Test your implementation on all target platforms:
- Android
- iOS  
- Web

Make sure to test both successful sign-in and error scenarios (network issues, user cancellation, etc.).