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
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SubPage(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                          )
                        ],
                      );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Icon(Icons.add),
                onPressed: () {
                  memoService.createMemo(content: '');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SubPage(
                              index: memoService.memoList.length - 1,
                            )),
                  );
                }));
      },
    );
  }
}
