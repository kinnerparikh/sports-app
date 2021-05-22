import 'dart:async';
import 'dart:convert';
import 'package:sports_app/objects/Score.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/league.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/objects/webAPI.dart';
import 'package:sports_app/pages/PlayerListView.dart';
import 'favorites.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TeamListView extends StatefulWidget {
  League league;
  TeamListView(League league)
  {
    this.league = league;
  }


  @override
  _TeamListView createState() => _TeamListView(league);
}

class _TeamListView extends State<TeamListView> {
  League league;
  _TeamListView(League league)
  {
    this.league = league;
  }
  List<Score> scores;
  bool isNull;
  String leagueLogo;
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
    final games = await http.get(Uri.parse(WebAPI.getURL(league.name + "+games")));
    final logo = await http.get(Uri.parse(WebAPI.getURL(league.name + "+logo")));

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      dynamic jsonGames = json.decode(games.body);
      dynamic jsonLogo = json.decode(logo.body);

      scores = List<Score>();
      isNull = jsonGames['sports_results']  == null;
      String date;
      String score1 = " ";
      String score2 = " ";
      if(!isNull) {
        for (int i = 0; i < jsonGames['sports_results']['games'].length; i++) {
          if(jsonGames['sports_results']['games'][i]['time'] != null)
            {
              date = jsonGames['sports_results']['games'][i]['date'] + " " + jsonGames['sports_results']['games'][i]['time'];
            }

          else if(jsonGames['sports_results']['games'][i]['date'] != null)
            {
              date = jsonGames['sports_results']['games'][i]['date'];
            }
          else
            {
              date = jsonGames['sports_results']['games'][i]['status'];
            }

          if(jsonGames['sports_results']['games'][i]['teams'][0]['score'] != null)
            {
              score1 = jsonGames['sports_results']['games'][i]['teams'][0]['score'];
              score2 = jsonGames['sports_results']['games'][i]['teams'][1]['score'];
            }

          scores.add(new Score(
            jsonGames['sports_results']['games'][i]['teams'][0]['name'],
            jsonGames['sports_results']['games'][i]['teams'][1]['name'],
            score1,
            score2,
            jsonGames['sports_results']['games'][i]['teams'][0]['thumbnail'],
            jsonGames['sports_results']['games'][i]['teams'][1]['thumbnail'],
            date,
          ));
        }
      }
      else
        {
          leagueLogo = jsonLogo['inline_images'][0]['thumbnail'];
        }

      List<dynamic> mylist = jsonResponse['knowledge_graph'][league.accessField];
      print(mylist.toString());
      return mylist.map((team) => new Team.fromJson(team, league)).toList();
    } else {
      throw Exception('Failed to load from API');
    }
  }

  Container getOngoingGames(data)
  {
    if(isNull)
      {
        return Container(
          height: 180,
          child: Image.network(leagueLogo)
        );
      }
    return Container(
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
      width: MediaQuery.of(context).size.width - 50,
      child: new Swiper(
        itemBuilder: (context, int index) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red, Colors.redAccent]
                )
            ),
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    data[index].team1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Image.network(
                  data[index].logo1,
                  width: 36.0,
                ),
               Column(
                    children: [
                      SizedBox(height: 70),
                 Container(
                  child: Text(
                    "${data[index].score1} - ${data[index].score2}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                    SizedBox(height: 10),
                    Text(data[index].date,
                      style: TextStyle(
                        color: Colors.white
                      ),)
                    ]
                ),
                Image.network(
                  data[index].logo2,
                  width: 36.0,
                ),
                Expanded(
                  child: Text(
                    data[index].team2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),

          );
        },
        itemCount: data.length,
        itemWidth: 300.0,
        layout: SwiperLayout.DEFAULT,
      ),
    );
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
                  new Container(height: 20),
                  getOngoingGames(scores),
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
                                          builder: (context) => PlayerListView(data[index])),
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
                                        print('pressed');
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
                                        print(favoritesTeams.toString());
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
                          })
                  )
                ])))
    );
  }
}