import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:indexed/indexed.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

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
        body: Indexer(
          children: <Widget>[
            Indexed(
              index: -5,
              child: Scaffold(
                body: Center(
                  child: Image.asset(
                    AppIcons.parchment,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Indexed(
              index: -4,
              child: Positioned(
                left: MediaQuery.of(context).size.width * 0.35,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.bottle,
                        width: MediaQuery.of(context).size.width * 0.3),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1000,
              child: Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.seaweeds,
                        width: MediaQuery.of(context).size.width),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1001,
              child: Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.ground,
                        width: MediaQuery.of(context).size.width),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1002,
              child: Positioned(
                bottom: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * 0.08,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.fish,
                        width: MediaQuery.of(context).size.width * 0.15),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1003,
              child: Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.stars,
                        width: MediaQuery.of(context).size.width * 0.08),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1004,
              child: Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.3,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.crabs,
                        width: MediaQuery.of(context).size.width * 0.25),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1005,
              child: Positioned(
                bottom: MediaQuery.of(context).size.height * 0.04,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.donggle,
                        width: MediaQuery.of(context).size.width * 0.22),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1006,
              child: Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.water_left,
                        width: MediaQuery.of(context).size.width * 0.14),
                  ),
                ),
              ),
            ),
            Indexed(
              index: 1006,
              child: Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.width * 0.01,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.water_right,
                        width: MediaQuery.of(context).size.width * 0.12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
