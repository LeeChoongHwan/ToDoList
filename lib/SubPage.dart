import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SubPage extends StatelessWidget {
  SubPage({super.key, required this.memoList, required this.index});

  final List<String> memoList;
  final int index;
  TextEditingController contentController = TextEditingController();

  @override
  void savememoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('memoList', memoList);
  }

  Widget build(BuildContext context) {
    contentController.text = memoList[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("정말로 삭제하시겠습니까?"),
                    actions: [
                      // 취소 버튼
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("취소"),
                      ),
                      // 확인 버튼
                      TextButton(
                        onPressed: () {
                          memoList.removeAt(index);
                          // index에 해당하는 항목 삭제

                          savememoList();
                          Navigator.pop(context); // 팝업 닫기
                          Navigator.pop(context); // HomePage 로 가기
                        },
                        child: Text(
                          "확인",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: TextField(
            controller: contentController,
            decoration: InputDecoration(
              hintText: "메모를 입력하세요",
              border: InputBorder.none,
            ),
            autofocus: true,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              memoList[index] = value;
              savememoList();
            }),
      ),
    );
  }
}

//상세 작성 페이지
// ignore: must_be_immutable