import 'package:flutter/material.dart';
import 'OrderList.dart';
import 'AcceptOrder.dart';

class main_page extends StatefulWidget {
  _main_page createState() => _main_page();
}

class _main_page extends State<main_page> {
  TextStyle bottomFontStyle =
      TextStyle(color: Color(0xff7a614c), fontWeight: FontWeight.w900);

  PageController _pageviewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageviewController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    double _paddingBottom = MediaQuery.of(context).padding.bottom;
    double _paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: _paddingTop,
            color: Color(0xffffefdc),
          ),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageviewController,
              children: <Widget>[
                list_food(),
                accept_order()
              ],
            ),
          ),
          Container(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _pageviewController.animateToPage(0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 200));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/Icon/foods.png'),
                        ),
                        Container(
                          child: Text(
                            "เมนูทั้งหมด",
                            style: bottomFontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageviewController.animateToPage(1,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 200));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/Icon/orders.png'),
                        ),
                        Container(
                          child: Text(
                            "ออเดอร์",
                            style: bottomFontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: _paddingBottom,
          ),
        ],
      ),
    );
  }
}
