import 'package:flutter/material.dart';

class DogFoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> addvertisments;
  const DogFoodDetailPage({Key? key, required this.addvertisments}) : super(key: key);

  @override
  State<DogFoodDetailPage> createState() => _DogFoodDetailPageState();
}

class _DogFoodDetailPageState extends State<DogFoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('ADVERTISMENTS DETAILS'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              child: Image.network(widget.addvertisments['imgUrl']),
            ),
          ),
          SizedBox(height: 28),
          Text("Name: ${widget.addvertisments['addName']}", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 25),
          Text("Number: ${widget.addvertisments['addNumber']}", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 35),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("${widget.addvertisments['addDescription']}", textAlign: TextAlign.justify, style: TextStyle(
              fontSize: 20,

            ),),
          ),
          SizedBox(height: 25),
          Text("Location: ${widget.addvertisments['addLocation']}", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),

          SizedBox(height: 25),
          Text("Price: ${widget.addvertisments['addPrice']}", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ],
      ),

    );
  }
}
