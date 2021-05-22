import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/objects/Statistic.dart';
import 'package:sports_app/objects/player.dart';
import 'package:http/http.dart' as http;

class PlayerStats extends StatefulWidget {
  Player player;

  PlayerStats(Player player) {
    this.player = player;
  }

  @override
  _PlayerStats createState() => _PlayerStats(player);
}

class _PlayerStats extends State<PlayerStats> {
  Player player;

  _PlayerStats(Player player) {
    this.player = player;
  }

  List<Statistic> statistics = new List<Statistic>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _fetchStats(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          return getStatsList(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return getStatsList(0);
      },
    );
  }

  bool isNull;
  Future<dynamic> _fetchStats() async {
    final listAPIUrl = player.apiUrl.replaceAll("+esport", "");
    final response = await http.get(Uri.parse(listAPIUrl));
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      isNull = jsonResponse['sports_results'] == null;
      if (!isNull) {
        print(jsonResponse['sports_results']['tables'][0]['games'].length);
        for (int i = 0; i <
            jsonResponse['sports_results']['tables'][0]['games'].length; i++) {
          if(player.league.name == "National Football League")
          {
            statistics.add(new Statistic(jsonResponse['sports_results']['tables'][0]['games'][i]['year'], null, null));
          }
          else if(player.league.name == "National Basketball Association")
          {
            statistics.add(new Statistic(jsonResponse['sports_results']['tables'][0]['games'][i]['game'], null, null));
          }
          else if(player.league.name == "Premier League")
          {
            statistics.add(new Statistic(jsonResponse['sports_results']['tables'][0]['games'][i]['league'], null, null));
          }
          else
          {
            statistics.add(new Statistic(jsonResponse['sports_results']['tables'][0]['games'][i]['title'], null, null));
          }
          for (int j = 0; j < player.league.stats.length; j++)
            statistics.add(new Statistic(
                player.league.stats[j].name, player.league.stats[j].abbrev,
                jsonResponse['sports_results']['tables'][0]['games'][i][player
                    .league
                    .stats[j].abbrev]));
        }
      }
      return statistics;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Scaffold getStatsList(data)
  {
    if (data == 0) {
      return Scaffold(
          appBar: AppBar(title: Text(player.name)),
          body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              )
          )
      );
    }
    if(isNull)
      {
        return Scaffold(
          appBar: AppBar(title: Text(player.name)),
          body: SafeArea(
            child: Center(child: Text('No stats available'))
          )
        );
      }
    return Scaffold(
        appBar: AppBar(title: Text(player.name)),
        body: SafeArea(
            child:
              Container(
                height: 583,
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(

                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Row(
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(20, 1, 0, 0),
                                  child: Container(
                                      width: 220,
                                      child: Text(data[index].name != null ? '${data[index].name}' : 'Career',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:
                                              data[index].statistic == null ? FontWeight.bold : FontWeight.normal)))),
                              Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(20, 1, 0, 0),
                                  child: Container(
                                      width: 75,
                                      child: Text(data[index].statistic != null ? '${data[index].statistic}' : '',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.bold)))),
                            ]),
                      );
                    })
            )
        ));
  }
}

