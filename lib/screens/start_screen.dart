import 'package:bookjuckboojuck/screens/login_screen.dart';
import 'package:bookjuckboojuck/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset(
              'assets/images/bookjuck_icon.png',
              color: Colors.blue.shade300,
              width: 100,
              height: 100,
            ),
            Text(
              '북적북적',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'ggr',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '당신의 독서를 더욱더 편리하게 즐겨보세요',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 250,
            ),
            Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
