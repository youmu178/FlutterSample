import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "我的",
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new MinePageDataWidget(
        title: '我的',
      ),
    );
  }
}

class MinePageDataWidget extends StatefulWidget {
  final String title;

  MinePageDataWidget({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MineState();
  }
}

class _MineState extends State<MinePageDataWidget> {
  List subjects = [];
  String title = '';

  @override
  void initState() {
    super.initState();
    loadData();
    print("---------------initState");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("--------------deactive");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("------------reassemble");
  }

  @override
  void dispose() {
    super.dispose();
    print("------------dispose");
  }

  @override
  void didUpdateWidget(MinePageDataWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("------------didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("------------didChangeDependencies");
  }

  Widget _buildData() {
    return new ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        return _buildRow();
      },
    );
  }

  Widget _buildRow() {
    return new ListTile(
      title: new Text("Hello World"),
    );
  }

  loadData() async {
    String loadRUL = "https://api.douban.com/v2/movie/in_theaters";
    Dio dio = new Dio();
    Response response = await dio.get(loadRUL);
    var result = response.data;
    print(result);
    setState(() {
      title = result['title'];
      print('title: $title');
      subjects = result['subjects'];
      print(subjects);
    });
  }

  Widget getList() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      return CupertinoActivityIndicator();
    }
  }

  Widget getItem(var subject) {
//    演员列表
    var avatars = List.generate(
      subject['casts'].length,
      (int index) => Container(
            margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
            child: CircleAvatar(
                backgroundColor: Colors.white10,
                backgroundImage:
                    NetworkImage(subject['casts'][index]['avatars']['small'])),
          ),
    );
    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0,
              height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                    电影名称
                Text(
                  subject['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  maxLines: 1,
                ),
//                    豆瓣评分
                Text(
                  '豆瓣评分：${subject['rating']['average']}',
                  style: TextStyle(fontSize: 16.0),
                ),
//                    类型
                Text("类型：${subject['genres'].join("、")}"),
//                    导演
                Text('导演：${subject['directors'][0]['name']}'),
//                    演员
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text('主演：'),
                      Row(
                        children: avatars,
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
    return Card(
      child: row,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // top: true,
      // appBar: new AppBar(
      //   title: new Text("我的"),
      // ),
      body: new Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // new IconButton(
                    //   iconSize: 10.0,
                    //   icon: new Image.asset("images/ic_mine_set.png"),
                    //   onPressed: () {
                    //     print("设置");
                    //   },
                    // ),
                    new Listener(
                      child: new Container(
                        width: 24.0,
                        height: 24.0,
                        margin: const EdgeInsets.only(right: 7.0),
                        child: Image(
                          image: AssetImage("images/ic_mine_set.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      onPointerDown: (event) => print("设置"),
                    ),
                  ],
                ),
                new Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                  child: new Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      new Image.asset("images/bg_mine_head.png"),
                      new Positioned(
                        left: 20.0,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "889",
                              style: new TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF241F18),
                              ),
                            ),
                            new Text(
                              "已获取小红花奖励",
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: const Color(0xFFA57C00),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Positioned(
                          right: 0,
                          top: 20,
                          child: new Stack(
                            children: <Widget>[
                              new ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(16.0),
                                      bottomLeft: const Radius.circular(16.0)),
                                  child: new Container(
                                    color: const Color(0xFFEC6434),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 6),
                                    child: new Row(
                                      children: <Widget>[
                                        new Text(
                                          "小红花攻略",
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
                new Container(
                  padding:
                      const EdgeInsets.only(left: 75.0, top: 25, right: 75.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          color: const Color(0xFFC8C8C8),
                          height: 1.0,
                        ),
                      ),
                      new Text(
                        "赚小红花 换成长礼",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: const Color(0xFF484848),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          color: const Color(0xFFC8C8C8),
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                new Expanded(
                  child: new Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: new Center(
                      child: getList(),
                    ),
                  ),
                )
                // new Container(
                //   margin: const EdgeInsets.fromLTRB(0, 15.0, 15, 0),
                //   child: new HeadInnerSquareBox(
                //     child: new Container(
                //       padding:
                //           const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 12.0),
                //       width: double.infinity,
                //       child: new Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           new Text(
                //             "Unit 1 Lesson 3 About animal",
                //             style: new TextStyle(
                //               fontSize: 20.0,
                //               fontFamily: "Round",
                //               color: Colors.black,
                //             ),
                //           ),
                //           new Container(
                //             margin:
                //                 const EdgeInsets.only(top: 5.0, bottom: 13.0),
                //             child: new Image.asset(
                //                 "assets/images/publish_work_line.png"),
                //           ),
                //           new Wrap(
                //             alignment: WrapAlignment.start,
                //             children: <Widget>[
                //               new WorkTotalItem(
                //                 title: "课文跟读 12",
                //               ),
                //               new WorkTotalItem(
                //                 title: "课文跟读 12",
                //               ),
                //               new WorkTotalItem(
                //                 title: "课文跟读 12",
                //               ),
                //               new WorkTotalItem(
                //                 title: "课文跟读 12",
                //               ),
                //             ],
                //           ),
                //           new Container(
                //             margin: const EdgeInsets.only(left: 178.0),
                //             child: new Stack(
                //               children: <Widget>[
                //                 new Image.asset(
                //                     "assets/images/publish_work_sign.png"),
                //                 new Positioned(
                //                   left: 4.0,
                //                   top: 4.0,
                //                   child: new Text(
                //                     "预习",
                //                     style: new TextStyle(
                //                         fontSize: 14.0, color: Colors.white),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //           new Container(
                //             alignment: Alignment.topRight,
                //             child: new Text(
                //               "明天12:00截止",
                //               style: new TextStyle(
                //                   fontSize: 12.0,
                //                   color: const Color(0xFFFFC1C1)),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}

class HeadInnerSquareBox extends StatelessWidget {
  static const double gap = 12.0;

  HeadInnerSquareBox({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: const BorderRadius.all(const Radius.circular(16.0)),
      child: new Container(
        color: const Color(0xFFF0D5A9),
        padding: const EdgeInsets.all(gap),
        child: new Container(
          child: new Container(
            color: const Color(0xFF3C594E),
            child: child,
          ),
        ),
      ),
    );
  }
}

class WorkTotalItem extends StatelessWidget {
  WorkTotalItem({
    this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(6.0),
      child: new Text(
        "$title",
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          // decoration: TextDecoration.none
        ),
      ),
    );
  }
}
