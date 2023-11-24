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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/ok.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: const Color(0xff202C33),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        )),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          widget.receiverUserName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ),
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
                    const SizedBox(width: 25),
                    const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 29,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(children: [
                Expanded(child: _chatBilder()),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 52,
                                width: 343,
                                decoration: BoxDecoration(
                                    color: const Color(0xff2c373d),
                                    borderRadius: BorderRadius.circular(28)),
                                child: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      hintText: "          Message",
                                      hintStyle: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          height: BorderSide.strokeAlignCenter,
                                          fontFamily: 'Helvetica'),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                ),
                              ),
                            ),
                          )),
                          // attach///////////////////////////////////////////////////////////
                          Align(
                            alignment: const AlignmentDirectional(.91, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.5),
                              child: IconButton(
                                  onPressed: () {
                                    chatProvider.sendMessage(
                                        widget.receiverUserId, controller.text);
                                    controller.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          // send/////////////////////////////////////////////////
                          Align(
                            alignment: const AlignmentDirectional(.65, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.5),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white70,
                                  )),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(.4, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.5),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Transform.rotate(
                                    angle: 26,
                                    child: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.white70,
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.5,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-.95, 0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.emoji_emotions,
                                    color: Colors.white60,
                                    size: 28,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 8, 185, 146),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mic,
                            size: 30,
                            color: Colors.white,
                            opticalSize: 50,
                          )),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
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
        ? const Color.fromARGB(255, 10, 123, 112)
        : const Color.fromARGB(255, 57, 75, 90);

    return Container(
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
