import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MainPage.dart';
import 'OrderDetail.dart';

class accept_order extends StatefulWidget {
  _list_food createState() => _list_food();
}

class _list_food extends State<accept_order> {
  TextStyle headerFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle nameFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle subFontStyle = TextStyle(color: Color(0xff7a614c), fontSize: 18);
  TextStyle selectFontStyle =
      TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900);

  TextStyle rejectFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle confirmFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 22, fontWeight: FontWeight.w900);

  final _db = Firestore.instance;
  List<DocumentSnapshot> orderList;

  Future getOrderList() async {
    _db
        .collection('accept')
        .orderBy('date', descending: false)
        .snapshots()
        .listen((docs) {
      setState(() {
        orderList = docs.documents;
      });
    });
  }

  Future deleteOrder(String id)async{
    _db.collection('accept').document(id).delete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      color: Color(0xffffefdc),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "ออเดอร์ทั้งหมด",
              style: headerFontStyle,
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: orderList == null ? 0 : orderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 150,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              "โต๊ะ #${orderList[index].data['table']}",
                              style: nameFontStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${orderList[index].data['orders'].length} รายการ",
                                    style: subFontStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 115,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                deleteOrder(orderList[index].documentID);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 115,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xff882727),
                                ),
                                child: Text(
                                  "ลบ",
                                  style: selectFontStyle,
                                ),
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
    );
  }
}
