import 'package:creatro_app/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UI/home_screen.dart';
import 'UI/info_screen.dart';
import 'UI/list_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _pageindex = 0;
  bool loading = false;
  late PageController pcontroller;

  @override
  void initState() {
    super.initState();
    pcontroller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pcontroller.dispose();
  }

  void navigationState(int page) {
    pcontroller.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _pageindex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            // extendbody is for transparent borderradius of the navigationbar
            extendBody: true,
            body: PageView(
              controller: pcontroller,
              onPageChanged: onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeScreen(),
                ListScreen(),
                InfoScreen(),
              ],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: CupertinoTabBar(
                backgroundColor: const Color(0xffE02087),
                height: 60,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      _pageindex == 0
                          ? Icons.play_arrow
                          : Icons.play_arrow_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      _pageindex == 1
                          ? Icons.emoji_emotions
                          : Icons.emoji_emotions_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      _pageindex == 2 ? Icons.phone : Icons.phone_outlined,
                      color: Colors.white,
                      size: 29,
                    ),
                    backgroundColor: Colors.black,
                  ),
                ],
                onTap: navigationState,
              ),
            ),
          );
  }
}
