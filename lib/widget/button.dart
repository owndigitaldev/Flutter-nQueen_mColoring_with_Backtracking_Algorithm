import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String title;
  final Function onTap;

  Button({@required this.title, this.onTap});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(widget.title),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: widget.onTap,
      ),
    );
  }
}
