import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "CHAT_SCREEN";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController massageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;

  late String massageText;

  late DateTime now;

  late String formatedDate;

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch(e){}
  }

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.forum),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: (){
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text(' - OURGROUP - ', style: TextStyle(fontFamily: 'futura'),),
        backgroundColor: Color(0xffE2A904),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot){
                if (!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xffE2A904),
                    ));
                }
                final messages = snapshot.data!.docs;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages){
                  final messageText = message['text'];
                  final messageSender = message['sender'];

                  final currentUserEmail = loggedInUser.email;

                  final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      isMe: currentUserEmail == messageSender,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      children: messageBubbles,
                    ));
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: massageTextController,
                        style: TextStyle(color: Colors.grey),
                        onChanged: (value){
                          massageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        setState(() {
                          now = DateTime.now();
                          formatedDate = DateFormat('kk:mm:ss').format(now);
                        });
                        massageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': massageText,
                          'sender': loggedInUser.email,
                          'time' : formatedDate
                        });
                      },
                      child: const Text(
                        'send',
                        style: kSendButtonTextStyle,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  late final String sender;
  late final String text;
  late final bool isMe;

  MessageBubble({required this.sender, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.black45, fontSize: 12.0, fontFamily: 'futura'),
          ),
          SizedBox(
            height: 8,
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? Color(0xffE2A904) : Color(0xFFA97F03),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0,
              ),
              child: Text(
                text,
                style:
                TextStyle(
                    color: isMe ? Colors.white : Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'futura'
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
