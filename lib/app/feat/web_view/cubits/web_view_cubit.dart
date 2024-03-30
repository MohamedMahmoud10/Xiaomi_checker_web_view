import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCubit extends Cubit<String> {
  late WebViewController controller;
  bool isLoaded = false;

  WebViewCubit() : super('') {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            controller.runJavaScript('''
                (function () {const elementsToRemove = [document.getElementsByTagName("header")[0].parentElement,document.getElementById("globalIcons"),document.getElementById("footer").parentElement.parentElement,];elementsToRemove.forEach(element => {element.parentNode.removeChild(element);});})();
                ''');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('The New Request Is $request');
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void loadUrl(String url) {
    controller.loadRequest(Uri.parse(url));
    emit(url);
  }
}
