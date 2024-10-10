import 'package:flutter/material.dart';
// import 'package:webview_universal/webview_universal.dart';
import 'package:webview_all/webview_all.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key, required this.inUrl});

  final String? inUrl;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  // WebViewController webViewController = WebViewController();
  late String urlToView;

  @override
  void initState() {
    super.initState();

    if (widget.inUrl == null) {
      urlToView = '';
    } else {
      urlToView = widget.inUrl!;
    }

/*    webViewController.init(
      context: context,
      setState: setState,
      uri: Uri.parse(urlToView),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Webview(url: "https://innovism.net"),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          // webViewController.goBackSync();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
