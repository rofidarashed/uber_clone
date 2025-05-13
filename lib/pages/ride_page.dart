import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/buttons/black_button.dart';
import 'package:uber/elements/widgets/available_rides.dart';
import 'package:uber/elements/widgets/size_extensions.dart';
import 'package:uber/elements/widgets/where_to_wigdet.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool isConfirmed = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Drivers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: black));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        }
        final drivers = snapshot.data!.docs;
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.rw, vertical: 29.rh),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    WhereToWigdet(from: from, to: to),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.rh),
                      child: Divider(thickness: 1.3),
                    ),
                    if (!isConfirmed)
                      BlackButton(
                        onPressed: () {
                          if (_formkey.currentState?.validate() ?? false) {
                            setState(() {
                              isConfirmed = true;
                            });
                          }
                        },
                        label: "Confirm",
                      ),

                    if (isConfirmed)
                      Expanded(
                        child: ListView.builder(
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            var driver = drivers[index];

                            return AvailableRides(drivers: driver);
                          },
                        ),
                      ),
                    SizedBox(height: 40.rh),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
