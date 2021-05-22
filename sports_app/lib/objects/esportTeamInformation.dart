import 'package:flutter/cupertino.dart';
import 'package:sports_app/objects/player.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/webAPI.dart';

import 'league.dart';

class EsportTeamInformation
{
  String name;
  String description;
  String position;
  String wikiURL;
  NetworkImage image;

  EsportTeamInformation (String position, String name, String description, NetworkImage image, String wikiURL){
    this.position = position;
    this.name = name;
    this.description = description;
    this.image = image;
    this.wikiURL = wikiURL;
  }
}