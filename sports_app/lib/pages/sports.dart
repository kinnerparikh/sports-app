import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sports_app/objects/Statistic.dart';
import 'package:sports_app/objects/league.dart';
import 'package:sports_app/objects/webAPI.dart';
import 'package:sports_app/objects/Objects.dart';
import 'TeamListView.dart';
import 'favorites.dart';

class Sports extends StatefulWidget {
  @override
  _Sports createState() => _Sports();
}

class _Sports extends State<Sports> {

  static List<Objects> leagues = <Objects>[
    new League("National Football League", WebAPI.getURL("national+football+league+teams"), Icon(Icons.sports_football), "teams",
        [
          new Statistic("Touchdowns", "td", null),
          new Statistic("Yards", "yds", null),
        ]),
    new League("National Basketball Association", WebAPI.getURL("nba+teams"), Icon(Icons.sports_basketball), "teams",
        [
          new Statistic("Points Scored", "pts", null),
          new Statistic("Field Goal %", "fg", null),
          new Statistic("Three Point %", "3pt", null),
          new Statistic("Rebounds", "reb", null),
          new Statistic("Assists", "ast", null),
          new Statistic("Steals", "stl", null),
          new Statistic("Minutes Played", "min", null),
        ]),
    new League("Major League Baseball", WebAPI.getURL("mlb+teams"), Icon(Icons.sports_baseball), "teams", null),
    new League("Women\'s National Basketball Association", WebAPI.getURL("wnba+teams"), Icon(Icons.sports_basketball), "teams", null),
    new League("International Cricket Council", WebAPI.getURL("icc+teams"), Icon(Icons.sports_cricket),"international_cricket_council",
        [
          new Statistic("Matches", "m", null),
          new Statistic("Innings", "inn", null),
          new Statistic("Not outs", "no", null),
          new Statistic("Runs", "runs", null),
          new Statistic("High Score", "hs", null),
          new Statistic("Average", "avg", null),
          new Statistic("Balls Faced", "bf", null),
          new Statistic("Strike Rate", "sr", null),
          new Statistic("Centuries", "100s", null),
          new Statistic("Fifties", "50s", null),
        ]),
    new League("Premier League", WebAPI.getURL("premier+league+teams"), Icon(Icons.sports_soccer), "teams",         [
      new Statistic("Matches", "matches", null),
      new Statistic("Goals", "goals", null),
      new Statistic("Assists", "assists", null),
    ]),
    new League("Major League Soccer", WebAPI.getURL("mls+teams"), Icon(Icons.sports_soccer), "teams", null),
    new League("National Hockey League", WebAPI.getURL("nhl+teams"), Icon(Icons.sports_hockey), "teams", null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: Colors.grey[50],
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: leagues.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeamListView(leagues[index]),
                            ));
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(10),
                            child: Row(children: [
                              Padding(padding: EdgeInsets.fromLTRB(10,0,0,0), child: leagues[index].icon),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 1, 0, 0),
                                  child: Container(
                                      width: 280,
                                      child: Text('${leagues[index].name}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)))),
                              IconButton(
                                icon: Icon(favoritesLeague
                                    .contains(leagues[index].name)
                                    ? Icons.star
                                    : Icons.star_border),
                                onPressed: () {
                                  print("pressed");
                                  setState(() {
                                    if (favoritesLeague
                                        .contains(leagues[index].name)) {
                                      favoritesLeague
                                          .remove(leagues[index].name);
                                    } else {
                                      favoritesLeague.add(leagues[index].name);
                                    }
                                  });
                                  print(favoritesLeague.toString());
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
        )
    );
  }
}