// import 'package:firebase/page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp2/provider/provider.dart';
// ignore: depend_on_referenced_packages

import 'package:whatsapp2/registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final fireauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<FirService>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                color: const Color(0xff19c33c),
                child: LottieBuilder.asset("assets/whatsapp.json"),
              ),
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const Text("Please login first"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 57, 221, 63))),
                  hintText: "Email",
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: pass,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 39, 210, 44))),
                    hintText: "Password"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Already have an Account?"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: const Color(0xff19c33c),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () {
                    authServices.loginusers(email.text, pass.text);
                  },
                  icon: const Text("Login")),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Or"),
            IconButton(
                splashColor: Colors.black12,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Registration(),
                  ));
                },
                icon: const Text("Sign up"))
          ],
        ),
      ),
    );
  }
}
