import 'package:flutter/cupertino.dart';

class Score
{
  String _team1;
  String _team2;
  String _score1;
  String _score2;
  String _logo1;
  String _logo2;
  String _date;
  //String _videoHighlights;

  Score(team1, team2, score1, score2, logo1, logo2, date)
  {
    this._team1 = team1;
    this._team2 = team2;
    this._score1 = score1;
    this._score2 = score2;
    this._logo1 = logo1;
    this._logo2 = logo2;
    this._date = date;
  //  this._videoHighlights = videoHighlights;
  }

  String get team1{ return _team1; }
  String get team2{ return _team2; }
  String get score1{ return _score1; }
  String get score2{ return _score2; }
  String get date{ return _date; }
  //String get videoHighlights{ return _videoHighlights; }
  String get logo1 { return _logo1; }
  String get logo2 { return _logo2; }
}