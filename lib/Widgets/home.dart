import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Sign_In/google_sign_in.dart';
import 'listbody.dart';
import 'userbody.dart';

String hello = 'hello';
const bool test_bool = false;
List<List<MaterialColor>> nowselectcolor = [
  [
    Colors.orange,
    Colors.lightGreen,
    Colors.blue,
  ],
  [
    Colors.purple,
    Colors.purple,
    Colors.purple,
  ],
];
int _NavigatorIndex = 0;
//選んでいるNavigationBarの要素
//bodyを変える:1
//0~1
//
//
int _TabBarIndex = 0;
//選んでいるTabBarの要素
//bodyを変える:2
//0~2
//
//

class ToDo_Home extends StatefulWidget {
  const ToDo_Home({Key? key}) : super(key: key);

  @override
  State<ToDo_Home> createState() => _ToDo_HomeState();
}

class _ToDo_HomeState extends State<ToDo_Home> with TickerProviderStateMixin {
  late TabController _tabController;
  //NavigationBarが押された時の処理
  void _onNavigationBarTapped(int index) {
    setState(() {
      _NavigatorIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    //this is firebase
    print(test_bool);
    //test_bool = (FirebaseAuth.instance.currentUser != null);
  }

  @override
  Widget build(BuildContext context) {
    void setLogin() {
      setState(() {});
    }

    print('test_bool : $test_bool');
    final List<Widget> pagebody = [
      //bodyの中身 _NavigatorIndexにより変わる
      //今回は二つの要素
      //

      //bodyの中身 _TabBarIndexにより変わる

      List_Body(BarIndex: _TabBarIndex),

      //bodyの中身 _TabBarIndexにより変わる
      const UserBody(),
    ];
    //
    //
    //
    List<AppBar> openAppBar = [
      //今回は二つ
      //bodyの中身 _NavigatorIndexにより変わる
      AppBar(
        backgroundColor: nowselectcolor[_NavigatorIndex][_TabBarIndex],
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              indicatorColor: Colors.white,
              controller: _tabController,
              indicatorWeight: 2.2,
              tabs: const <Widget>[
                Tab(
                  child: Text('重要'),
                ),
                Tab(
                  child: Text('五分でできる'),
                ),
                Tab(
                  child: Text('後でいい'),
                ),
              ],
              onTap: (int index) {
                setState(() {
                  _TabBarIndex = index;
                });
              },
            ),
          ],
        ),
      ),
      AppBar(
        title: const Text('Setting'),
        backgroundColor: nowselectcolor[_NavigatorIndex][_TabBarIndex],
      ),
    ];
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        appBar: openAppBar[_NavigatorIndex],
        body: pagebody[_NavigatorIndex],
        //bodyは変わる
        //
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            //
            //_NavigatorIndex = 0
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'タスクリスト',
            ),
            //
            //_NavigatorIndex = 1
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '設定',
            ),
          ],
          currentIndex: _NavigatorIndex,
          //押されるたびに代わる値
          //
          selectedItemColor: nowselectcolor[_NavigatorIndex][_TabBarIndex],
          //今選んでいる要素の色
          //
          onTap: _onNavigationBarTapped,
          //押された時の処理
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'ToDo Share',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    try {
                      signInWithGoogle().then((value) => setState(
                            () {},
                          ));
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage("assets/google_logo.png"),
                          height: 32.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Google でログイン',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),
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
}
