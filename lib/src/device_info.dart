import 'dart:io';
import 'dart:html';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_dubhe/pages/desktop_/d_main.dart';
import 'package:new_dubhe/pages/desktop_/d_second.dart';

class DeviceInfo extends StatefulWidget {
  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  late String deviceModel;

  // true  : Web UI,
  // false : Mobile UI
  bool deviceValue = true;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    getModel();
    print("initState 실행");
  }

  getModel() async {
    print("getModel 실행");
    // 조건에 따라
    // 갤럭시탭, iPad 는 true
    // web이면 true,
    // androidPhone 또는 iPhone 이면 false,
    // 그외 기타접속기기면 기본으로 true값으로 web화면으로 출력
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      var userAgent = webBrowserInfo.userAgent;
      setState(() {
        if (userAgent!.contains("SM-P") ||
            userAgent.contains("SM-T") ||
            userAgent.contains("iPad")) {
          // SM-P
          // SM-T 는 안드로이드 타블렛 모델명 중 일부
          // iPad
          deviceValue = true;
          print("user agent : ${webBrowserInfo.userAgent}");
        } else if (userAgent.contains("Mobile")) {
          // androidPhone 과 iPhone
          deviceValue = false;
          print("user agent : ${webBrowserInfo.userAgent}");
        } else {
          // 갤럭시탭, iPad,
          // AndroidPhone, iPhone 을 제외한
          // 그 외 (web)
          deviceValue = true;
          print("user agent : ${webBrowserInfo.userAgent}");
        }
      });
      return deviceValue;
    }
  }

  Widget device() {
    if (deviceValue) {
      return Container(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 900),
          child: Container(
            alignment: Alignment(0.0, 0.0),
            child: DesktopMain(),
            //child: Text("Web UI"),
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment(0.0, 0.0),
        child:
            //SafeArea(child: DesktopMain()),
            SafeArea(
          child: DesktopSecond(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: device(),
    );
  }
}
