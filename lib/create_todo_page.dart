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

  TextEditingController contentController = TextEditingController();
  late String textValue;

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.applicationMainColor,
        actions: [
          TextButton(
              onPressed: () {
                memoService.updateMemo(index: index, content: textValue);
                Navigator.pop(context);
              },
              child: Text(
                isModify ? "수정" : "저장",
                style: TextStyle(color: AppColors.appBarTextColor),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
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
              textValue = value;
            }),
      ),
    );
  }
}
