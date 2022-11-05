import 'package:flutter/material.dart';
import 'package:to_do_share/AddList/add_list.dart';
import 'package:to_do_share/Data_List/list_data.dart';
import 'package:to_do_share/Task/add_task.dart';

import 'home.dart';

List<String> tag = [
  'important',
  'can5',
  'unimportant',
];

class List_Body extends StatefulWidget {
  const List_Body({Key? key, required this.BarIndex}) : super(key: key);
  final int BarIndex;

  @override
  State<List_Body> createState() => _List_BodyState();
}

class _List_BodyState extends State<List_Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: return_listView(tag[widget.BarIndex]).isNotEmpty
          ? ReorderableListView.builder(
              buildDefaultDragHandles: false,
              itemBuilder: (BuildContext context, int index) {
                //print(data_list[index]['set_num']);
                return ListTile(
                  key: Key('$index'),
                  title: ReorderableDragStartListener(
                    index: index,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: nowselectcolor[0][widget.BarIndex],
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Flexible(
                              child: Text(
                                data_list[return_listView(
                                    tag[widget.BarIndex])[index]]!['task_name'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Task_Select(
                            idkey:
                                return_listView(tag[widget.BarIndex])[index]),
                      ),
                    );
                  },
                );
              },
              itemCount: return_listView(tag[widget.BarIndex]).length,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Item =
                      return_listView(tag[widget.BarIndex]).removeAt(oldIndex);
                  return_listView(tag[widget.BarIndex]).insert(newIndex, Item);
                  //print(return_listView(tag[widget.BarIndex]));
                });
              },
            )
          : Center(
              child: Text(
                'No items ${widget.BarIndex}',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  backgroundColor: nowselectcolor[0][widget.BarIndex],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: nowselectcolor[0][widget.BarIndex],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add_List(first_BarIndex: widget.BarIndex),
            ),
          ).then((value) {
            // 再描画
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
