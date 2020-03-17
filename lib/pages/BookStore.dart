import 'package:flutter/material.dart';
import 'package:lovebooks/api/Api.dart';
import 'package:lovebooks/api/NetUtils.dart';
import 'package:lovebooks/models/BookTab.dart';
import 'package:lovebooks/pages/BookList.dart';

class BookStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookStoreState();
  }
}

class _BookStoreState extends State<BookStore>
    with TickerProviderStateMixin {
  TabController tabController;
  List<BookTab> myTabs = new List();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: myTabs.length, vsync: this);
    getTabList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: new TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 2.0,
          controller: tabController,
          tabs: myTabs.map((item) {
            return new Tab(text: item.text);
          }).toList(),
          indicatorColor: Colors.lightBlueAccent,
          isScrollable: true,
        ),
      ),
      body: new TabBarView(
          controller: tabController,
          children: myTabs.map((item) {
            return item.bookList;
          }).toList()),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getTabList() {
//    String url = Api.BOOK_TAB;
//    NetUtils.get(url).then((data) {});
    Map<String, dynamic> map = new Map();
    map['TOP250'] = new BookTab('TOP250', new BookList(bookType: Api.TOP250));
    map['InTheater'] =
        new BookTab('InTheater', new BookList(bookType: Api.IN_THEATER));
    myTabs.add(map['TOP250']);
    myTabs.add(map['InTheater']);
    tabController = new TabController(length: map.length, vsync: this);
    setState(() {});
  }
}
