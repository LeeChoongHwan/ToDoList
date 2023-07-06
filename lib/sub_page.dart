import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';

//color , text 파일 별도로 정리

// ignore: must_be_immutable
class SubPage extends StatelessWidget {
  SubPage({Key? key, required this.index, required this.isModify})
      : super(key: key);
  final int index;
  final bool isModify;

  TextEditingController contentController = TextEditingController();
  TextEditingController contentController2 = TextEditingController(); // 추가
  late String textValue;
  late String textValue2; // 추가: 두 번째 TextField 값을 저장할 변수

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();

    contentController.text = memoService.memoList[index].content;
    contentController2.text =
        memoService.memoList[index].content2; // 수정: 두 번째 TextField의 초기 값을 설정

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: [
          TextButton(
            onPressed: () {
              memoService.updateMemo(
                index: index,
                content: textValue,
                content2: textValue2, // 수정: 두 번째 TextField의 값을 전달
              );
              Navigator.pop(context, index);
            },
            child: Text(
              isModify ? "수정" : "저장",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 32,
                left: 32,
                right: 32,
                top: 32,
              ),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: "제목을 입력하세요",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffD9D9D9),
                ),
                autofocus: true,
                maxLines: 2,
                expands: false,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  textValue = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 32,
                left: 32,
                right: 32,
                top: 32,
              ),
              child: TextField(
                controller: contentController2,
                decoration: const InputDecoration(
                  hintText: "메모를 입력하세요",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffD9D9D9),
                ),
                maxLines: null,
                expands: false,
                onChanged: (value) {
                  textValue2 = value; // 수정: 두 번째 TextField의 값을 저장
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
