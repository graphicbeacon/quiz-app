import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController,
        curve: Curves.linear); // animate values from 0.0, 0.1, 0.2, ... 1.0
    _fontSizeAnimation.addListener(() => this.setState(
        () {})); // on every frame rebuild our widget with the new value
    _fontSizeAnimationController.forward(); // start animating
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
            child: new Center(
                child: new Text(
                    "Statement ${widget._questionNumber}: ${widget._question}",
                    style: new TextStyle(
                        fontSize: _fontSizeAnimation.value * 15)))));
  }
}
