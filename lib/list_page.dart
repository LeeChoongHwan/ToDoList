import 'package:flutter/material.dart';
import 'memo_service.dart';
import 'package:provider/provider.dart';
import 'create_todo_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
                        builder: (_) => CreateTodoPage(
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
                            maxLines: 3,
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
                                builder: (_) => CreateTodoPage(
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
