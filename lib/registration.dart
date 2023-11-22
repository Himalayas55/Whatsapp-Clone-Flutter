// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp2/login.dart';
import 'package:whatsapp2/provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _LoginState();
}

class _LoginState extends State<Registration> {
  var formkey = GlobalKey<FormState>();
  // final fireauth = FirebaseAuth.instance;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<FirService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xff19c33c),
        automaticallyImplyLeading: false,
        title: const Text("Registration"),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Name is required";
                  }
                  return null;
                },
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Name",
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Email"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  // Perform custom password validation here
                  if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "Password must contain at least one uppercase letter";
                  }
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return "Password must contain at least one lowercase letter";
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return "Password must contain at least one numeric character";
                  }
                  if (!value.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                    return "Password must contain at least one special character";
                  }
                  return null; // Password is valid
                },
                controller: pass,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Password",
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IconButton(
                onPressed: () {
                  authServices.registeruser(email.text, pass.text, name.text);
                },
                icon: const Text("Register")),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
                },
                icon: const Text("Go to login"))
          ],
        ),
      ),
    );
  }
}
