import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/feature/home/view/widgets/recent_rides.dart';
import 'package:uber/core/elements/size_extensions.dart';
import 'package:uber/feature/account/view/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName =
        FirebaseAuth.instance.currentUser?.displayName?.split(" ").first;

    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 20.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome Back,\n${displayName ?? "User"}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                      if (context.mounted) {
                        setState(() {});
                      }
                    },
                    icon:
                        user != null && user.photoURL != null
                            ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.photoURL.toString(),
                              ),
                              radius: 25,
                            )
                            : Image.asset(
                              "assets/profile.png",
                              fit: BoxFit.cover,
                              height: 40.rh,
                            ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 47.rh),
            Text(
              "  Recent rides",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("rides").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: black),
                    );
                  }
                  print(snapshot);
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data found'));
                  }
                  final rides = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: rides.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(rides[index]);
                      return RecentRides(rides: rides[index]);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 45.rh),
          ],
        ),
      ),
    );
  }
}
