import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
  Memo({
    required this.content,
  });

  String content;

  Map<String, dynamic> toJson() {
    return {'content': content};
  }

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(content: json['content']);
  }
}

class MemoService with ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

  Future<void> createMemo({required String content}) async {
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
    await saveMemoList();
  }

  Future<void> updateMemo({required int index, required String content}) async {
    Memo memo = memoList[index];
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
}