import 'package:backtracking/common/constans.dart';
import 'package:backtracking/model/vertex.dart';
import 'package:backtracking/tool/helper.dart';
import 'package:backtracking/widget/button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GraphColoringPage extends StatefulWidget {
  @override
  _GraphColoringPageState createState() => _GraphColoringPageState();
}

class _GraphColoringPageState extends State<GraphColoringPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;
  List<Vertex> _graph;
  String _msg;
  List<Color> _availColor;
  int _dimensi;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper();
    _dimensi = 4;
    _availColor = [Colors.red, Colors.green, Colors.blue];
    _onClear();
  }

  void _onClear() {
    setState(() {
      _graph = [];
      _msg = "";

      _graph.add(Vertex(name: "A", color: Colors.white, val: [0, 1, 1, 1]));
      _graph.add(Vertex(name: "B", color: Colors.white, val: [1, 0, 1, 0]));
      _graph.add(Vertex(name: "C", color: Colors.white, val: [1, 1, 0, 1]));
      _graph.add(Vertex(name: "D", color: Colors.white, val: [1, 0, 1, 0]));
    });
  }

  void _startColoring() {
    setState(() => _msg += "Log :\n");
    if (!_graphColoringUtil(0)) {
      setState(() => _msg += "Tidak Dapat Dipecahkan\n");
    }
  }

  bool _graphColoringUtil(int v) {
    if (v == _dimensi) return true;

    for (int c = 0; c < _availColor.length; c++) {
      if (_isSafe(v, _availColor[c])) {
        setState(() {
          _msg +=
              "Set Warna Vertex ${_graph[v].name} dengan warna ${_getNameOfColor(_availColor[c])}\n\n";
          _graph[v].color = _availColor[c];
        });

        if (_graphColoringUtil(v + 1)) return true;

        setState(() {
          _msg +=
              "Set Warna Vertex ${_graph[v].name} dengan warna ${_getNameOfColor(Colors.white)}\n\n";
          _graph[v].color = Colors.white;
        });
      }
    }

    return false;
  }

  bool _isSafe(int v, Color c) {
    for (int i = 0; i < _dimensi; i++) {
      setState(() {
        _msg +=
            "Mengecek apakah vertex ${_graph[v].name} terkoneksi dengan vertex ${_graph[i].name} (${_graph[v].val[i] == 1}) dan juga vertex ${_graph[i].name} berwarna ${_getNameOfColor(c)} : ${_graph[v].val[i] == 1 && c == _graph[i].color}\n";
      });
      if (_graph[v].val[i] == 1 && c == _graph[i].color) return false;
    }
    return true;
  }

  String _getNameOfColor(Color c) {
    switch (c.toString()) {
      case "MaterialColor(primary value: Color(0xfff44336))":
        return "Merah";
        break;
      case "MaterialColor(primary value: Color(0xff4caf50))":
        return "Hijau";
        break;
      case "MaterialColor(primary value: Color(0xff2196f3))":
        return "Biru";
        break;
      default:
        return "Putih";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(kSGraph),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _drawGraph(),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Button(
                    title: "Clear",
                    onTap: () => _onClear(),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Button(
                    title: "Start Coloring",
                    onTap: () => _startColoring(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(_msg),
          ],
        ),
      ),
    );
  }

  Widget _drawGraph() {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
                height: 100,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 230.0,
                child: Row(
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                          color: _graph[0].color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(_graph[0].name),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Divider(
                          thickness: 2.0,
                          height: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                          color: _graph[1].color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(_graph[1].name),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 198.0,
                child: Row(
                  children: [
                    Container(
                      height: 164.0,
                      child: VerticalDivider(
                        thickness: 2.0,
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 164.0,
                      child: VerticalDivider(
                        thickness: 2.0,
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 230.0,
                child: Row(
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                          color: _graph[3].color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(_graph[3].name),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Divider(
                          thickness: 2.0,
                          height: 2.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                          color: _graph[2].color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(_graph[2].name),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
