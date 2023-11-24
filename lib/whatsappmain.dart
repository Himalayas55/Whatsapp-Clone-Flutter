import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp2/chatscreen.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color.fromARGB(255, 1, 183, 144),
            child: const Icon(
              Icons.chat_outlined,
              color: Color(0xff101d25),
            ),
          ),
          appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: PopupMenuButton(
                    iconSize: 28,
                    color: Colors.white70,
                    onSelected: (value) {
                      // your logic
                    },
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: '/Settings',
                          child: TextButton(
                              onPressed: () {}, child: const Text("Settings")),
                        ),
                        PopupMenuItem(
                          // value: '/Logout',
                          child: TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              child: const Text("Logout")),
                        )
                      ];
                    },
                  ),
                )
              ],
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              bottom: const TabBar(
                unselectedLabelColor: Colors.white54,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicatorColor: Color(0xff00a884),
                labelColor: Color(0xff00a884),
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 25),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.groups_2,
                      size: 30,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Chats",
                      style: TextStyle(fontSize: 22, fontFamily: 'Helvetica'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Status",
                      style: TextStyle(fontSize: 22, fontFamily: 'Helvetica'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Calls",
                      style: TextStyle(fontSize: 22, fontFamily: 'Helvetica'),
                    ),
                  ),
                ],
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "WhatsApp",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5, left: 5),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Icon(
                      Icons.search_sharp,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xff1c2d35)),
          body: _userList(),
          backgroundColor: const Color(0xff0F1C24),
        ));
  }

  //list view
  Widget _userList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children:
                snapshot.data!.docs.map((docs) => _userItem(docs)).toList(),
          );
        }
      },
    );
  }

//list item
  Widget _userItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (FirebaseAuth.instance.currentUser!.email != data["email"]) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiverUserId: data["uid"],
              receiverUserEmail: data["email"],
              receiverUserName: data["name"],
            ),
          ));
        },
        child: ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              color: Color.fromARGB(255, 34, 68, 96),
            ),
          ),
          title: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverUserId: data["uid"],
                    receiverUserEmail: data["email"],
                    receiverUserName: data["name"],
                  ),
                ));
              },
              child: Text(
                data["email"],
                style: const TextStyle(color: Colors.white),
              )),
          subtitle: const Text("Last Message"),
          // trailing: const Icon(Icons.notifications_none_rounded),
        ),
      );
    } else {
      return Container(
        color: Colors.amber,
      );
    }
  }
}
