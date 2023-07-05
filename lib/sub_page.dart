import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SubPage extends StatefulWidget {
  SubPage({super.key, required this.memoList, required this.index});

  final List<String> memoList;
  final int index;

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  TextEditingController contentController = TextEditingController();

  Widget build(BuildContext context) {
    contentController.text = widget.memoList[widget.index];

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
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("취소"),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.memoList.removeAt(widget.index);
                          savememoList();
                          Navigator.pop(context); 
                          Navigator.pop(context); 
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
              widget.memoList[widget.index] = value;
              savememoList();
            }),
      ),
    );
  }

  void savememoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('memoList', widget.memoList);
  }
}
