import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignup = false;

  void SignUpToggle() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage(AppIcons.background),
        //   ),
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const DefaultTextStyle(
                style: TextStyle(
                  fontFamily: 'Nanumson_jangmi',
                  fontWeight: FontWeight.w400,
                  fontSize: 180,
                  color: Colors.black,
                ),
                child: Text('동  글  이'),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 700,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  decoration: InputDecoration(
                    icon: Text(
                      'ID',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 700,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Text(
                      'PW',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedCrossFade(
                firstChild: Container(
                  width: 700,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Text(
                        'PW 확인',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.black,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                secondChild: Container(
                  width: 700,
                ),
                crossFadeState: isSignup
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              ),
              const SizedBox(
                height: 30,
              ),
              AnimatedCrossFade(
                firstChild: Row(
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
                        child: Text('회원가입'),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        SignUpToggle();
                      },
                      child: const DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'Nanumson_jangmi',
                          fontWeight: FontWeight.w400,
                          fontSize: 80,
                          color: Colors.black,
                        ),
                        child: Text('취소'),
                      ),
                    ),
                  ],
                ),
                secondChild: Row(
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
                        SignUpToggle();
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
                ),
                crossFadeState: isSignup
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              )
            ],
          ),
        ),
      ),
    );
  }
}
