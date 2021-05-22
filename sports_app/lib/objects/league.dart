import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sports_app/objects/Statistic.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/objects/webAPI.dart';
import 'package:sports_app/objects/Objects.dart';


class League extends Objects
{
  String _name;
  String _apiUrl;
  Icon _icon;
  String _accessField;
  List<Statistic> _stats;

  League(String name, String apiUrl, Icon icon, String accessField, List<Statistic> stats)
  {
    this._name = name;
    this._apiUrl = apiUrl;
    this._icon = icon;
    this._accessField = accessField;
    this._stats = stats;
  }

  List<Statistic> get stats
  {
    return _stats;
  }

  String get name
  {
    return _name;
  }

  String get apiUrl
  {
    return _apiUrl;
  }

  String get accessField
  {
    return _accessField;
  }

  Icon get icon
  {
    return _icon;
  }


}