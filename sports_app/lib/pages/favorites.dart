import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sports_app/pages/TeamListView.dart';


Set<String> favoritesPlayers = Set<String>();
Set<String> favoritesTeams = Set<String>();
Set<String> favoritesLeague = Set<String>();

class Favorites extends StatefulWidget {
  @override
  _Favorites createState() => _Favorites();
}

String removed;
int removedFrom;

class _Favorites extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    favoritesLeague.addAll(favoritesTeams);
    favoritesLeague.addAll(favoritesPlayers);
    return Scaffold(
        body: SafeArea(
            child: favoritesLeague.isEmpty
              ? Center(
              child: Text('Nothing is favorited')
              )
              : Container(
                color: Colors.grey[50],
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: favoritesLeague.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Row(children: [

                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 1, 0, 0),
                              child: Container(
                                  width: 300,
                                  child: Text(
                                      '${favoritesLeague.elementAt(index)}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)))),
                          IconButton(
                            icon: Icon(favoritesLeague
                                    .contains(favoritesLeague.elementAt(index))
                                ? Icons.star
                                : Icons.star_border),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${favoritesLeague.elementAt(index)} removed from favorites.'),
                                      action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            setState(() {
                                              if (removedFrom == 0) {
                                                favoritesPlayers.add(removed);
                                              }
                                              else if (removedFrom == 1) {
                                                favoritesTeams.add(removed);
                                              }
                                              else {
                                                favoritesLeague.add(removed);
                                              }
                                            });
                                          }),
                                      duration: Duration(seconds: 2)));
                              setState(() {
                                removed = favoritesLeague.elementAt(index);
                                if (favoritesPlayers.contains(favoritesLeague.elementAt(index))){
                                  removedFrom = 0;
                                  favoritesLeague.remove(favoritesLeague.elementAt(index));
                                }
                                else if (favoritesTeams.contains(favoritesLeague.elementAt(index))){
                                  removedFrom = 1;
                                  favoritesTeams.remove(favoritesLeague.elementAt(index));
                                }
                                else {
                                  removedFrom = 2;
                                }
                                favoritesLeague.remove(favoritesLeague.elementAt(index));
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
                      );
                    }))));
  }
}
