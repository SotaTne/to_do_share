import 'package:flutter/material.dart';
import 'package:to_do_share/Data_List/list_data.dart';
import 'package:to_do_share/Widgets/home.dart';
import 'package:to_do_share/Widgets/listbody.dart';

class Task_Select extends StatefulWidget {
  const Task_Select({Key? key, required this.idkey}) : super(key: key);
  final String idkey;
  @override
  State<Task_Select> createState() => _Task_SelectState();
}

class _Task_SelectState extends State<Task_Select> {
  late String idkey;

  @override
  void initState() {
    super.initState();
    idkey = widget.idkey;
  }

  @override
  Widget build(BuildContext context) {
    print(tag.indexWhere((element) => element == data_list[idkey]!['tag']));
    return Scaffold(
      appBar: AppBar(
        title: Text(data_list[idkey]!['task_name']),
        backgroundColor: nowselectcolor[0]
            [tag.indexWhere((element) => element == data_list[idkey]!['tag'])],
      ),
      body: Container(),
    );
  }
}
