import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class GroupChat extends StatefulWidget {
  static String routeName = "/group_chat";
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection('messageStorage').snapshots().listen(
        (data) => data.documents.forEach((doc) => print(doc['message'])));
    return Scaffold(
      appBar: AppBar(
        title: Text("KONUŞMA GRUBU"),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/palmiye_aydinlik.jpg"))),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: Firestore.instance.collection('messages').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    if (snapshot.hasError)
                      return Text("Error : ${snapshot.error}");
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Text("Loading...");
                    return ListView(
                      children: snapshot.data.documents
                          .map((doc) => ListTile(
                                title: Text(doc['message_user_name']),
                                subtitle: Text(doc['message_text']),
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(25))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(Icons.tag_faces, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Mesajınızı yazın",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
