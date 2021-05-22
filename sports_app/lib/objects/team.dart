import 'package:flutter/cupertino.dart';
import 'package:sports_app/objects/player.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/webAPI.dart';
import 'package:sports_app/objects/Objects.dart';

import 'league.dart';

class Team extends Objects
{
  final String name;
  final String apiUrl;
  League league;

  Team({this.name, this.apiUrl, this.league});

  factory Team.fromJson(Map<String, dynamic> json, League league) {
    return Team(
      name: json['name'],
      apiUrl: WebAPI.getURL(json['name'].replaceAll(" ", "+").replaceAll("\'", "") + "+esport+players"),
      league: league
    );
  }
}