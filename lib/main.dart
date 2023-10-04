import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}


Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
   }
 }



  class Album {
    final int userid;
    final int id;
    final String title;


    Album({
      required this.userid,
      required this.id,
      required this.title,
    });

    factory Album.fromJson(Map<String, dynamic> json) {
      return Album(
          userid:  json['userid'],
          id: json['id'],
          title: json['title'],);
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
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.done) {
                 if (snapshot.hasData) {
                   return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                   Text(snapshot.data!.userid.toString()),
                   Text(snapshot.data!.id.toString()),
                   Text(snapshot.data!.title),
               ],
               );

               } else if (snapshot.hasError){
               return Text('${snapshot.error}');
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












