import 'package:fitsbook_newfeed_cm/ui/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewFeed extends StatelessWidget {
  final TextEditingController status_Word = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: new Image.asset('images/img.jpg', fit: BoxFit.cover))
      ),
      body: ListView(
        children: [ Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              /* This is a part of posting new feed. */
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  new Container(
                    padding: EdgeInsets.only(top: 24.0),              
                    width: 300.0,
                    child: new TextFormField(         
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      controller: status_Word,
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.lightGreen                 
                      ),
                      decoration: InputDecoration(
                        labelText: 'คุณกำลังคิดอะไร ?',
                        prefixIcon: Image.asset(
                          'images/img.jpg',
                          height: 50,
                        ),
                        border: OutlineInputBorder()
                      ),
                    )
                  )
                ],
              ),

              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("โพสต์"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      Firestore.instance.collection('posts')
                      .add({
                        'dateCreated': DateTime.parse(DateTime.now().toString()).millisecondsSinceEpoch, 
                        'detail': status_Word.text,
                        /* This is for Firebase Auth from login state 
                        Now I use Q's account */
                        'user' : 'lhEcuY2c6hQCnKoJrpRtYyJzSfA3',
                        /* This is for Photo Adding  */
                        'photo' : ["posts/GScRX892knG1XDvQFKjU/hello.jpg"]
                        }
                      );
                    }
                  ),
                ],
              ),

              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection('posts').orderBy("dateCreated").snapshots(),
                        builder: (context, snapshot) {
                            if (!snapshot.hasData) 
                              return Text('Loading data.. Please Wait..');
                              final children = <Widget>[];
                              final userLists = Firestore.instance.collection('users').document().documentID;
                              for (var i = 0; i < snapshot.data.documents.length; i++) {
                                children.add(
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0), 
                                    margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                    width: 300,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: 

                                    Column(
                                      children: <Widget>[
                                        // StreamBuilder<QuerySnapshot>(
                                        // stream: Firestore.instance.collection('users').snapshots(),
                                        // builder: (context, snapshot2) {
                                        //   return Column(
                                        //     children: <Widget>[
                                        //       Text(snapshot2.data.documents[0]['user']),
                                        //     ],
                                        //   );
                                        // },),

                                        Text(''
                                          +""
                                         //userLists
                                        //  Firestore.instance.collection('users').where(snapshot.data.documents[i]['user']).reference(),
                                          ,style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        Image.asset(['photo'][0]),

                                        Text(
                                          snapshot.data.documents[i]['detail'],
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        Text('โพสต์เมื่อ : ' + 
                                          DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[i]['dateCreated']).toUtc().toString()
                                          
                                          ,
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.lightGreen                 
                                          ),  
                                        ),

                                        FlatButton(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Comment"),
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(title: snapshot.data.documents[i]['detail'],no: i)));
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
                      
                      ),
                      

                      
                    ],
                  ),
                ),
              )

            ], 
            ),
          ), ]
      ),
    );
  }
}
