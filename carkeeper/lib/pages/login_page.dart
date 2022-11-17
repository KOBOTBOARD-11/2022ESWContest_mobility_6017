import 'package:carkeeper/firebase/firebase_auth_manager.dart';
import 'package:carkeeper/pages/car_keeper_page.dart';
import 'package:carkeeper/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthManager authManager = AuthManager();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String email = '';
  String pw = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Mheight = MediaQuery.of(context).size.height;
    final Mwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Car Keeper",
                  style: h1(
                    mColor: const Color(0xFF06A66C),
                  ),
                ),
              ),
              SizedBox(height: Mheight * 0.15),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Mwidth * 0.8,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Text(
                      "Sign In",
                      style: h3(mColor: const Color(0xFF06A66C)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Mwidth * 0.1),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            width: Mwidth * 0.8,
                            child: Text(
                              "E-mail",
                              style: subtitle2(mColor: Colors.black),
                            ),
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: "E-mail",
                            hintText: "Enter E-mail",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF06A66C)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            width: Mwidth * 0.8,
                            child: Text(
                              "Password",
                              style: subtitle2(mColor: Colors.black),
                            ),
                          ),
                        ),
                        TextField(
                          controller: pwController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: "Password",
                            hintText: "Enter Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF06A66C)),
                            ),
                          ),
                        ),
                        SizedBox(height: Mheight * 0.03),
                        AspectRatio(
                          aspectRatio: 6,
                          child: MaterialButton(
                            onPressed: () async {
                              email = emailController.text;
                              pw = pwController.text;
                              final access =
                                  await authManager.signInUser(email, pw);
                              if (access == true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CarKeeperPage()));
                              } else {
                                print("fail");
                              }
                            },
                            color: const Color(0xFF06A66C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "로그인",
                                style: subtitle3(mColor: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Mheight * 0.01),
                        AspectRatio(
                          aspectRatio: 6,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side:
                                    const BorderSide(color: Color(0xFF06A66C))),
                            child: Center(
                              child: Text(
                                "회원가입",
                                style:
                                    subtitle3(mColor: const Color(0xFF06A66C)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
