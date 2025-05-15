import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Future<int> getUserBalance() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return 0;

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.data()?['balance'] ?? 0;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> listenToUserBalance() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  static Future<void> updateUserBalance(int updatedBalance) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if ((await FirebaseFirestore.instance.collection("users").doc(uid).get())
        .exists) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        "balance": updatedBalance,
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "balance": updatedBalance,
      });
    }
  }

  static Future<void> createUserIfNotExists({required String email}) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'email': email,
        'balance': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
