import 'package: flutter/material.dart';

void main() {

runApp (MyApp());



}

I



 class MyApp extends StatelessWidget {


const new({super.key});

@override



Widget build (BuildContext context) {


return MaterialApp (title: "MaBiblio", home: HomePage());

}

}





 class HomePage extends StatefulWidget {



const new({super.key});



@override

 State<HomePage> createState() => HomePageState();



}



 class HomePageState extends State<HomePage> {





@override

Widget build(BuildContext context) {

return Scaffold(

appBar: AppBar (

)

, // AppBar

); // Scaffold
 }
 }
 