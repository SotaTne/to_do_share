import 'package:flutter/material.dart';
import 'package:to_do_share/Data_List/group_data.dart';
import 'package:to_do_share/Data_List/list_data.dart';
import 'package:to_do_share/Widgets/home.dart';
import 'package:to_do_share/Widgets/listbody.dart';

class Add_List extends StatefulWidget {
  const Add_List({Key? key, required this.first_BarIndex}) : super(key: key);
  final int first_BarIndex;
  @override
  State<Add_List> createState() => _Add_ListState();
}

class _Add_ListState extends State<Add_List> {
  late int BarIndex;
  String taskname = ''; //list_name
  bool isChecked = false; //isonline
  String tagvalue = tag[0]; //tag
  bool no_group = true;
  late String groupValue; //group_id

  @override
  void initState() {
    if (Group_Id.isNotEmpty) {
      no_group = false;
      groupValue = Group_Id[0];
    } else {
      groupValue = '0';
    }
    tagvalue = tag[widget.first_BarIndex];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BarIndex = widget.first_BarIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('タスクリストの追加'),
        backgroundColor: nowselectcolor[0][BarIndex],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 30, 10),
            child: TextField(
                cursorColor: nowselectcolor[0][BarIndex],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: nowselectcolor[0][BarIndex]),
                  ),
                ),
                onChanged: (String text) {
                  taskname = text;
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: const Text(
                    'オンライン',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Checkbox(
                    focusColor: nowselectcolor[0][BarIndex],
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          isChecked
              ? Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: const Text(
                            'グループを選択してください',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        no_group
                            ? Container(
                                child: const Text(
                                  'グループがありません',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : DropdownButton<String>(
                                value: groupValue,
                                underline: Container(
                                  height: 2,
                                  color: nowselectcolor[0][BarIndex],
                                ),
                                //dropdownColor: Colors.blue,
                                items: Group_Id.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Flexible(
                                      child: Text(
                                        Group_explain[value]!['group_name'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (!no_group) {
                                      groupValue = newValue!;
                                    }
                                  });
                                },
                              ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'タグを選択してください',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                DropdownButton<String>(
                  value: tagvalue,
                  underline: Container(
                    height: 2,
                    color: nowselectcolor[0][BarIndex],
                  ),
                  items: tag.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      tagvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                IconButton(
                  onPressed: () {
                    if (taskname != '') {
                      bool isOnline = Group_Id.isNotEmpty ? isChecked : false;

                      set_data_map({
                        'task_name': taskname,
                        'tag': tagvalue,
                        'is_online': isOnline,
                        'online_group_id': groupValue,
                      }).set_data_add();
                      print('hello');
                      set_data();
                      print('hello');
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.send, color: nowselectcolor[0][BarIndex]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
