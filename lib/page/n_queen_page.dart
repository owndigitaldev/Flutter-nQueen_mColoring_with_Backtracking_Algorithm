import 'package:backtracking/common/constans.dart';
import 'package:backtracking/tool/helper.dart';
import 'package:backtracking/widget/button.dart';
import 'package:flutter/material.dart';

class NQueenPage extends StatefulWidget {
  @override
  _NQueenPageState createState() => _NQueenPageState();
}

class _NQueenPageState extends State<NQueenPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Helper _helper;
  List<List<int>> _board;
  String _msg;
  int _dimensi;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _helper = new Helper();
    _dimensi = 4;
    _onClear();
  }

  void _onClear() {
    setState(() {
      _msg = "";
      _board = [];
      for (int i = 0; i < _dimensi; i++) {
        List<int> x = [];
        for (int j = 0; j < _dimensi; j++) {
          x.add(0);
        }
        _board.add(x);
      }
    });
  }

  void _onSolve() {
    setState(() => _msg += "Log :\n");
    if (!_solveNQueen(0)) {
      setState(() => _msg += "Tidak Dapat Dipecahkan\n");
    }
  }

  bool _solveNQueen(int kolom) {
    if (kolom >= _dimensi)
      return true;
    else
      for (int i = 0; i < _dimensi; i++) {
        if (_isSafe(i, kolom)) {
          setState(() {
            _board[i][kolom] = 1;
            _msg += "Menempatkan Queen di baris ${i + 1} kolom ${kolom + 1}\n";
          });

          if (_solveNQueen(kolom + 1)) return true;

          setState(() => _board[i][kolom] = 0);
        }
      }
    return false;
  }

  bool _isSafe(int baris, int kolom) {
    for (int i = 0; i < kolom; i++) {
      setState(() => _msg +=
          "Mengecek baris ${baris + 1} kolom ${i + 1} sudah ditempati : ${_board[baris][i] == 1}\n");
      if (_board[baris][i] == 1) return false;
    }

    for (int i = baris, j = kolom; i >= 0 && j >= 0; i--, j--) {
      setState(() => _msg +=
          "Mengecek baris ${i + 1} kolom ${j + 1} sudah ditempati : ${_board[i][j] == 1}\n");
      if (_board[i][j] == 1) return false;
    }

    for (int i = baris, j = kolom; j >= 0 && i < _dimensi; i++, j--) {
      setState(() => _msg +=
          "Mengecek baris ${i + 1} kolom ${j + 1} sudah ditempati : ${_board[i][j] == 1}\n");
      if (_board[i][j] == 1) return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(kS4Queen),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dimensiChooser(),
            SizedBox(height: 16.0),
            _buildBoard(),
            SizedBox(height: 16.0),
            _buildButton(),
            SizedBox(height: 16.0),
            Text(_msg),
          ],
        ),
      ),
    );
  }

  Widget _dimensiChooser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _itemChooser(
          title: "-",
          onTap: () {
            if (_dimensi > 4)
              setState(() {
                _dimensi--;
                _onClear();
              });
          },
        ),
        SizedBox(width: 32.0),
        _itemChooser(title: "$_dimensi"),
        SizedBox(width: 32.0),
        _itemChooser(
          title: "+",
          onTap: () {
            setState(() {
              _dimensi++;
              _onClear();
            });
          },
        ),
      ],
    );
  }

  Widget _itemChooser({@required String title, Function onTap}) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(fontSize: 32.0),
      ),
      onTap: onTap,
    );
  }

  Widget _buildBoard() {
    double width =
        ((MediaQuery.of(context).size.width - 32.0) ~/ _dimensi).toDouble();

    return Column(
      children: List.generate(_dimensi, (baris) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_dimensi, (kolom) {
            return Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: baris % 2 == 0
                    ? kolom % 2 == 0
                        ? Colors.blue
                        : Colors.white
                    : kolom % 2 == 0
                        ? Colors.white
                        : Colors.blue,
              ),
              child: Center(
                child: Text(
                  _board[baris][kolom] == 0 ? "" : "Q",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
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
            title: "Solve",
            onTap: () => _onSolve(),
          ),
        ),
      ],
    );
  }
}
