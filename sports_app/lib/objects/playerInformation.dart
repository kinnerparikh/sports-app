import 'package:flutter/cupertino.dart';
import 'package:sports_app/objects/player.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/webAPI.dart';

import 'league.dart';

class PlayerInformation
{
  String name;
  String description;
  String height;
  String position;
  NetworkImage image;

  PlayerInformation (String position, String name, String description, String height, NetworkImage image){
    this.position = position;
    this.name = name;
    this.description = description;
    this.height = height;
    this.image = image;
}
}