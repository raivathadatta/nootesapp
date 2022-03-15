import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googlesineintry/screens/home_screen.dart';
import 'package:googlesineintry/screens/login_scree.dart';

// import 'package:googlesineintry/screens/loginscree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage(); //try weith sharedpreference

  Future<bool> checkUser() async {
    String? validate = await storage.read(key: 'uid');
    if (validate == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: checkUser(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return const LoginIn();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const DisplatScreen();
            }
          },
        ));
  }
}

///loginpage


////displayscreen
///

