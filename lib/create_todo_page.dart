import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';
import 'appColors.dart';

// ignore: must_be_immutable
class CreateTodoPage extends StatelessWidget {
  CreateTodoPage({Key? key, required this.index, required this.isModify})
      : super(key: key);
  final int index;
  final bool isModify;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String contentValue = "";
  String titleValue = "";

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    titleController.text = memo.title;
    contentController.text = memo.content;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.applicationMainColor,
        actions: [
          TextButton(
              onPressed: () {
                if (contentValue.isNotEmpty && titleValue.isNotEmpty) {
                  memoService.updateMemo(
                      index: index, content: contentValue, title: titleValue);
                  Navigator.pop(context);
                }
              },
              child: Text(
                isModify ? "수정" : "저장",
                style: TextStyle(color: AppColors.appBarTextColor),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "제목을 입력하세요",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppColors.textFieldColor),
                autofocus: true,
                maxLines: 1,
                expands: false,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  titleValue = value;
                }),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: TextField(
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
                    contentValue = value;
                  }),
            )
          ],
        ),
      ),
    );
  }
}
