import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_app/objects/esportTeamInformation.dart';
import 'package:sports_app/objects/league.dart';
import 'package:sports_app/objects/player.dart';
import 'package:http/http.dart' as http;
import 'package:sports_app/objects/playerInformation.dart';
import 'package:sports_app/objects/team.dart';
import 'package:sports_app/pages/wikiView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EsportsInfo extends StatelessWidget {
  Team team;
  EsportsInfo(Team team)
  {
    this.team = team;
  }
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _fetchPlayerInformation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          return _playerInformationView(data, context);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return _playerInformationView(0, context);
      },
    );
  }

  Future<dynamic> _fetchPlayerInformation() async {

    final listAPIUrl = team.apiUrl.replaceAll("+players", "");
    final response = await http.get(Uri.parse(listAPIUrl));
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);

      String position;
      String name = team.name;
      String description;
      NetworkImage image;
      String wikiURL;
      if(jsonResponse['knowledge_graph'] != null)
        {
          position = jsonResponse['knowledge_graph']['type'];
          description = jsonResponse['knowledge_graph']['description'];
          image = NetworkImage(jsonResponse['knowledge_graph']['header_images'][0]['image']);
          wikiURL = jsonResponse['knowledge_graph']['source']['link'];
        }

      return EsportTeamInformation(position, name, description, image, wikiURL);

    } else {
      throw Exception('Failed to load jobs from API');
    }
  }


  Scaffold _playerInformationView(data, BuildContext context) {
    if (data == 0) {
      return Scaffold(
        appBar: AppBar(title: Text("")),
          body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              )
          )
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(data.name.toString())),
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red, Colors.redAccent]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 337.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: data.image,
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        data.position.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    IconButton(
                                        icon: FaIcon(FontAwesomeIcons.wikipediaW),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WikiView(
                                                  postUrl: data.wikiURL,
                                                )));
                                      },
                                    )
                                    ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 23.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(data.description.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}