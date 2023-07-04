import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

//MainPage
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> memoList = ['장보기 목록 : 사과, 양파', 'New Memo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "Todo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: memoList.isEmpty
          ? Center(child: Text("메모를 작성해 주세요"))
          : ListView.builder(
              itemCount: memoList.length,
              itemBuilder: (context, index) {
                String memo = memoList[index];
                return ListTile(
                  title: Text(
                    memo,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SubPage(
                                index: index,
                                memoList: memoList,
                              )),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          String memo = "";
          setState(() {
            memoList.add(memo);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SubPage(
                      index: memoList.indexOf(memo),
                      memoList: memoList,
                    )),
          );
        },
      ),
    );
  }
}

//상세 작성 페이지
// ignore: must_be_immutable
class SubPage extends StatelessWidget {
  SubPage({super.key, required this.memoList, required this.index});

  final List<String> memoList;
  final int index;

  TextEditingController contentController = TextEditingController();

  @override
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
                          memoList.removeAt(index); // index에 해당하는 항목 삭제
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
            }),
      ),
    );
  }
}
