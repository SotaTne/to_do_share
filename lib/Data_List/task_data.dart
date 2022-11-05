// ignore: non_constant_identifier_names
Map<String, Map<String, dynamic>> task_Map = {
  //タスクマップの入っている場所
  //id:{...},
};

class set_task_data_map {
  String task_name = '';
  bool is_online = false;
  Map<String, Map<String, dynamic>> this_set = {};
  set_task_data_map(Map<String, dynamic> this_data) {
    task_name = this_data['task_name']; //タスクの名前
    final String id = this_data['id']; //id
    is_online = this_data['is_online']; //オンラインか
    String tag = this_data['tag']; //三つのうちどれか
    String detail = this_data['detail']; //詳細
    this_set = {
      id: {
        'task_name': task_name,
        'id': id,
        'is_online': is_online,
        'tag': tag,
        'detail': detail,
      }
    };
  }
  void set_data_add() {
    task_Map.addAll(this_set); //task_Mapに追加
  }
}
