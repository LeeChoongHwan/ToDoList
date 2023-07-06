import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'memo_service.dart';
import 'package:provider/provider.dart';
import 'create_todo_page.dart';
=======
import 'package:provider/provider.dart';
import 'memo_service.dart';
import 'create_todo_page.dart';
import 'appColors.dart';
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

<<<<<<< HEAD
=======
//Todo 리스트 페이지
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;
<<<<<<< HEAD

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            title: const Text(
              "Todo",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
=======
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.applicationMainColor,
            title: const Text(
              "Todo",
              style: TextStyle(color: AppColors.appBarTextColor),
            ),
            actions: [
              //Todo 추가 버튼
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
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
<<<<<<< HEAD
                            icon: Icon(memo.isPinned
=======
                            icon: Icon(memo.isChecked
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                          ),
                          title: Text(
                            memo.content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
<<<<<<< HEAD
                                color:
                                    memo.isPinned ? Colors.grey : Colors.black,
                                decoration: memo.isPinned
=======
                                color: memo.isChecked
                                    ? AppColors.checkedTextColor
                                    : AppColors.uncheckedTextColor,
                                decoration: memo.isChecked
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          trailing: IconButton(
                              onPressed: () {
<<<<<<< HEAD
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
=======
                                showDeleteDialog(context, memoService, index);
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
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
<<<<<<< HEAD
                          color: Colors.black,
=======
                          color: AppColors.divider,
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
                        )
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
<<<<<<< HEAD
=======

  //삭제시 Dialog 생성
  Future<dynamic> showDeleteDialog(
      BuildContext context, MemoService memoService, int index) {
    return showDialog(
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
                memoService.deleteMemo(index: index);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: AppColors.dialogConfirmButtonColor),
              ),
            ),
          ],
        );
      },
    );
  }
>>>>>>> 379b281f14624129610b5cfb2ea730da52cbc59d
}
