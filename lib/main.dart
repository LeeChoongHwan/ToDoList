import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'memo_service.dart';
import 'sub_page.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemoService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            title: const Text(
              "Todo",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    memoService.createMemo(content: '');
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubPage(
                          index: memoService.memoList.length - 1,
                          isModify: false,
                        ),
                      ),
                    );
                    if (memoList[memoService.memoList.length - 1]
                        .content
                        .isEmpty) {
                      memoService.deleteMemo(index: memoList.length - 1);
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: memoList.isEmpty
              ? const Center(child: Text(""))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                            onPressed: () {
                              memoService.updatePinMemo(index: index);
                            },
                            icon: Icon(memo.isPinned
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                          ),
                          title: Text(
                            memo.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:
                                    memo.isPinned ? Colors.grey : Colors.black,
                                decoration: memo.isPinned
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          trailing: IconButton(
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
                                            Navigator.pop(context);
                                            memoService.deleteMemo(
                                                index: index);
                                          },
                                          child: const Text(
                                            "확인",
                                            style:
                                                TextStyle(color: Colors.pink),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.delete)),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SubPage(
                                  index: index,
                                  isModify: true,
                                ),
                              ),
                            );
                            if (memo.content.isEmpty) {
                              memoService.deleteMemo(index: index);
                            }
                          },
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        )
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}
