import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            //primaryColor: Colors.blue,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: StreamBuilder(
          //here look for authState to know what the state to go screen
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if(snapShot.connectionState == ConnectionState.waiting){
              return SplashScreen();
            }
            if (snapShot.hasData) {
              return ChatScreen();
            } else {
              return AuthScreen();
            }
          },
        )

        //AuthScreen(),
        );
  }
}
