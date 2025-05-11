import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/services/sp_service.dart';
import 'package:uber/elements/widgets/edit_profile_info.dart';
import 'package:uber/elements/widgets/size_extensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentName = "User";
  bool edit = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentName = SpService.i.prefs?.getString("displayName") ?? "User";
    });
  }

  void updateName(String newName) {
    setState(() {
      currentName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 55.rh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, size: 30, color: black),
                ),
                Text(
                  "\tProfile",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 25.rh),
            user != null
                ? CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL.toString()),
                  radius: 40,
                )
                : Image.asset(
                  "assets/profile.png",
                  fit: BoxFit.cover,
                  height: 80.rh,
                ),
            SizedBox(height: 18.rh),
            Text(currentName, style: TextStyle(fontSize: 30)),
            Text(user!.email.toString(), style: TextStyle(fontSize: 17)),
            EditProfileInfo(updateName: updateName, currentName: currentName),
          ],
        ),
      ),
    );
  }
}
