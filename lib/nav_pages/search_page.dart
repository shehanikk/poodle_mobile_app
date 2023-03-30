import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../not.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // @override
  // void initState(){
  //   super.initState();
  //   Not.initialize(flutterLocalNotificationsPlugin);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            //Not.showBigTextNotification(title: "New message title", body: "Your long body", fln: flutterLocalNotificationsPlugin);
          }, child: Text("click"),
        ),
      ),
    );
  }
}
