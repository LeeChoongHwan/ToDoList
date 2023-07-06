import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
  Memo({required this.title, this.isChecked = false, required this.content});

  String title;
  bool isChecked;
  String content;

  Map<String, dynamic> toJson() {
    return {'title': title, 'isPinned': isChecked, 'content': content};
  }

  Memo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        isChecked = json['isPinned'] ?? false,
        content = json['content'];
}

class MemoService with ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

  Future<void> createMemo(
      {required String content, required String title}) async {
    Memo memo = Memo(title: title, content: content);
    memoList.add(memo);
    notifyListeners();
    await saveMemoList();
  }

  Future<void> updateMemo(
      {required int index,
      required String content,
      required String title}) async {
    Memo memo = memoList[index];
    memo.title = title;
    memo.content = content;
    notifyListeners();
    await saveMemoList();
  }

  Future<void> deleteMemo({required int index}) async {
    memoList.removeAt(index);
    notifyListeners();
    await saveMemoList();
  }

  Future<void> saveMemoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> memoJsonList =
        memoList.map((memo) => memo.toJson()).toList();
    String jsonString = jsonEncode(memoJsonList);
    await prefs.setString('memoList', jsonString);
  }

  Future<void> loadMemoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('memoList');
    if (jsonString == null) return;
    List<dynamic> memoJsonList = jsonDecode(jsonString);
    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
    notifyListeners();
  }

  updatePinMemo({required int index}) {
    Memo memo = memoList[index];
    memo.isChecked = !memo.isChecked;
    // memoList = [
    //   ...memoList.where((element) => !element.isChecked),
    //   ...memoList.where((element) => element.isChecked)
    // ];
    notifyListeners();
    saveMemoList();
  }
}
