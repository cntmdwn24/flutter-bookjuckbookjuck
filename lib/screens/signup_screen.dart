import 'package:bookjuckboojuck/screens/login_screen.dart';
import 'package:bookjuckboojuck/widgets/custom_text.dart';
import 'package:bookjuckboojuck/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                        '회원가입',
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
              CustomTextfield(hintTextName: '아이디'),
              SizedBox(
                height: 5,
              ),
              CustomTextfield(
                hintTextName: '비밀번호',
                isPassword: true,
              ),
              CustomTextfield(
                hintTextName: '비밀번호 확인',
                isPassword: true,
              ),
              SizedBox(
                height: 10,
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
                  onPressed: () {},
                  child: Text(
                    '회원가입',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이미 회원이신가요?',
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
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue.shade500,
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w800,
                      ),
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
