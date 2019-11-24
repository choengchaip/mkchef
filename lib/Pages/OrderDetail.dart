import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mkchef/Pages/MainPage.dart';

class order_detail extends StatefulWidget {
  String id;
  order_detail(this.id);
  _order_page createState() => _order_page(this.id);
}

class _order_page extends State<order_detail> {
  String id;
  _order_page(this.id);
  TextStyle rejectFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle confirmFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle headerFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle tableFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 25, fontWeight: FontWeight.w900);
  TextStyle sendFontStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle nameFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 20, fontWeight: FontWeight.w900);
  TextStyle priceFontStyle = TextStyle(color: Color(0xff7a614c), fontSize: 18);
  TextStyle textTotalFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 23, fontWeight: FontWeight.w900);
  TextStyle priceTotalFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 23, fontWeight: FontWeight.w900);

  DocumentSnapshot orderDetail;
  TextEditingController _tableNumber = TextEditingController();
  final _db = Firestore.instance;
  Future loadOrder() async {
    _db.collection('orders').document(this.id).get().then((data) {
      setState(() {
        orderDetail = data;
      });
    });
  }

  String toTypeFolder(String type) {
    String folder;
    if (type == "เนื้อ") {
      // setState(() {
      folder = "Meat";
      // });
    } else if (type == "เครื่องดื่ม") {
      // setState(() {
      folder = "Drink";
      // });
    } else if (type == "ลูกชิ้น") {
      // setState(() {
      folder = "Look Chin";
      // });
    } else if (type == "เส้น") {
      // setState(() {
      folder = "Noddle";
      // });
    } else if (type == "ทะเล") {
      // setState(() {
      folder = "Sea Food";
      // });
    } else if (type == "ผัก") {
      // setState(() {
      folder = "Vegetable";
      // });
    }
    return folder;
  }

  Future orderAccept() async {
    _db.collection('accept').add(orderDetail.data);
    _db.collection('orders').document(this.id).delete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadOrder();
  }

  @override
  Widget build(BuildContext context) {
    confirmDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("ยืนยันการรับออเดอร์หรือไม่?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("ยกเลิก"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("ยืนยัน"),
                  onPressed: () {
                    orderAccept();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return main_page();
                    }));
                  },
                ),
              ],
            );
          });
    }

    double _paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: _paddingTop,
            color: Color(0xffffefdc),
          ),
          Expanded(
            child: Container(
              color: Color(0xffffefdc),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: Text(
                          "ออเดอร์",
                          style: headerFontStyle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "เมนู",
                                      style: tableFontStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "จำนวน",
                                      style: tableFontStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: orderDetail == null
                                    ? 0
                                    : orderDetail.data['orders'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                          height: 150,
                                          color: Colors.white,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 120,
                                                      child: Image.asset(
                                                          "assets/${toTypeFolder(orderDetail.data['orders'][index]['order_type'])}/${orderDetail.data['orders'][index]['order_id']}.jpg"),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        color: Colors.white,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                orderDetail.data['orders'][index]['order_name'],
                                                                style:
                                                                    nameFontStyle,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "${orderDetail.data['orders'][index]['order_price']} บาท",
                                                                style:
                                                                    priceFontStyle,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 85,
                                                    child: Text(
                                                      '${orderDetail['orders'][index]['order_num']}',
                                                      style: nameFontStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      confirmDialog();
                    },
                    child: Container(
                      color: Color(0xff144b14),
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        "รับออเดอร์",
                        style: sendFontStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
