import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
<<<<<<< HEAD
  Memo({
    required this.content,
    required this.content2,
    this.isPinned = false,
  });

  String content;
  String content2; // 2번째 TextField 값을 저장할 변수 추가
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'content2': content2, // 2번째 TextField 값을 JSON에 추가
=======
  Memo({required this.content, required this.content2, this.isPinned = false});

  String content;
  String content2;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'content2': content2,
>>>>>>> 09ac709dadfcad42f73d97467d9dec9d379ef9a6
      'isPinned': isPinned,
    };
  }

  bool isPinned;

  Memo.fromJson(Map<String, dynamic> json)
      : content = json['content'],
<<<<<<< HEAD
        content2 = json['content2'], // JSON에서 2번째 TextField 값을 가져와 변수에 저장
=======
        content2 = json['content2'],
>>>>>>> 09ac709dadfcad42f73d97467d9dec9d379ef9a6
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
<<<<<<< HEAD
=======
    memoList = [
      ...memoList.where((element) => !element.isPinned),
      ...memoList.where((element) => element.isPinned)
    ];
>>>>>>> 09ac709dadfcad42f73d97467d9dec9d379ef9a6
    notifyListeners();
    saveMemoList();
  }

  Future<void> createMemo({required String content}) async {
<<<<<<< HEAD
    Memo memo = Memo(content: content, content2: ''); // 2번째 TextField 값을 초기화
=======
    Memo memo = Memo(content: content, content2: '');
>>>>>>> 09ac709dadfcad42f73d97467d9dec9d379ef9a6
    memoList.add(memo);
    notifyListeners();
    await saveMemoList();
  }

<<<<<<< HEAD
  Future<void> updateMemo({
    required int index,
    required String content,
    required String content2, // 2번째 TextField 값을 인수로 추가
  }) async {
    Memo memo = memoList[index];
    memo.content = content;
    memo.content2 = content2; // 2번째 TextField 값을 업데이트
=======
  Future<void> updateMemo(
      {required int index,
      required String content,
      required String content2}) async {
    Memo memo = memoList[index];
    memo.content = content;
    memo.content2 = content2;
>>>>>>> 09ac709dadfcad42f73d97467d9dec9d379ef9a6
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
