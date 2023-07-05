import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';

//color , text 파일 별도로 정리

class SubPage extends StatelessWidget {
  SubPage({Key? key, required this.index}) : super(key: key);
  final int index;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;
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
                    title: const Text("정말로 삭제하시겠습니까?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("취소"),
                      ),
                      TextButton(
                        onPressed: () {
                          memoService.deleteMemo(index: index);
                          Navigator.pop(context); // 팝업 닫기
                          Navigator.pop(context); // HomePage 로 가기
                        },
                        child: const Text(
                          "확인",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
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
            memoService.updateMemo(index: index, content: value);
          },
        ),
      ),
    );
  }
}
