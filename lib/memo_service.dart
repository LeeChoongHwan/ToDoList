import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Memo {
<<<<<<< HEAD
  Memo({
    required this.content,
    this.isPinned = false,
  });

  String content;
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isPinned': isPinned,
=======
  Memo({required this.content, this.isChecked = false});

  String content;
  bool isChecked;

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isPinned': isChecked,
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
    };
  }

  Memo.fromJson(Map<String, dynamic> json)
      : content = json['content'],
<<<<<<< HEAD
        isPinned = json['isPinned'] ?? false;
=======
        isChecked = json['isPinned'] ?? false;
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
}

class MemoService with ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [];

<<<<<<< HEAD
  updatePinMemo({required int index}) {
    Memo memo = memoList[index];
    memo.isPinned = !memo.isPinned;
    // memoList = [
    //   ...memoList.where((element) => element.isPinned),
    //   ...memoList.where((element) => !element.isPinned)
    // ];

    //리스트에 내리게 수정
    notifyListeners();
    saveMemoList();
  }

  Future<void> createMemo({required String content}) async {
    // 추가함memoContent
=======
  Future<void> createMemo({required String content}) async {
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
    Memo memo = Memo(content: content);
    memoList.add(memo);
    notifyListeners();
    await saveMemoList();
  }

<<<<<<< HEAD
  Future<void> updateMemo({
    required int index,
    required String content,
  }) async {
=======
  Future<void> updateMemo({required int index, required String content}) async {
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
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

  updatePinMemo({required int index}) {
    Memo memo = memoList[index];
    memo.isChecked = !memo.isChecked;
    memoList = [
      ...memoList.where((element) => !element.isChecked),
      ...memoList.where((element) => element.isChecked)
    ];
    notifyListeners();
    saveMemoList();
  }
}
