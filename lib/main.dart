import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sub_page.dart';

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
  bool a = true;
  @override
  void initState() {
    super.initState();
    lodememoList();
  }

  void lodememoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? loadedMemoList = prefs.getStringList('memoList');
    if (loadedMemoList != null) {
      setState(() {
        memoList = loadedMemoList;
      });
    }
  }

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
