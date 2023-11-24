// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:whatsapp2/provider/chatprovider.dart';

// class Chatscreen extends StatefulWidget {
//   final String receiverUserId;
//   final String receiverUserEmail;
//   const Chatscreen(
//       {super.key,
//       required this.receiverUserId,
//       required this.receiverUserEmail});

//   @override
//   State<Chatscreen> createState() => _ChatscreenState();
// }

// class _ChatscreenState extends State<Chatscreen> {

//   ChatProvider chatProvider = ChatProvider();
//   TextEditingController controller = TextEditingController();
//   FirebaseAuth fireAuth = FirebaseAuth.instance;
//   FirebaseFirestore fstorage = FirebaseFirestore.instance;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//             child: Column(
//       children: [
//         Container(
//           height: 100,
//           width: double.infinity,
//           color: const Color(0xff202C33),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 28,
//                     )),
//                 Container(
//                   height: 50,
//                   width: 50,
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.grey),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 167),
//                   child: Icon(
//                     Icons.videocam_rounded,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 30),
//                   child: Icon(
//                     Icons.call,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 25),
//                   child: Icon(
//                     Icons.more_vert,
//                     color: Colors.white,
//                     size: 29,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     )));
//   }

// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:whatsapp2/provider/chatprovider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:whatsapp/provider/chatprovider.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserEmail;
  final String receiverUserName;
  const ChatScreen(
      {super.key,
      required this.receiverUserId,
      required this.receiverUserEmail,
      required this.receiverUserName});

  @override
  State<ChatScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  ChatProvider chatProvider = ChatProvider();
  TextEditingController controller = TextEditingController();
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore fstorage = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.receiverUserName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 80,
            ),
            const Icon(
              Icons.videocam_rounded,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 25,
            ),
            const Icon(
              Icons.call,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.more_vert_sharp,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: const Color(0xff202C33),
      ),
      body: Column(children: [
        Expanded(child: _chatBilder()),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
              ),
            )),
            // attach///////////////////////////////////////////////////////////
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.attach_file_outlined,
                )),
            // send/////////////////////////////////////////////////
            IconButton(
                onPressed: () {
                  chatProvider.sendMessage(
                      widget.receiverUserId, controller.text);
                  controller.clear();
                },
                icon: const Icon(Icons.send))
          ],
        )
      ]),
    );
  }

  Widget _chatBilder() {
    return StreamBuilder(
        stream: chatProvider.getMessages(
            fireAuth.currentUser!.uid, widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              reverse: true,
              children: snapshot.data!.docs
                  .map((docs) => _chatItemBuilder(docs))
                  .toList(),
            );
          }
        });
  }

  Widget _chatItemBuilder(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = data["senderId"] == fireAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var chatColor = data["senderId"] == fireAuth.currentUser!.uid
        ? const Color(0xff00a884)
        : const Color.fromARGB(255, 57, 75, 90);

    return Container(
      color: Colors.grey[300],
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(left: 80, right: 10, bottom: 5, top: 10),
        child: Container(
          // width: MediaQuery.of(context).size.width * .45,
          // height: MediaQuery.of(context).size.height * .1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: chatColor),
          child: Column(children: [
            // Text(data["senderEmail"]),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                data["message"],
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
