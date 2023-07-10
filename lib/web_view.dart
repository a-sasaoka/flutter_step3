import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView(this._url, {super.key});

  final String _url;

  @override
  State<WebView> createState() => _WebView();
}

class _WebView extends State<WebView> {
  late final WebViewController _controller;

  bool _isLoading = false;
  String _title = '';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });
            final title = await _controller.getTitle();
            setState(() {
              if (title != null) {
                _title = title;
              }
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget._url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          if (_isLoading) const LinearProgressIndicator(),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
          Container(
            color: Colors.lightBlue,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      _controller.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      _controller.goForward();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
