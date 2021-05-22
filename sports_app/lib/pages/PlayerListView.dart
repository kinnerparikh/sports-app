import 'dart:async';
import 'dart:convert';
import 'package:sports_app/objects/player.dart';
import 'package:sports_app/objects/team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/pages/playerInfo.dart';
import 'favorites.dart';

class PlayerListView extends StatefulWidget {
  Team team;
  PlayerListView(Team team)
  {
    this.team = team;
  }

  @override
  _PlayerListView createState() => _PlayerListView(team);
}

class _PlayerListView extends State<PlayerListView> {
  Team team;
  _PlayerListView(Team team)
  {
    this.team = team;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
      future: _fetchPlayers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Player> data = snapshot.data;
          return _playersListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return _playersListView(0);
      },
    );
  }

  String description;
  Image image;
  Image displayImage;

  Future<List<Player>> _fetchPlayers() async {

    final listAPIUrl = team.apiUrl.replaceAll("+esport", "");
    final response = await http.get(Uri.parse(listAPIUrl));

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      description= jsonResponse['knowledge_graph']['description'];
      if(jsonResponse['knowledge_graph']['header_images'] != null)
        {
          image = Image.network(jsonResponse['knowledge_graph']['header_images'][0]['image'], width: 150, height: 150);
        }
      else
        {
          image = Image.network(jsonResponse['knowledge_graph']['image'], width: 150, height: 150);
        }

      List<dynamic> mylist = jsonResponse['knowledge_graph']['players'];
      return mylist.map((player) => new Player.fromJson(player, team)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Scaffold _playersListView(data) {
    return Scaffold(
        appBar: AppBar(title: Text(team.name)),
        body: SafeArea(
            child: data == 0
            ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            )
            : Container(
                color: Colors.grey[50],
                child: Column(children: [
                  new Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0, 0],
                          colors: [Colors.green[400], Colors.white],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      height: 180,
                      width: 360,
                      child: Row(children: [
                        Container(
                          width: 200,
                            child: Padding(

                                padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                                child: Text(description,
                                style: TextStyle(
                                  fontSize: 11.5
                                )))),
                        image,
                      ]))),
                  new Container(
                      height: 383,
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayerInfo(data[index])),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(20, 1, 0, 0),
                                        child: Container(
                                            width: 287,
                                            child: Text('${data[index].name}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold)))),
                                    IconButton(
                                      icon: Icon(favoritesPlayers
                                          .contains(data[index].name)
                                          ? Icons.star
                                          : Icons.star_border),
                                      onPressed: () {
                                        setState(() {
                                          if (favoritesPlayers
                                              .contains(data[index].name)) {
                                            favoritesPlayers
                                                .remove(data[index].name);
                                          } else {
                                            favoritesPlayers.add(data[index].name);
                                          }
                                        });
                                        print(favoritesPlayers.toString());
                                      },
                                    )

                                  ]),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      stops: [0, 0],
                                      colors: [Colors.green[400], Colors.white],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                ));
                          }))
                ]))));
  }
}