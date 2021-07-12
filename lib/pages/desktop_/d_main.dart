// import 'dart:developer';
// import 'dart:html';

import 'dart:developer';
import 'dart:html';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_dubhe/pages/common/main_drawer.dart';
import 'package:new_dubhe/animation/on_hover_animation.dart';
// import 'package:new_dubhe/pages/common/side_menu.dart';
import 'package:new_dubhe/pages/desktop_/d_second.dart';
// import 'package:url_launcher/url_launcher.dart';

//ddda
class DesktopMain extends StatefulWidget {
  @override
  _DesktopMainState createState() => _DesktopMainState();
}

class _DesktopMainState extends State<DesktopMain>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  late double scrollVar = 0;
  late bool scrollState = false;
  bool _showBacktoTopButton = false;
  Color textColor = Colors.white;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;

  ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  late AnimationController a;
  late Animation<double> animation;
  late Animation<double> opacityAnimation;
  late Animation<double> appbarOpacity;
  late Animation<double> appbarOpacity2;
  late Animation<Offset> offSetAnimation;

  @override
  void initState() {
    // scrollController 의 상태
    //
    scrollController.addListener(() {
      setState(() {
        // 스크롤 영역이 현재 보여지는 화면의 높이보다 크면
        // 플롯팅 버튼 활성
        if (scrollController.offset >= 10) {
          _showBacktoTopButton = true;
        } else {
          // 플롯팅 버튼 비활성화
          _showBacktoTopButton = false;
        }
        // 스크롤 범위 값 대입
        scrollVar = scrollController.offset;

        // 스크롤 범위 값이 10보다 크면 상단바 색상 반전
        if (scrollVar > 10) {
          scrollState = true;
        } else {
          scrollState = false;
        }
      });
    });

    // 애니메이션
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    appbarOpacity =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    appbarOpacity2 =
        Tween<double>(begin: 1, end: 0).animate(animationController);

    offSetAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, -1))
        .animate(animationController);

    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

    // animationController.addListener(() {
    //   setState(() {});
    // });

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  // 맨위 상단으로 올라가기
  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  Widget makeText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: (scrollState ? textColor : Colors.black),
        fontSize: fontSize,
      ),
    );
  }

  Widget makeMainText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
    );
  }

  Widget animationBox(String imgPath) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Container(
              //height: screenHeight,
              child: Image.asset(imgPath)),
        );
      },
    );
  }

  Widget gnb() {
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                print("Hybrid Services Click");
                Get.to(DesktopSecond());
              },
              child: makeText("Hybrid Services", 18)),
          makeText("Platform", 18),
          makeText("Solution", 18),
          makeText("Resource", 18),
          makeText("About", 18),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("ScrollVar : ${scrollVar}");
    // print(_showBacktoTopButton);
    // print(MediaQuery.of(context).size.width);
    print("ScreenHeight :${MediaQuery.of(context).size.height}");
    print("ScreenHeight/3 : ${screenHeight * 3}");
    print("ScreenHeight/3 : ${screenHeight * 2}");
    print("패딩값 ${MediaQuery.of(context).padding.top}");

    return
        // Scaffold(
        //   body: Container(
        //     child: Text("adsa"),
        //   ),
        // );
        Scaffold(
      floatingActionButton: _showBacktoTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollToTop();
              },
              child: Icon(
                Icons.arrow_circle_up,
              )),
      key: drawerKey,
      body: Container(
        child: Stack(children: [
          ListView(controller: scrollController, children: [
            Stack(
              children: [
                // Container(
                //   height: screenHeight,
                //   width: screenWidth,
                //   child: Image.asset(
                //     "assets/images/bg_test04.jpeg",
                //     fit: BoxFit.fill,
                //   ),
                // ),
                Container(
                  child: Placeholder(fallbackHeight: screenHeight),
                ),
                Container(
                  height: screenHeight,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.05 * screenWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        makeMainText("고객의 클라우드 여정을 함께합니다", 30),
                        makeMainText("국내 유일의 엔드 투 엔드", 40),
                        makeMainText("하이브리드 클라우드 인터그레이터", 40),
                        SizedBox(height: 80),
                        Row(
                          children: [
                            makeMainText("자세히 보기", 18),
                            Icon(Icons.arrow_forward_ios_sharp),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // Container(
            //   height: screenHeight,
            //   color: Colors.orange,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Center(
            //       child: Container(
            //         width: 800,
            //         child: Table(
            //           border: TableBorder.all(color: Colors.white),
            //           columnWidths: {},
            //           children: [
            //             TableRow(children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: OnHoverAnimation(
            //                   child: Container(
            //                       child: Image.asset(
            //                           "assets/images/bg_test04.jpeg")),
            //                 ),
            //               ),
            //               Container(
            //                   child:
            //                       Image.asset("assets/images/bg_test03.jpeg")),
            //             ]),
            //             TableRow(children: [
            //               Container(
            //                   child:
            //                       Image.asset("assets/images/bg_test03.jpeg")),
            //               Container(
            //                   child:
            //                       Image.asset("assets/images/bg_test04.jpeg")),
            //             ]),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Container(
              color: Colors.yellow,
              height: screenHeight,
              alignment: Alignment.center,
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "고객의 상황에 맞는 최적의 클라우드 경험을 제공합니다.",
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    if (scrollVar > screenHeight * 2 - (screenHeight - 80) / 2)
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(seconds: 1),
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Opacity(
                            opacity: value,
                            child: Image.asset("assets/images/bg_test01.jpeg"),
                          );
                        },
                      )
                    else
                      Opacity(
                        opacity: 0,
                        child: Image.asset("assets/images/bg_test01.jpeg"),
                      ),
                  ],
                ),
              ]),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.black,
              child: SizedBox(
                height: 100,
                width: 100,
                child: (scrollVar > screenHeight * 3 - (screenHeight - 80) / 2)
                    ? Transform.translate(
                        offset: this.offSetAnimation.value,
                        child: Opacity(
                          opacity: this.opacityAnimation.value,
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),
            // FadeTransition(
            //   opacity: animation,
            //   child: Container(
            //     color: Colors.blue,
            //     height: screenHeight,
            //   ),
            // ),
            Container(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    //  padding: EdgeInsets.fromLTRB(100, 20, 0, 20),
                    child: ListView(
                      padding: EdgeInsets.only(left: 50),
                      scrollDirection: Axis.horizontal,
                      children: [
                        OnHoverAnimation(
                          child: Card(
                            //    margin: EdgeInsets.all(20),
                            elevation: 7,
                            child: Center(
                              child: Container(
                                width: 500,
                                height: 80,
                                //child: Text("Card"),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 500,
                              height: 80,
                              //child: Text("Card"),
                            ),
                          ),
                        ),
                        Card(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 500,
                              height: 80,
                              //child: Text("Card"),
                            ),
                          ),
                        ),
                        Card(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 500,
                              height: 80,
                              //  child: Text("Card"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Listv
          ]),

          // 상단 바
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(children: [
              AnimatedOpacity(
                opacity: scrollVar < 80 ? 0 : 1.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 80,
                  color: (scrollVar < 80 ? Colors.transparent : Colors.amber),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      makeText("Dubhe", 18),
                      (screenWidth > 700 ? gnb() : Container()),
                      GestureDetector(
                        onTap: () {
                          print("Drawer 활성");
                          drawerKey.currentState!.openEndDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          color: (scrollState ? textColor : Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
      endDrawer: Container(
        color: Colors.amber,
        width: screenWidth,
        height: screenHeight,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print("Drawer 종료");
                  Navigator.pop(context);
                },
                child: Container(
                    height: 80,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close, color: Colors.white)),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          makeText("Hybrid Services", 20),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
                      ),
                      Column(
                        children: [
                          makeText("Platform", 20),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
                      ),
                      Column(
                        children: [
                          makeText("Solution", 20),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
                      ),
                      Column(
                        children: [
                          makeText("Resource", 20),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
                      ),
                      Column(
                        children: [
                          makeText("About", 20),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
