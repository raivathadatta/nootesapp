import 'package:flutter/material.dart';
import 'package:googlesineintry/thems.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0.0,
          title: const Text("Settings")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Sync",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.3,
                  child: Switch.adaptive(
                      value: value,
                      onChanged: (switchValue) {
                        setState(() {
                          value = switchValue;
                        });
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
