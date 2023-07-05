import 'dart:convert';

import 'package:flutter/material.dart';

import 'main.dart';

import 'package:flutter/material.dart';

class Memo {
  Memo({
    required this.content,
  });

  String content;

  Map toJson() {
    return {'content': content};
  }

  factory Memo.fromJson(json) {
    return Memo(content: json['content']);
  }
}

class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }
  List<Memo> memoList = [
    Memo(content: '장보기 목록: 사과, 양파'),
    Memo(content: '새 메모'),
  ];

  createMemo({required String content}) {
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
    saveMemoList();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  saveMemoList() {
    List memoJsonList = memoList.map((memo) => memo.toJson()).toList();

    String jsonString = jsonEncode(memoJsonList);

    prefs.setString('memoList', jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');

    if (jsonString == null) return;

    List memoJsonList = jsonDecode(jsonString);

    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }
}
