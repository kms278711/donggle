import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppIcons.background),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: <Widget>[
            Container(
              child: Scaffold(
                body: Center(
                  //child: SvgPicture.asset(AppIcons.parchment_svg, width: MediaQuery.of(context).size.width * 0.8,),
                  child: Image.asset(
                    AppIcons.parchment,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.35,
                child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(AppIcons.bottle,
                          width: MediaQuery.of(context).size.width * 0.3),
                    ))),
            Positioned(
                left: MediaQuery.of(context).size.width * 0.41,
                child: Container(
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Books",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 100),
                      ),
                    ))),
          ])),
    );
  }
}
