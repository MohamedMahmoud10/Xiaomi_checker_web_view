import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String? appBarTitle;
  final WebViewController controller;

  const WebViewScreen({
    super.key,
    this.appBarTitle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
            appBar: AppBar(
              title: Text(appBarTitle ?? ''),
            ),
            body: WillPopScope(
              onWillPop: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                  return false;
                } else {
                  return true;
                }
              },
              child: WebViewWidget(
                gestureRecognizers: Set()
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ),
                  ),
                controller: controller,
              ),
            ),
          );

  }
}
