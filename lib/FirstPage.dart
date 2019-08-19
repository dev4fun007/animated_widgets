import 'dart:math';

import 'package:animated_widgets/Quotes.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> with TickerProviderStateMixin {

  bool showNextButton = false;
  bool showNameLabel = false;
  bool alignTop = false;
  bool increaseLeftPadding = false;
  bool showGreetings = false;
  bool showQuoteCard = false;
  String name = '';


  double screenWidth;
  double screenHeight;
  String quote;


  @override
  void initState() {
    super.initState();
    Random random = new Random();
    int quoteIndex = random.nextInt(Quotes.quotesArray.length);
    quote = Quotes.quotesArray[quoteIndex];
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _getAppBar(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: _getGreetingLabelWidget(),
          ),
          _getAnimatedAlignWidget(),
/*          Align(
            alignment: Alignment.center,
            child: _getQuoteCardWidget(),
          ),*/
          _getAnimatedPositionWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _getAnimatedOpacityButton(),
          )
        ],
      ),
    );
  }

  _getAnimatedOpacityButton() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      opacity: showNextButton ? 1 : 0,
      child: _getButton(),
    );
  }

  _getAnimatedCrossfade() {
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      reverseDuration: Duration(seconds: 1),
      firstChild: _getNameInputWidget(),
      firstCurve: Curves.easeInOut,
      secondChild: _getNameLabelWidget(),
      secondCurve: Curves.easeInOut,
      crossFadeState: showNameLabel ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }

  _getAnimatedAlignWidget() {
    return AnimatedAlign(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: alignTop ? Alignment.topLeft : Alignment.center,
      child: _getAnimatedPaddingWidget(),
    );
  }

  _getAnimatedPaddingWidget() {
    return AnimatedPadding(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      padding: increaseLeftPadding ? EdgeInsets.only(left: 28.0) : EdgeInsets.only(left: 0),
      child: _getAnimatedCrossfade(),
    );
  }

  _getNameLabelWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: screenWidth/2,
        height: 75.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(name, style: TextStyle(fontSize: 18.0, color: Colors.black54),),
        )
      ),
    );
  }

  _getNameInputWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: screenWidth/2,
        height: 75.0,
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                hintText: 'Your name'
            ),
            textAlign: TextAlign.left,
            textCapitalization: TextCapitalization.words,
            onChanged: (v) {
              name = v;
              if(v.length > 0) {
                setState(() {
                  showNextButton = true;
                });
              } else {
                setState(() {
                  showNextButton = false;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  _getGreetingLabelWidget() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      opacity: showGreetings ? 1.0 : 0.0,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0,),
        child: Container(
            width: screenWidth/2,
            height: 75.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Hi,", style: TextStyle(fontSize: 18.0, color: Colors.black54),),
            )
        ),
      ),
    );
  }

  _showGreetings() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showGreetings = true;
      });
    });
  }

  _increaseLeftPadding() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        increaseLeftPadding = true;
      });
    });
  }

  _getAnimatedPositionWidget() {
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: _getQuoteCardWidget(),
      top: showQuoteCard ? screenHeight/2 - 100 : screenHeight,
      left: !showQuoteCard ? screenWidth/2 : 12,
    );
  }

  _getQuoteCardWidget() {
    return Card(
      color: Colors.green,
      elevation: 8.0,
      child: _getAnimatedSizeWidget(),
    );
  }

  _getAnimatedSizeWidget() {
    return AnimatedSize(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      vsync: this,
      child: _getQuoteContainer(),
    );
  }

  _getQuoteContainer() {
    return Container(
      height: showQuoteCard ? 100 : 0,
      width: showQuoteCard ? screenWidth - 32 : 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(quote, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),),
        ),
      ),
    );
  }

  _showQuote() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showQuoteCard = true;
      });
    });
  }

  _getButton() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            showNameLabel = true;
            alignTop = true;
          });
          _increaseLeftPadding();
          _showGreetings();
          _showQuote();
        },
        mini: true,
        child: Icon(Icons.arrow_forward, color: Colors.white,),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      title: Text("Animated Widgets", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
      backgroundColor: Colors.blue,
    );
  }

}