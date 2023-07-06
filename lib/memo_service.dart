import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
  Memo({required this.content, required this.content2, this.isPinned = false});

  String content;
  String content2;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'content2': content2,
      'isPinned': isPinned,
    };
  }

  bool isPinned;

  Memo.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        content2 = json['content2'],
        isPinned = json['isPinned'] ?? false;
}

class MemoService with ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

  updatePinMemo({required int index}) {
    Memo memo = memoList[index];
    memo.isPinned = !memo.isPinned;
    memoList = [
      ...memoList.where((element) => !element.isPinned),
      ...memoList.where((element) => element.isPinned)
    ];
    notifyListeners();
    saveMemoList();
  }

  Future<void> createMemo({required String content}) async {
    Memo memo = Memo(content: content, content2: '');
    memoList.add(memo);
    notifyListeners();
    await saveMemoList();
  }

  Future<void> updateMemo(
      {required int index,
      required String content,
      required String content2}) async {
    Memo memo = memoList[index];
    memo.content = content;
    memo.content2 = content2;
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
}
