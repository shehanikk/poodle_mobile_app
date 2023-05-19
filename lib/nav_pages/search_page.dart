import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poodle_mobie_application/search_subpages/dog_foods.dart';
import 'package:poodle_mobie_application/search_subpages/dog_transport.dart';
import 'package:poodle_mobie_application/search_subpages/pet_dogs.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF0B1B4B),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('BROWSE TAGS'),
      ),

        body: Center(
          child: Column(
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Petdogs()));
                  },
                        child: Ink.image(
                            width: 350,
                            height: 200,
                          image: AssetImage(
                              "assets/petDog_buton.png"
                          ),
                ),
              ),
              ),
              SizedBox(height: 25,),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dogtrans()));
                  },
                  child: Ink.image(
                    width: 350,
                    height: 200,
                    image: AssetImage(
                        "assets/trans_dog.png"
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dogfoods()));

                  },
                  child: Ink.image(
                    width: 350,
                    height: 200,
                    image: AssetImage(
                        "assets/fod_dog.png"
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

    );
  }
}
