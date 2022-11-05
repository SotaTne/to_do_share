import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Widgets/home.dart';
import 'firebase_options.dart';

//追記後のコード

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.userChanges().first;
  runApp(const List_Share_App());
  // Disable persistence on web platforms. Must be called on initialization:
}

/// Todoリストアプリのクラス
///
/// 以下の責務を持つ
/// ・Todoリスト画面を生成する
class List_Share_App extends StatefulWidget {
  const List_Share_App({Key? key}) : super(key: key);

  @override
  State<List_Share_App> createState() => _List_Share_AppState();
}

class _List_Share_AppState extends State<List_Share_App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      //アプリケーションの名前
      title: 'ToDoShare',
      //
      //アプリケーションのテーマ
      theme: ThemeData(),
      //
      //アプリケーションの中身
      home: const ToDo_Home(),

      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const List_Share_App(),
      },
    );
  }
}
