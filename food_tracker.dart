import 'package:flutter/cupertino.dart';
import 'reuseable.dart';
import 'main.dart';
import 'daily_value.dart';

class MainPage extends StatefulWidget {

  const MainPage({Key? key, }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle),
            label: 'Daily Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.exclamationmark_circle),
            label: 'enter data',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: DailyTracker(),
                );
              });
              break;
            // case 1:
              // returnValue = CupertinoTabView(builder: (context) {
                // return CupertinoPageScaffold(
                  // child: SearchTab(),

                // );
              // });
              // break;
            // case 2:
            //   returnValue = CupertinoTabView(builder: (context) {
            //     return CupertinoPageScaffold(
            //       child: ShoppingCartTab(),
            //     );
            //   });
            //   break;
          }
          return returnValue;
            },
        );
      },
    );
  }
}
