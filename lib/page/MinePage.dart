import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:baby/page/FlowerStrategy.dart';

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
    String loadRUL =
        "https://minigrowth.imsupercard.com/mgr/api/v1/goods/goods";
    Dio dio = new Dio();
    Response response = await dio.get(loadRUL);
    var result = response.data;
    print(result);
    setState(() {
      // title = result['title'];
      // print('title: $title');
      subjects = result['data'];
      print(subjects);
    });
  }

  Widget getList() {
    if (subjects.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      return CupertinoActivityIndicator();
    }
  }

  Widget getItem(var subject) {
    var item = new Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(4.0),
                topRight: const Radius.circular(4.0)),
            child: Image.network(
              subject['imgs'][0]['img_url'],
              width: double.infinity,
              height: 180.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 15, 10, 0),
            child: Text(
              subject['goods_name'],
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: const Color(0xFF1B1C2C),
              ),
              maxLines: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 2, 10, 0),
            width: double.infinity,
            height: 40,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Text(
                  subject['goods_credits'].toString() + "小红花",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                    color: const Color(0xFFEC6434),
                  ),
                  maxLines: 1,
                ),
                Positioned(
                  right: 0,
                  // child: Container(
                  //   width: 60,
                  //   child: FlatButton(
                  //     color: const Color(0xFFFFD646),
                  //     textColor: Colors.white,
                  //     splashColor: Colors.grey,
                  //     child: Text("兑换"),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20.0)),
                  //     onPressed: () => {},
                  //   ),
                  // ),
                  child: new ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(16.0)),
                    child: new Container(
                      width: 60,
                      color: const Color(0xFFFFD646),
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 6),
                      child: new Center(
                        child: new Text(
                          "兑换",
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Card(
      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
      elevation: 3.5,
      child: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // top: true,
      // appBar: new AppBar(
      //   title: new Text("我的"),
      // ),
      body: Container(
        color: Colors.white,
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
                new InkWell(
                  child: new Container(
                    width: 24.0,
                    height: 24.0,
                    margin: const EdgeInsets.only(
                        top: 12.0, right: 7.0, bottom: 12.0),
                    child: Image(
                      image: AssetImage("images/ic_mine_set.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  onTap: () {
                    print("设置");
                  },
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([HeaderWidget()]),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      new Container(
                        child: getList(),
                      )
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
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

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new ClipOval(
                    child: new FadeInImage.assetNetwork(
                      placeholder: "images/ic_avatar_circle.png",
                      fit: BoxFit.fitWidth,
                      image:
                          "http://thirdqq.qlogo.cn/qqapp/1106679808/DD8666A819956586B23799FBDC7A43AD/100",
                      width: 64.0,
                      height: 64.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "未登录",
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: const Color(0xFF1B1C2C),
                        // decoration: TextDecoration.none
                      ),
                    ),
                  )
                ],
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 15, 0),
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
                                child: InkWell(
                                  onTap: () {
                                    print("小红花攻略");
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                      return new FlowerStrategy(flowerNum: "0");
                                    }));
                                  },
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
            ],
          )),
    );
  }
}
