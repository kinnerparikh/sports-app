import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiView extends StatefulWidget {

  final String postUrl;
  WikiView({@required this.postUrl});

  @override
  _WikiView createState() => _WikiView();
}

class _WikiView extends State<WikiView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:  widget.postUrl,
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
