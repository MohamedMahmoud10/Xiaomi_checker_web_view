import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_project/app/feat/web_view/cubits/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCubit extends Cubit<WebViewState> {
  late WebViewController controller;
  bool isLoaded = false;

  WebViewCubit() : super(WebViewStateInitialState()) {
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
            // Rest of your code...

            debugPrint('Page finished loading: $url');
            controller.runJavaScript('''
              const elementsToRemove = document.querySelectorAll('.status-check-bottom, #cloudflare-app-google-translate');
if (elementsToRemove.length > 0) {
    elementsToRemove.forEach(element => {
        element.remove();
    });
}
                ''');
            isLoaded = true; // Set loading flag to true when finished
            emit(WebViewSuccessState());
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
  }
}
