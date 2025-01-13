import 'package:bookjuckboojuck/screens/main_screen.dart';
import 'package:bookjuckboojuck/screens/signup_screen.dart';
import 'package:bookjuckboojuck/widgets/custom_text.dart';
import 'package:bookjuckboojuck/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

String id = 'cntmdwn';
String password = '1234';
String errorText = '';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    String currentId = idController.text.trim();
    String currentPassword = passwordController.text.trim();

    if (currentId == id && currentPassword == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } else {
      setState(() {
        errorText = '아이디 또는 비밀번호가 올바르지 않습니다.';
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          errorText = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '북적북적',
                        fontSize: 38,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontSize: 25,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextfield(
                hintTextName: '아이디',
                controller: idController,
              ),
              SizedBox(
                height: 3,
              ),
              CustomTextfield(
                hintTextName: '비밀번호',
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                errorText,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () => handleLogin(context),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '회원이 아니신가요?',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ));
                  },
                  child: Text(
                    '가입하기',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
