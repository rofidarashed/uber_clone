import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/utils/colors/colors.dart';
import 'package:uber/core/widgets/black_button.dart';
import 'package:uber/core/widgets/input_text_button.dart';
import 'package:uber/core/services/sp_service.dart';
import 'package:uber/core/elements/size_extensions.dart';

class EditProfileInfo extends StatefulWidget {
  final Function updateName;
  final String currentName;
  const EditProfileInfo({
    super.key,
    required this.updateName,
    required this.currentName,
  });
  @override
  _EditProfileInfoState createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  late TextEditingController _nameController;
  bool edit = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateName() async {
    String newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        await user!.updateDisplayName(newName);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        await SpService.i.prefs?.setString("displayName", newName);
        widget.updateName(newName);
        setState(() {
          edit = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update name: ${e.toString()}'),
            duration: Durations.medium4,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!edit)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 25.rh),
            child: BlackButton(
              onPressed: () {
                setState(() {
                  edit = true;
                });
              },
              label: "edit",
            ),
          ),
        if (edit)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.rw,
                  vertical: 30.rh,
                ),
                child: Column(
                  children: [
                    InputTextButton(
                      labelText: 'Name',
                      hintText: 'Name',
                      obscureText: false,
                      controller: _nameController,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _updateName,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("save", style: TextStyle(color: white)),
                        ),
                        TextButton(
                          onPressed: () => setState(() => edit = false),
                          child: Text("Cancel", style: TextStyle(color: black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
