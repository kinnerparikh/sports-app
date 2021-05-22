import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _Notification createState() => _Notification();

  void createNotifs() {
    NotifBuild a = new NotifBuild("C9 eliminated from MSI 2021", "");
    NotifBuild b = new NotifBuild("EG v TSM Game 1 Starting", "");
    notifs.add(a);
    notifs.add(b);
  }
}

List<NotifBuild> notifs = <NotifBuild>[
  new NotifBuild('C9 eliminated from MSI 2021', ''),
  new NotifBuild('Marquise Brown switches jersey numbers', ''),
  new NotifBuild('VCT Stage 2 Masters starts today!', ''),
];

class _Notification extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notifications')),
        body: notifs.isEmpty
            ? Center(
              child: Text("All Clear!"),
            )
            : SafeArea(
            child: Container(
                color: Colors.grey[50],
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: notifs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = notifs[index].titleText;
                      return Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          setState(() {
                            notifs.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: Center(
                            child: Text('Delete',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(10),
                          child: Row(children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 1, 0, 0),
                                child: Container(
                                    width: 300,
                                    child: Text(
                                        '${notifs[index].getTitleText()}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)))),
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
                        ),
                      );
                      /*return Container(
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 1, 0, 0),
                              child: Container(
                                  width: 300,
                                  child: Text('${notifs[index].getTitleText()}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)))),
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
                      );*/
                    }))));
  }
}

class NotifBuild {
  String titleText;
  String subText;

  NotifBuild(String titleText, String subText) {
    this.titleText = titleText;
    this.subText = subText;
  }

  String getTitleText() {
    return titleText;
  }

  String getSubText() {
    return subText;
  }
}
