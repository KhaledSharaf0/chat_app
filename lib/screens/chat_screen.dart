import 'package:chat_app/widgets/chat/message.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {

 //
 // @override
 //  void initState() {
 //    super.initState();
 //    // final fbm = FirebaseMessaging();
 //    // fbm.requestNotificationPermissions();
 //    // fbm.c
 //   // final fbm = FirebaseMessaging.instance;
 //   // fbm.requestPermission();
 //   // fbm.pluginConstants
 //    final FirebaseMessaging messaging = FirebaseMessaging.instance;
 //    messaging.requestPermission();
 //    messaging.requestPermission(sound: true, badge: true, alert: true, provisional: false);
 //    // messaging.configure(
 //    //   onMessage: (msg)  {
 //    //     print("onMessage");
 //    //     return;
 //    //   },
 //    //   onLaunch: (msg)  {
 //    //     print("onLaunch");
 //    //     return;
 //    //   },
 //    //   onResume: (msg)  {
 //    //     print("onResume");
 //    //     return;
 //    //   },
 //    // );
 //
 //
 //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert ,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app ,
                      size: 25,
                      color: Colors.black,),
                      SizedBox(width: 8,),
                      Text("Logout")
                    ],
                  ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body:Container(
        child: Column(
          children: [
            Expanded(child: Message()
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
