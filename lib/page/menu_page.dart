import 'package:backtracking/common/constans.dart';
import 'package:backtracking/page/graph_coloring_page.dart';
import 'package:backtracking/page/n_queen_page.dart';
import 'package:backtracking/tool/helper.dart';
import 'package:backtracking/widget/button.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper();
  }

  Function _openCase(Widget page) {
    return () => _helper.jumpToPage(context, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(kSAppName),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Button(
              title: kS4Queen,
              onTap: _openCase(NQueenPage()),
            ),
            Button(
              title: kSGraph,
              onTap: _openCase(GraphColoringPage()),
            ),
          ],
        ),
      ),
    );
  }
}
