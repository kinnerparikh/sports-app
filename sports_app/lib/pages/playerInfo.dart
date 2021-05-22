import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_app/objects/Statistic.dart';
import 'package:sports_app/objects/player.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/objects/playerInformation.dart';
import 'package:sports_app/pages/PlayerStats.dart';

class PlayerInfo extends StatelessWidget {
  Player player;
  PlayerInfo(Player player)
  {
    this.player = player;
  }

  List<Statistic> statistics = new List<Statistic>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _fetchPlayerInformation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          return _playerInformationView(data, context);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return _playerInformationView(0, 0);
      },
    );
  }

  Future<dynamic> _fetchPlayerInformation() async {

    final listAPIUrl = player.apiUrl.replaceAll("+esport", "");
    final response = await http.get(Uri.parse(listAPIUrl));
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);

      String position = jsonResponse['knowledge_graph']['type'];
      String description = jsonResponse['knowledge_graph']['description'];
     // String team = jsonResponse['knowledge_graph']['current_team'];
      String height = jsonResponse['knowledge_graph']['height'];


      NetworkImage image = NetworkImage(jsonResponse['knowledge_graph']['header_images'][0]['image']);
      return PlayerInformation(position, player.name, description, height, image);

    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Scaffold _playerInformationView(data, context) {
    if (context == 0)
    {
      return Scaffold(
        appBar: AppBar(title: Text('')),
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          )
        )
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(data.name.toString())),
      body:
          SafeArea(
            child:
        Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red, Colors.redAccent]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 337.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: data.image,
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        data.position.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                       GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayerStats(player)),
                            );
                          },
                          child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width:70),
                              GestureDetector(
                                child: Icon(Icons.trending_up, size: 50, color: Colors.redAccent),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayerStats(player)),
                                  );
                                },
                              ),

                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Height",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      data.height.toString(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(data.description.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              )
            ),
        ],
      ),
    ));
  }

  ListView getStats(data)
  {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Expanded(
            child: Column(

              children: <Widget>[
                Text(
                  data[index].name,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  data[index].statistic.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                  ),
                )
              ],
            ),
          ) ;

        });
  }

}

