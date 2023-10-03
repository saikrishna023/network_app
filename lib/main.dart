import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}


Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/3/posts'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
   }
 }



  class Album {
    final String name;
    final String userid;
    final String email;


    Album({
      required this.name,
      required this.userid,
      required this.email,
    });

    factory Album.fromJson(Map<String, dynamic> json) {
      return Album(
          name:  json['name'],
          userid: json['userid'],
          email: json['email'],);
    }
 }

 class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
 }
 class _MyAppState extends State<MyApp> {

   late Future<Album> futureAlbum;


   @override
   void initState() {
     super.initState();
     futureAlbum = fetchAlbum();
   }

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: Scaffold(
         appBar: AppBar(
           title: Text('Update Data'),
         ),

         body: Center(
           child: FutureBuilder<Album>(
             future: futureAlbum,
             builder: (context, snapahot) {
               if (snapahot.connectionState == ConnectionState.done) {
                 if (snapahot.hasData) {
                   return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                   Text(snapahot.data! .name),
               Text(snapahot.data! .userid),
               Text(snapahot.data! .email),
               ],
               );

               } else if (snapahot.hasError){
               return Text('${snapahot.error}');
               }
             }
               return CircularProgressIndicator();

             },
           ),


         ),
       ),


     );
   }
 }












