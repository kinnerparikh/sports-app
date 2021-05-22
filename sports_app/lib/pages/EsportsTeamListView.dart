import 'dart:async';
import 'dart:convert';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/league.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/pages/PlayerListView.dart';
import 'esportsInfo.dart';
import 'favorites.dart';

class EsportsTeamListView extends StatefulWidget {
  League league;
  EsportsTeamListView(League league)
  {
    this.league = league;
  }

  @override
  _EsportsTeamListView createState() => _EsportsTeamListView(league);
}

class _EsportsTeamListView extends State<EsportsTeamListView> {
  League league;
  _EsportsTeamListView(League league)
  {
    this.league = league;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Team>>(
            future: _fetchTeams(),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Team> data = snapshot.data;
              return _playersListView(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return _playersListView(0);
          },
        );

  }

  Future<List<Team>> _fetchTeams() async {

    final listAPIUrl = league.apiUrl;
    final response = await http.get(Uri.parse(listAPIUrl));

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      List<dynamic> mylist = jsonResponse['knowledge_graph'][league.accessField];
      return mylist.map((team) => new Team.fromJson(team, league)).toList();
    } else {
      throw Exception('Failed to load from API');
    }
  }

  Scaffold _playersListView(data) {
    return Scaffold(
        appBar: AppBar(title: Text(league.name)),
        body: SafeArea(
            child: data == 0
            ? Center(
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            )
            : Container(
                color: Colors.grey[50],
                child: Column(children: [
                  new Container(
                      height: 200,
                      child: Column(children: [
                        Center(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                child: Text('Ongoing game score here')))
                      ])),
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
                                          builder: (context) => EsportsInfo(data[index])),
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
                                      icon: Icon(favoritesTeams
                                          .contains(data[index].name)
                                          ? Icons.star
                                          : Icons.star_border),
                                      onPressed: () {
                                        setState(() {
                                          if (favoritesTeams.contains(
                                              data[index].name)) {
                                            favoritesTeams
                                                .remove(data[index].name);
                                          } else {
                                            favoritesTeams
                                                .add(data[index].name);
                                          }
                                        });
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