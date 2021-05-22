import 'package:flutter/cupertino.dart';
import 'package:sports_app/objects/player.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/webAPI.dart';
import 'package:sports_app/objects/Objects.dart';


import 'league.dart';

class Player extends Objects
{
  final String name;
  final String apiUrl;
  League league;

  Player({this.name, this.apiUrl, this.league});

  factory Player.fromJson(Map<String, dynamic> json, Team team) {
    return Player(
      name: json['name'],
      apiUrl: WebAPI.getURL(json['name'].replaceAll(" ", "+").replaceAll("\'", "")),
      league: team.league
    );
  }
}