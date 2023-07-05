import 'dart:convert';

import 'package:flutter/material.dart';

import 'main.dart';

import 'package:flutter/material.dart';

import 'main.dart';

class Memo {
  Memo({
    required this.content,
  });

  String content;
}

class MemoService extends ChangeNotifier {
  List<Memo> memoList = [
    Memo(content: '장보기 목록: 사과, 양파'),
    Memo(content: '새 메모'),
  ];

  createMemo({required String content}) {
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    notifyListeners();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
  }
}
