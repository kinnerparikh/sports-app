import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sports_app/objects/league.dart';
import 'package:sports_app/objects/webAPI.dart';
import 'EsportsTeamListView.dart';
import 'TeamListView.dart';
import 'favorites.dart';

class Esports extends StatefulWidget {
  @override
  _Esports createState() => _Esports();
}

class _Esports extends State<Esports> {
  List<League> leagues = <League>[
    new League("League of Legends", WebAPI.getURL("league+of+legends+teams"), Icon(null), "league_of_legends", null),
    new League("Overwatch", WebAPI.getURL("overwatch+teams"), Icon(null), "overwatch", null),
    new League("Counter-Strike: Global Offensive", WebAPI.getURL("csgo+teams"), Icon(null), "counter_strike_global_offensive", null),
    new League("Valorant", WebAPI.getURL("valorant+teams"), Icon(null), "valorant", null),
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
                                  builder: (context) => EsportsTeamListView(leagues[index]),
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
                                  setState(() {
                                    if (favoritesLeague

                                        .contains(leagues[index].name)) {
                                      favoritesLeague

                                          .remove(leagues[index].name);
                                    } else {
                                      favoritesLeague
                                          .add(leagues[index].name);
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
                    })
            )
        )
    );
  }


}
