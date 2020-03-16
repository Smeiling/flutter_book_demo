import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovebooks/api/Api.dart';
import 'package:lovebooks/api/NetUtils.dart';

class BookList extends StatefulWidget {
  final String bookType;

  BookList({Key key, this.bookType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewListState(bookType);
  }
}

class _NewListState extends State<BookList> with AutomaticKeepAliveClientMixin {
  List listData = new List();
  var curPage = 0;
  var pageSize = 20;
  var listTotalSize = 0;
  bool isRun = false;
  ScrollController controller = new ScrollController();
  String bookType;

  @override
  bool get wantKeepAlive => true;

  _NewListState(String bookType) {
    this.bookType = bookType;
    controller.addListener(() {
      var maxScroll = controller.position.maxScrollExtent;
      var pixels = controller.position.pixels;

      if (!isRun && pixels == maxScroll && (listData.length < listTotalSize)) {
        isRun = true;
        curPage += pageSize;
        getBookList(true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // 首次初始化
    if (listData.length > 0) {
    } else {
      getBookList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (listData.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new RefreshIndicator(
          child: createGridView(context), onRefresh: pullToRefresh);
    }
    return super.build(context);
  }

  Future<Null> pullToRefresh() async {
    curPage = 1;
    getBookList(false);
    return null;
  }

  void getBookList(bool isLoadMore) {
    String url = bookType;
    url += '?' + Api.API_KEY + '&start=$curPage&count=$pageSize';
    print(url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        isRun = false;
        listTotalSize = map['total'];
        var tempData = map['subjects'];
        setState(() {
          if (tempData != null) {
            if (!isLoadMore) {
              listData.clear();
              listData = tempData;
            } else {
              listData.addAll(tempData);
              if (listData.length == listTotalSize) {}
            }
          }
        });
      }
    });
  }

  Widget createGridView(BuildContext context) {
    var lg = listData.length;
    print(lg);
    return Container(
      padding: EdgeInsets.all(8.0),
      child: new GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          controller: controller,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              crossAxisCount: 3),
          itemCount: listData.length,
          itemBuilder: (context, i) {
            return bookRow(i);
          }),
    );
  }

  Widget bookRow(i) {
    var itemData = listData[i];
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 8.0,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Hero(
                    tag: itemData['images']['small'],
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(itemData['images']['small']),
                      placeholder: AssetImage("images/placeholder.jpg"),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                itemData['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
