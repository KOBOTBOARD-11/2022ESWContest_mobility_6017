import 'package:flutter/material.dart';

import '../styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Text(
                      "회원가입",
                      style: h3(mColor: const Color(0xFF06A66C)),
                    ),
                  ),
                  SizedBox(height: Mheight * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Mwidth * 0.1),
                    child: Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "E-mail",
                            hintText: "Press your E-mail",
                            labelStyle: TextStyle(color: Color(0xFF06A66C)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF06A66C)),
                            ),
                          ),
                        ),
                        SizedBox(height: Mheight * 0.01),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Press your Password",
                            labelStyle: TextStyle(color: Color(0xFF06A66C)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF06A66C)),
                            ),
                          ),
                        ),
                        SizedBox(height: Mheight * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 4 / 1,
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: const Color(0xFF06A66C),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "가입하기",
                                      style: subtitle3(mColor: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Mwidth * 0.01),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 4 / 1,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: const Color(0xFF06A66C),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "뒤로가기",
                                      style: subtitle3(mColor: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
