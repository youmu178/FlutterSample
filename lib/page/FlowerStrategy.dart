import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlowerStrategy extends StatelessWidget {
  final String flowerNum;
  FlowerStrategy({Key key, this.flowerNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Strategy(flowerNum: this.flowerNum);
  }
}

class Strategy extends StatefulWidget {
  final String flowerNum;

  Strategy({Key key, this.flowerNum}) : super(key: key);

  @override
  _StrategyState createState() => _StrategyState();
}

class _StrategyState extends State<Strategy>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    tabs = <Tab>[Tab(text: "红花攻略"), Tab(text: "红花明细"), Tab(text: "红花兑换")];
    tabController =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image(
                image: AssetImage("images/ic_nav_back.png"),
                width: 15,
                height: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.flowerNum,
              style: TextStyle(color: const Color(0xFFec6434), fontSize: 32),
            ),
            Text(
              "我已获得的小红花",
              style: TextStyle(color: const Color(0xFF969696), fontSize: 14),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, top: 40),
              child: TabBar(
                controller: tabController,
                tabs: tabs,
                isScrollable: true,
                indicatorColor: const Color(0xFFFFD646),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: const Color(0xFF1B1C2C),
                unselectedLabelColor: const Color(0xFFc4c4c4),
              ),
            ),
            new Container(
              color: const Color(0xFFf8f8f8),
              height: 1.0,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  new Center(child: new Text('红花攻略')),
                  new Center(child: new Text('红花明细')),
                  new Center(child: new Text('红花兑换')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
