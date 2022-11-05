import 'dart:math';

import 'package:uuid/uuid.dart';

Map<String, Map<String, dynamic>> data_list = {
  //{'tag': 'important', 'task_name': 'world', 'is_online': false,'id':id_L5},
  //{'tag': 'can5', 'task_name': 'world', 'is_online': false,'id':id_L5},
  //{'tag': 'unimportant', 'task_name': 'world', 'is_online': false,'id':id_L5},
};
MakeId id_5 = MakeId(5);

//データの追加
class set_data_map {
  //
  //必要なもの
  var uuid = const Uuid();
  List<String> sub_task = [];
  List<String> finish_sub_task = [];
  String detail = '';
  String tag = 'unimportant'; //タグ
  String task_name = ''; //タスクの名前
  bool is_online = false; //オンラインか
  String? online_group_id; //オンラインの時のグループid
  bool is_finish = false;
  //必要なもの終了
  //
  //MapのStirng = id;
  Map<String, Map<String, dynamic>> this_set = {};
  //
  //必要なものをmap型に
  set_data_map(Map<String, dynamic> this_data) {
    tag = this_data['tag'];
    task_name = this_data['task_name'];
    is_online = this_data['is_online'];
    // ignore: non_constant_identifier_names
    String? online_group_id = is_online ? this_data['online_group_id'] : null;
    // ignore: non_constant_identifier_names
    final String id_L5 =
        is_online ? uuid.v4() : id_5.make_all(); //id_length 5 の略
    this_set = {
      id_L5: {
        'sub_task': sub_task,
        'finish_sub_task': finish_sub_task,
        'detail': detail,
        'is_finish': is_finish,
        'task_name': task_name,
        'tag': tag,
        'is_online': is_online,
        'online_group_id': online_group_id,
        'id_L5': id_L5,
      }
    };
  }
  //
  //data_listに追加
  void set_data_add() {
    data_list.addAll(this_set);
    /*
    set_task_data_map({
      'task_name': task_name,
      'id': this_set['id_L5'],
      'is_online': is_online,
      'tag': tag,
      'detail': '',
    }).set_data_add();
    */
  }
}

List<String> data_list_tag_important = [];
List<String> data_list_tag_can5 = [];
List<String> data_list_tag_unimportant = [];
//
List<String> data_list_tag_important_finish = [];
List<String> data_list_tag_can5_finish = [];
List<String> data_list_tag_unimportant_finish = [];

void set_data() {
  print('set');
  //Important_tag start;
  Map<String, Map<String, dynamic>> newMapImportant = {};

  //bool
  newMapImportant.addEntries(
    data_list.entries.where(
      (element) {
        if (element.value['tag'] == 'important') {
          bool notHave = true;
          for (int i = 0; i < data_list_tag_important.length; i++) {
            if (element.key == data_list_tag_important[i]) {
              notHave = false;
            }
          }
          if (notHave) {
            data_list_tag_important.add(element.key);
          }
        }
        return (element.value['tag'] == 'important');
      },
    ),
  );
  for (int i = 0; i < data_list_tag_important.length; i++) {
    if (i < 0) {
      i = 0;
    }
    bool have = newMapImportant.containsKey(data_list_tag_important[i]);
    if (!have) {
      data_list_tag_important.remove(data_list_tag_important[i]);
      i--;
    }
  }
  //Important_tag end;

  //can5_tag start;
  Map<String, Map<String, dynamic>> newMapCan5 = {};

  //bool
  newMapCan5.addEntries(
    data_list.entries.where(
      (element) {
        if (element.value['tag'] == 'can5') {
          bool notHave = true;
          for (int i = 0; i < data_list_tag_can5.length; i++) {
            if (element.key == data_list_tag_can5[i]) {
              notHave = false;
            }
          }
          if (notHave) {
            data_list_tag_can5.add(element.key);
          }
        }
        return (element.value['tag'] == 'can5');
      },
    ),
  );
  for (int i = 0; i < data_list_tag_can5.length; i++) {
    if (i < 0) {
      i = 0;
    }
    bool have = newMapCan5.containsKey(data_list_tag_can5[i]);
    if (!have) {
      data_list_tag_can5.remove(data_list_tag_can5[i]);
      i--;
    }
  }
  //can5_tag end;

  //unimportant_tag start;
  Map<String, Map<String, dynamic>> newMapUnimportant = {};

  //bool
  newMapUnimportant.addEntries(
    data_list.entries.where(
      (element) {
        if (element.value['tag'] == 'unimportant') {
          bool notHave = true;
          for (int i = 0; i < data_list_tag_unimportant.length; i++) {
            if (element.key == data_list_tag_unimportant[i]) {
              notHave = false;
            }
          }
          if (notHave) {
            data_list_tag_unimportant.add(element.key);
          }
        }
        return (element.value['tag'] == 'unimportant');
      },
    ),
  );
  for (int i = 0; i < data_list_tag_unimportant.length; i++) {
    if (i < 0) {
      i = 0;
    }
    bool have = newMapUnimportant.containsKey(data_list_tag_unimportant[i]);
    if (!have) {
      data_list_tag_unimportant.remove(data_list_tag_unimportant[i]);
      i--;
    }
  }
  //unimportant_tag end;
}
//
//

List return_listView(String thisTag) {
  if (thisTag == 'important') {
    print(data_list_tag_important);
    return data_list_tag_important;
  } else if (thisTag == 'can5') {
    print(data_list_tag_can5);
    return data_list_tag_can5;
  } else {
    print(data_list_tag_unimportant);
    return data_list_tag_unimportant;
  }
}

//
//
//重複しないランダムな文字列を作る
class MakeId {
  List<String> id_list = []; //idの入っているとこ
  late final id_length; // id の長さ
  MakeId(int id_length) {
    this.id_length = id_length;
  }

  //下の二つをまとめてやるやつ
  String make_all() {
    return add_id(make_id());
  }

  //ランダムな文字列を作る
  String make_id() {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz';
    final Random random = Random.secure();
    final String randomStr =
        List.generate(id_length, (_) => charset[random.nextInt(charset.length)])
            .join();
    return randomStr;
  }

  //その文字列が重複しているかの確認
  String add_id(String newId) {
    id_list.add(newId);
    for (int j = 0; j < id_list.length - 2; j++) {
      while (newId == id_list[j]) {
        print('erro');
        id_list.removeLast();
        newId = make_id();
        id_list.add(newId);
      }
    }
    return newId;
  }
}


/*

void main(){
  number.forEach((int key, String value) => list.add(value));
  print(list);
  final list_2 = number.entries.map((e) => e.value).toList();
  print(list_2);
}

var number = <int, String>{1: "one", 2: "two", 3: "three"};

final list = [];

 */


/*


void main() {
  List list = number.entries.map((e) => e.value).toList();
  list.shuffle();
  List llist = [0, 1, 2];
  print(list.firstWhere((element) {
    //(element);//while
    return element['id'] == '00';
  })['id']);
}

var number = <int, Map<String, String>>{
  1: {'id': '00', 'name': '00hello'},
  2: {'id': '11', 'name': '11good'},
  3: {'id': '22', 'name': '22world'}
};

final list = [];


*/