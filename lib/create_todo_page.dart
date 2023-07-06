<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';

//color , text 파일 별도로 정리
=======
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';
import 'appColors.dart';
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d

// ignore: must_be_immutable
class CreateTodoPage extends StatelessWidget {
  CreateTodoPage({Key? key, required this.index, required this.isModify})
      : super(key: key);
  final int index;
  final bool isModify;

  TextEditingController contentController = TextEditingController();
<<<<<<< HEAD
=======

>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
  late String textValue;

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
=======

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.applicationMainColor,
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
        actions: [
          TextButton(
              onPressed: () {
                memoService.updateMemo(index: index, content: textValue);
                Navigator.pop(context);
              },
              child: Text(
                isModify ? "수정" : "저장",
<<<<<<< HEAD
                style: TextStyle(color: Colors.white),
=======
                style: TextStyle(color: AppColors.appBarTextColor),
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: TextField(
<<<<<<< HEAD
          controller: contentController,
          decoration: const InputDecoration(
            hintText: "메모를 입력하세요",
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xffD9D9D9),
          ),
          autofocus: true,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            textValue = value;
          },
        ),
=======
            controller: contentController,
            decoration: const InputDecoration(
                hintText: "내용을 입력하세요",
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.textFieldColor),
            autofocus: true,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              textValue = value;
            }),
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
      ),
    );
  }
}
