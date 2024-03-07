import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:indexed/indexed.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController1;
  Animation<double>? _rotateAnimation1;
  Animation<double>? _scaleAnimation1;
  Animation<Offset>? _transAnimation1;
  AnimationController? _animationController2;
  Animation<double>? _rotateAnimation2;
  Animation<double>? _scaleAnimation2;
  Animation<Offset>? _transAnimation2;
  AnimationController? _animationController3;
  Animation<double>? _rotateAnimation3;
  Animation<double>? _scaleAnimation3;
  Animation<Offset>? _transAnimation3;
  AnimationController? _animationController4;
  Animation<double>? _rotateAnimation4;
  Animation<double>? _scaleAnimation4;
  Animation<Offset>? _transAnimation4;
  AnimationController? _animationController5;
  Animation<double>? _rotateAnimation5;
  Animation<double>? _scaleAnimation5;
  Animation<Offset>? _transAnimation5;
  AnimationController? _animationController6;
  Animation<double>? _rotateAnimation6;
  Animation<double>? _scaleAnimation6;
  Animation<Offset>? _transAnimation6;
  AnimationController? _animationController7;
  Animation<double>? _rotateAnimation7;
  Animation<double>? _scaleAnimation7;
  Animation<Offset>? _transAnimation7;
  AnimationController? _animationController8;
  Animation<double>? _rotateAnimation8;
  Animation<double>? _scaleAnimation8;
  Animation<Offset>? _transAnimation8;
  AnimationController? _animationController9;
  Animation<double>? _rotateAnimation9;
  Animation<double>? _scaleAnimation9;
  Animation<Offset>? _transAnimation9;
  AnimationController? _animationController10;
  Animation<double>? _rotateAnimation10;
  Animation<double>? _scaleAnimation10;
  Animation<Offset>? _transAnimation10;
  AnimationController? _animationController_fish;
  Animation<double>? _rotateAnimation_fish;
  Animation<Offset>? _transAnimation_fish;
  AnimationController? _animationController_crab;
  Animation<Offset>? _transAnimation_crab;

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _rotateAnimation1 =
        Tween<double>(begin: 0, end: 10).animate(_animationController1!);
    _scaleAnimation1 =
        Tween<double>(begin: 0, end: 1).animate(_animationController1!);
    _transAnimation1 = Tween<Offset>(
            begin: const Offset(-510, 200), end: const Offset(-550, -600))
        .animate(_animationController1!);

    _animationController2 = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _rotateAnimation2 =
        Tween<double>(begin: 0, end: 10).animate(_animationController2!);
    _scaleAnimation2 =
        Tween<double>(begin: 0, end: 1).animate(_animationController2!);
    _transAnimation2 = Tween<Offset>(
            begin: const Offset(-530, 200), end: const Offset(-600, -500))
        .animate(_animationController2!);

    _animationController3 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation3 =
        Tween<double>(begin: 0, end: 10).animate(_animationController3!);
    _scaleAnimation3 =
        Tween<double>(begin: 0, end: 1).animate(_animationController3!);
    _transAnimation3 = Tween<Offset>(
            begin: const Offset(-550, 200), end: const Offset(-650, -800))
        .animate(_animationController3!);

    _animationController4 = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    _rotateAnimation4 =
        Tween<double>(begin: 0, end: 10).animate(_animationController4!);
    _scaleAnimation4 =
        Tween<double>(begin: 0, end: 1).animate(_animationController4!);
    _transAnimation4 = Tween<Offset>(
            begin: const Offset(-490, 200), end: const Offset(-500, -700))
        .animate(_animationController4!);

    _animationController5 = AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _rotateAnimation5 =
        Tween<double>(begin: 0, end: 10).animate(_animationController5!);
    _scaleAnimation5 =
        Tween<double>(begin: 0, end: 1).animate(_animationController5!);
    _transAnimation5 = Tween<Offset>(
            begin: const Offset(-470, 200), end: const Offset(-450, -900))
        .animate(_animationController5!);

    _animationController6 = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _rotateAnimation6 =
        Tween<double>(begin: 0, end: 10).animate(_animationController6!);
    _scaleAnimation6 =
        Tween<double>(begin: 0, end: 1).animate(_animationController6!);
    _transAnimation6 = Tween<Offset>(
            begin: const Offset(510, 200), end: const Offset(550, -700))
        .animate(_animationController6!);

    _animationController7 = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _rotateAnimation7 =
        Tween<double>(begin: 0, end: 10).animate(_animationController7!);
    _scaleAnimation7 =
        Tween<double>(begin: 0, end: 1).animate(_animationController7!);
    _transAnimation7 = Tween<Offset>(
            begin: const Offset(530, 200), end: const Offset(600, -800))
        .animate(_animationController7!);

    _animationController8 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation8 =
        Tween<double>(begin: 0, end: 10).animate(_animationController8!);
    _scaleAnimation8 =
        Tween<double>(begin: 0, end: 1).animate(_animationController8!);
    _transAnimation8 = Tween<Offset>(
            begin: const Offset(550, 200), end: const Offset(650, -900))
        .animate(_animationController8!);

    _animationController9 = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    _rotateAnimation9 =
        Tween<double>(begin: 0, end: 10).animate(_animationController9!);
    _scaleAnimation9 =
        Tween<double>(begin: 0, end: 1).animate(_animationController9!);
    _transAnimation9 = Tween<Offset>(
            begin: const Offset(490, 200), end: const Offset(500, -500))
        .animate(_animationController9!);

    _animationController10 = AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _rotateAnimation10 =
        Tween<double>(begin: 0, end: 10).animate(_animationController10!);
    _scaleAnimation10 =
        Tween<double>(begin: 0, end: 1).animate(_animationController10!);
    _transAnimation10 = Tween<Offset>(
            begin: const Offset(470, 200), end: const Offset(450, -600))
        .animate(_animationController10!);

    _animationController_fish = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _rotateAnimation_fish =
        Tween<double>(begin: 0, end: -0.2).animate(_animationController_fish!);
    _transAnimation_fish = Tween<Offset>(
            begin: const Offset(-420, 200), end: const Offset(-400, 180))
        .animate(_animationController_fish!);

    _animationController_crab = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _transAnimation_crab = Tween<Offset>(
        begin: const Offset(-30, 300), end: const Offset(-100, 300))
        .animate(_animationController_crab!);

    setState(() {
      // 왼쪽 물방울
      _animationController1!.repeat();
      _animationController2!.repeat();
      _animationController3!.repeat();
      _animationController4!.repeat();
      _animationController5!.repeat();

      //오른쪽 물방울
      _animationController6!.repeat();
      _animationController7!.repeat();
      _animationController8!.repeat();
      _animationController9!.repeat();
      _animationController10!.repeat();

      // 왼쪽 물고기
      _animationController_fish!.repeat(reverse: true);
      _animationController_crab!.repeat(reverse: true);
    });
  }

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
              child: AnimatedBuilder(
                animation: _rotateAnimation_fish!,
                builder: (context, widget) {
                  return Transform.translate(
                    offset: _transAnimation_fish!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_fish!.value,
                      child: widget,
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.fish,
                        width: MediaQuery.of(context).size.width * 0.15),
                  ),
                ),
              ),
            ),
            // Indexed(
            //   index: 1002,
            //   child: Positioned(
            //     bottom: MediaQuery.of(context).size.height * 0.15,
            //     left: MediaQuery.of(context).size.width * 0.08,
            //     child: Container(
            //       color: Colors.transparent,
            //       child: Center(
            //         child: Image.asset(AppIcons.fish,
            //             width: MediaQuery.of(context).size.width * 0.15),
            //       ),
            //     ),
            //   ),
            // ),
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
              child: AnimatedBuilder(
                animation: _transAnimation_crab!,
                builder: (context, widget) {
                  return Transform.translate(
                    offset: _transAnimation_crab!.value,
                    child: widget,
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(AppIcons.crabs,
                        width: MediaQuery.of(context).size.width * 0.25),
                  ),
                ),
              ),
            ),
            // Indexed(
            //   index: 1004,
            //   child: Positioned(
            //     bottom: MediaQuery.of(context).size.height * 0.02,
            //     left: MediaQuery.of(context).size.width * 0.3,
            //     child: Container(
            //       color: Colors.transparent,
            //       child: Center(
            //         child: Image.asset(AppIcons.crabs,
            //             width: MediaQuery.of(context).size.width * 0.25),
            //       ),
            //     ),
            //   ),
            // ),
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
            AnimatedBuilder(
              animation: _rotateAnimation1!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation1!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation1!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation1!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation2!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation2!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation2!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation2!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation3!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation3!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation3!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation3!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation4!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation4!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation4!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation4!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation5!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation5!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation5!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation5!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation6!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation6!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation6!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation6!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation7!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation7!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation7!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation7!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation8!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation8!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation8!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation8!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation9!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation9!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation9!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation9!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rotateAnimation10!,
              builder: (context, widget) {
                return Transform.translate(
                  offset: _transAnimation10!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation10!.value,
                    child: Transform.scale(
                      scale: _scaleAnimation10!.value,
                      child: widget,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.water_test,
                      width: MediaQuery.of(context).size.width * 0.14),
                ),
              ),
            ),
            // Indexed(
            //   index: 1006,
            //   child: Positioned(
            //     top: MediaQuery.of(context).size.height * 0.1,
            //     right: MediaQuery.of(context).size.width * 0.01,
            //     child: Container(
            //       color: Colors.transparent,
            //       child: Center(
            //         child: Image.asset(AppIcons.water_right,
            //             width: MediaQuery.of(context).size.width * 0.12),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
