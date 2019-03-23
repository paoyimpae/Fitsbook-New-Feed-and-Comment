import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment extends StatelessWidget {
  final String title;
  final int no;
  Comment({this.title, this.no});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('posts').orderBy("dateCreated").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) 
                  return Text('Loading data.. Please Wait..');
                return new Column(
                  children : <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 20.0), 
                      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      width: 300,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        children: <Widget>[
                          Text('' + 

                            snapshot.data.documents[no]['user'],
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.lightGreen                 
                            ),  
                          ),

                          Image.asset(['photo'][0]),

                          Text(
                            snapshot.data.documents[no]['detail'],
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.lightGreen                 
                            ),  
                          ),

                          Text('โพสต์เมื่อ : ' + 
                            snapshot.data.documents[no]['dateCreated'].toString(),
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.lightGreen                 
                            ),  
                          ),

                          FlatButton(
                           padding: const EdgeInsets.all(8.0),
                           child: Text("กลับไปสู่หน้าฟีด"),
                           textColor: Colors.white,
                           color: Colors.green,
                           onPressed: () {
                             Navigator.pop(context);
                           }
                         ),
                        ],
                      )),
                     
                    
                      
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('posts').document(snapshot.data.documents[no].documentID).collection('comments').snapshots(),
                        builder: (context, snapshot2) {
                            if (!snapshot.hasData) 
                              return Text('Loading data.. Please Wait..');

                          
                              final children = <Widget>[];
                              for (var i = 0; i < snapshot2.data.documents.length; i++) {
                                children.add(
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0), 
                                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                                    width: 300,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text('' + 
                                        
                                          snapshot2.data.documents[i]['user'],
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        Image.asset(['photo'][0]),

                                        Text(
                                          snapshot2.data.documents[i]['detail'],
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        Text('โพสต์เมื่อ : ' + 
                                          snapshot2.data.documents[i]['dateCreated'].toString(),
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        FlatButton(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("ลบ"),
                                          textColor: Colors.white,
                                          color: Colors.red,
                                          onPressed: () {
                                            Firestore.instance.collection('posts').document(snapshot.data.documents[no].documentID)
                                            .collection('comments').document(snapshot2.data.documents[i].documentID).delete();
                                          }
                                        ),
                                      ],
                                    ))
                                  );
                                  
                                  
                              }
                              return new Column(
                                children: children,
                              );
                                              
                        },
                      )
                    )
                  ]
                );           
                },
            )          
          ),           
          ],
        ),
      ),
    );
  }
}


