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

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
              ? const Center(child: Text("메모를 작성해 주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.check_box_outline_blank)),
                          title: Text(
                            memo.content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SubPage(
                                  index: index,
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
