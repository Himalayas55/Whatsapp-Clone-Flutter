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
                                onPressed: () {},
                                child: const Text("Settings")),
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
                backgroundColor: const Color(0xff202C33)),
            body: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Chatscreen()));
                    },
                    child: Container(
                      height: 30,
                      color: const Color(0xff101d25),
                    ),
                  );
                })));
  }
}
