import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppIcons.background),
          ),
        ),
        child: Column(
          children: [
            const DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Nanumson_jangmi',
                fontWeight: FontWeight.w400,
                fontSize: 200,
                color: Colors.black,
              ),
              child: Text('동  글  이'),
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: 'Nanumson_jangmi',
                    fontSize: 60,
                    color: Colors.black,
                  ),
                  child: Text('ID'),
                ),
                SizedBox(
                  width: 500,
                  child: TextField(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: 'Nanumson_jangmi',
                    fontSize: 60,
                    color: Colors.black,
                  ),
                  child: Text('PW'),
                ),
                SizedBox(
                  width: 500,
                  child: TextField(
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: 'Nanumson_jangmi',
                      fontWeight: FontWeight.w400,
                      fontSize: 80,
                      color: Colors.black,
                    ),
                    child: Text('로그인'),
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: 'Nanumson_jangmi',
                      fontWeight: FontWeight.w400,
                      fontSize: 80,
                      color: Colors.black,
                    ),
                    child: Text('회원가입'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}