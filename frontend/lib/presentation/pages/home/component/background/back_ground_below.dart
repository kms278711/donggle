import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:indexed/indexed.dart';

class BackGroundBelow extends StatelessWidget {
  const BackGroundBelow({super.key});

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Indexer(
          children: <Widget>[
            Indexed(
              index: -5,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
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
          ],
        ),
      ),
    );
  }
}
