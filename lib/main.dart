import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_appylar/flutter_appylar.dart';
import 'package:flutter_appylar/flutter_appylar_view.dart';
import 'dart:io' show Platform;


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppylarBannerViewController _appylarBannerViewController;

  @override
  void initState() {
    super.initState();
    Appylar.methodChannel.setMethodCallHandler(appylarCallBackHandler);
    initPlatformState();
    initialize();
  }

  Future<void> appylarCallBackHandler(MethodCall call) async {
    final String method = call.method;
    dynamic argument = call.arguments;
    switch (method) {
      case "onInitialized":
        {
          print("flutter: onInitialized: $argument");
        }
        break;
      case "onError":
        {
          print("flutter: onError: $argument");
        }
        break;
      case "onNoBanner":
        {
          print("flutter: onNoBanner: $argument");
        }
        break;
      case "onBannerShown":
        {
          print("flutter: onBannerShown: $argument");
        }
        break;
      case "onNoInterstitial":
        {
          print("flutter: onNoInterstitial: $argument");
        }
        break;
      case "onInterstitialShown":
        {
          print("flutter: onInterstitialShown: $argument");
        }
        break;
      case "onInterstitialClosed":
        {
          print("flutter: onInterstitialClosed: $argument");
        }
        break;
      default:
        {
          print("flutter: no callback");
        }
        break;
    }
  }

  void initialize(){
    try {
      var appKey = "";
      if (Platform.isAndroid) {
        appKey = "<YOUR_ANDROID_APP_KEY>";
      }else{
        appKey = "<YOUR_IOS_APP_KEY>";
      }
      bool testMode = true;
      Appylar.initialize(appKey,[AdType.banner,AdType.interstitial],testMode);
    } on PlatformException {

    }
  }

  void showBanner() async {
    var canShowBanner =  await _appylarBannerViewController.canShowAd();
    print("canShowBanner: $canShowBanner");
    _appylarBannerViewController.showAd();

  }

  void hideBanner() {
    _appylarBannerViewController.hideAd();
  }

  void showInterstitial() async {
    var canShowInterstitial = await Appylar.canShowAd();
    print("canShowInterstitial: $canShowInterstitial");
    Appylar.showAd();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

static const Color standardBlue = Color(0xFF7590BA);
static const Color textColor = Color(0xFF293642);

 @override
 Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Title',
    home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Spacer(),
          
          Text("Appylar Flutter\nSample App", 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, color: textColor)
          ),
         
          SizedBox(height: 30),
           
          Center( 
            child: SizedBox(width: 200, 
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(standardBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )
                  )
                ),
                onPressed: () {showBanner();},
                child: Text("SHOW BANNER", style: TextStyle(color: Colors.white)),
              ),
            )
          ),
          SizedBox(height: 7),
          Center( 
            child: SizedBox(width: 200, 
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(standardBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )
                  )
                ),
                onPressed: () {hideBanner();},
                child: Text("HIDE BANNER", style: TextStyle(color: Colors.white)),
              ),
            )
          ),
          SizedBox(height: 7),
          Center( 
            child: SizedBox(width: 200, 
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(standardBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )
                  )
                ),
                onPressed: () {showInterstitial();},
                child: Text("SHOW INTERSTITIAL", style: TextStyle(color: Colors.white)),
              ),
            )
          ),
          Spacer(),
          Center(
            child: AppylarBannerView(
              onAppylarBannerViewCreated: _onAppylarBannerViewCreated,
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    ),
  );
}
 void _onAppylarBannerViewCreated(AppylarBannerViewController controller) {
    print("_onAppylarBannerViewCreated");
    _appylarBannerViewController = controller;
  }
}
