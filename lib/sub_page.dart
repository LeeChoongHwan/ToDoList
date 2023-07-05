import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_service.dart';

class SubPage extends StatefulWidget {
  SubPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  TextEditingController contentController = TextEditingController();
  bool isContentModified = false;

  @override
  void initState() {
    super.initState();
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[widget.index];
    contentController.text = memo.content;
  }

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();

<<<<<<< HEAD
    return WillPopScope(
      onWillPop: () async {
        if (isContentModified) {
          String newContent = contentController.text.trim();
          if (newContent.isEmpty) {
            // 데이터가 수정되었고, 입력한 값이 비어있는 경우
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("메모를 입력하지 않았습니다"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        memoService.deleteMemo(index: widget.index);
                        Navigator.pop(context); // 팝업 닫기
                        Navigator.pop(context); // HomePage 로 가기
                      },
                      child: const Text("확인"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("취소"),
                    ),
                  ],
                );
              },
            );
            return false; // 뒤로가기 방지
          }
          memoService.updateMemo(index: widget.index, content: newContent);
        }
        return true; // 정상적으로 뒤로가기
      },
      child: Scaffold(
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
=======
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
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "확인",
                          style: TextStyle(color: Colors.pink),
>>>>>>> f415f19ef97148746fc0986e3a0230eb2c6f8262
                        ),
                        TextButton(
                          onPressed: () {
                            memoService.deleteMemo(index: widget.index);
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
              setState(() {
                isContentModified = true;
              });
            },
          ),
        ),
      ),
    );
  }
}
