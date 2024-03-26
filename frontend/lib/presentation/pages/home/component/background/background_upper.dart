import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/domain/model/model_donggle_talk.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class BackgroundUpper extends StatefulWidget {
  const BackgroundUpper({super.key});

  @override
  State<BackgroundUpper> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundUpper>
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
  AnimationController? _animationController_crab1;
  Animation<double>? _rotateAnimation_crab1;
  Animation<Offset>? _transAnimation_crab1;
  AnimationController? _animationController_crab2;
  Animation<double>? _rotateAnimation_crab2;
  Animation<Offset>? _transAnimation_crab2;
  AnimationController? _animationController_crab3;
  Animation<double>? _rotateAnimation_crab3;
  Animation<Offset>? _transAnimation_crab3;
  AnimationController? _animationController_crab4;
  Animation<double>? _rotateAnimation_crab4;
  Animation<Offset>? _transAnimation_crab4;
  AnimationController? _animationController_jellyfish;
  Animation<double>? _rotateAnimation_jellyfish;
  Animation<Offset>? _transAnimation_jellyfish;


  @override
  void initState() {
    super.initState();

    _animationController1 = AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _rotateAnimation1 =
        Tween<double>(begin: 0, end: 10).animate(_animationController1!);
    _scaleAnimation1 =
        Tween<double>(begin: 0, end: 1).animate(_animationController1!);
    // _transAnimation1 = Tween<Offset>(
    //         begin: const Offset(-510, 200), end: const Offset(-550, -600))
    //     .animate(_animationController1!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation1 = Tween<Offset>(
              begin: Offset(screenWidth * -0.42, screenHeight * 0.25),
              end: Offset(screenWidth * -0.44, screenHeight * -0.65))
          .animate(_animationController1!);
    });

    _animationController2 = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _rotateAnimation2 =
        Tween<double>(begin: 0, end: 10).animate(_animationController2!);
    _scaleAnimation2 =
        Tween<double>(begin: 0, end: 1).animate(_animationController2!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation2 = Tween<Offset>(
              begin: Offset(screenWidth * -0.43, screenHeight * 0.25),
              end: Offset(screenWidth * -0.465, screenHeight * -0.6))
          .animate(_animationController2!);
    });

    _animationController3 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation3 =
        Tween<double>(begin: 0, end: 10).animate(_animationController3!);
    _scaleAnimation3 =
        Tween<double>(begin: 0, end: 1).animate(_animationController3!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation3 = Tween<Offset>(
              begin: Offset(screenWidth * -0.45, screenHeight * 0.25),
              end: Offset(screenWidth * -0.5, screenHeight * -0.85))
          .animate(_animationController3!);
    });

    _animationController4 = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    _rotateAnimation4 =
        Tween<double>(begin: 0, end: 10).animate(_animationController4!);
    _scaleAnimation4 =
        Tween<double>(begin: 0, end: 1).animate(_animationController4!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation4 = Tween<Offset>(
              begin: Offset(screenWidth * -0.4, screenHeight * 0.25),
              end: Offset(screenWidth * -0.41, screenHeight * -0.77))
          .animate(_animationController4!);
    });

    _animationController5 = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _rotateAnimation5 =
        Tween<double>(begin: 0, end: 10).animate(_animationController5!);
    _scaleAnimation5 =
        Tween<double>(begin: 0, end: 1).animate(_animationController5!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation5 = Tween<Offset>(
              begin: Offset(screenWidth * -0.38, screenHeight * 0.25),
              end: Offset(screenWidth * -0.36, screenHeight * -0.9))
          .animate(_animationController5!);
    });

    _animationController6 = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _rotateAnimation6 =
        Tween<double>(begin: 0, end: 10).animate(_animationController6!);
    _scaleAnimation6 =
        Tween<double>(begin: 0, end: 1).animate(_animationController6!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation6 = Tween<Offset>(
              begin: Offset(screenWidth * 0.42, screenHeight * 0.25),
              end: Offset(screenWidth * 0.44, screenHeight * -0.77))
          .animate(_animationController6!);
    });

    _animationController7 = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    _rotateAnimation7 =
        Tween<double>(begin: 0, end: 10).animate(_animationController7!);
    _scaleAnimation7 =
        Tween<double>(begin: 0, end: 1).animate(_animationController7!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation7 = Tween<Offset>(
              begin: Offset(screenWidth * 0.43, screenHeight * 0.25),
              end: Offset(screenWidth * 0.465, screenHeight * -0.9))
          .animate(_animationController7!);
    });

    _animationController8 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation8 =
        Tween<double>(begin: 0, end: 10).animate(_animationController8!);
    _scaleAnimation8 =
        Tween<double>(begin: 0, end: 1).animate(_animationController8!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation8 = Tween<Offset>(
              begin: Offset(screenWidth * 0.45, screenHeight * 0.25),
              end: Offset(screenWidth * 0.5, screenHeight * -0.9))
          .animate(_animationController8!);
    });

    _animationController9 = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    _rotateAnimation9 =
        Tween<double>(begin: 0, end: 10).animate(_animationController9!);
    _scaleAnimation9 =
        Tween<double>(begin: 0, end: 1).animate(_animationController9!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation9 = Tween<Offset>(
              begin: Offset(screenWidth * 0.4, screenHeight * 0.25),
              end: Offset(screenWidth * 0.41, screenHeight * -0.63))
          .animate(_animationController9!);
    });

    _animationController10 = AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _rotateAnimation10 =
        Tween<double>(begin: 0, end: 10).animate(_animationController10!);
    _scaleAnimation10 =
        Tween<double>(begin: 0, end: 1).animate(_animationController10!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation10 = Tween<Offset>(
              begin: Offset(screenWidth * 0.38, screenHeight * 0.25),
              end: Offset(screenWidth * 0.36, screenHeight * -0.7))
          .animate(_animationController10!);
    });

    _animationController_fish = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _rotateAnimation_fish =
        Tween<double>(begin: 0, end: -0.2).animate(_animationController_fish!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_fish = Tween<Offset>(
              begin: Offset(screenWidth * -0.37, screenHeight * 0.25),
              end: Offset(screenWidth * -0.33, screenHeight * 0.22))
          .animate(_animationController_fish!);
    });

    _animationController_crab1 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation_crab1 = Tween<double>(begin: 0.2, end: 0.01)
        .animate(_animationController_crab1!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_crab1 = Tween<Offset>(
              begin: Offset(screenWidth * -0.07, screenHeight * 0.405),
              end: Offset(screenWidth * -0.14, screenHeight * 0.4))
          .animate(_animationController_crab1!);
    });

    _animationController_crab2 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation_crab2 = Tween<double>(begin: -0.3, end: -0.35)
        .animate(_animationController_crab2!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_crab2 = Tween<Offset>(
              begin: Offset(screenWidth * 0, screenHeight * 0.39),
              end: Offset(screenWidth * -0.05, screenHeight * 0.415))
          .animate(_animationController_crab2!);
    });

    _animationController_crab3 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation_crab3 = Tween<double>(begin: 0, end: -0.23)
        .animate(_animationController_crab3!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_crab3 = Tween<Offset>(
              begin: Offset(screenWidth * 0.06, screenHeight * 0.37),
              end: Offset(screenWidth * 0.01, screenHeight * 0.38))
          .animate(_animationController_crab3!);
    });

    _animationController_crab4 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _rotateAnimation_crab4 = Tween<double>(begin: 0.1, end: 0.03)
        .animate(_animationController_crab4!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_crab4 = Tween<Offset>(
              begin: Offset(screenWidth * 0.12, screenHeight * 0.375),
              end: Offset(screenWidth * 0.07, screenHeight * 0.37))
          .animate(_animationController_crab4!);
    });

    _animationController_jellyfish = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    _rotateAnimation_jellyfish = Tween<double>(begin: 0.1, end: 0.3)
        .animate(_animationController_jellyfish!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_jellyfish = Tween<Offset>(
              begin: Offset(screenWidth * 0.36, screenHeight * 0.2),
              end: Offset(screenWidth * 0.33, screenHeight * 0.15))
          .animate(_animationController_jellyfish!);
    });

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

    // 게 가족
    _animationController_crab1!.repeat(reverse: true);
    _animationController_crab2!.repeat(reverse: true);
    _animationController_crab3!.repeat(reverse: true);
    _animationController_crab4!.repeat(reverse: true);

    // 해파리
    _animationController_jellyfish!.repeat(reverse: true);
  }

  @override
  void dispose() {
    // 왼쪽 물방울
    _animationController1!.dispose();
    _animationController2!.dispose();
    _animationController3!.dispose();
    _animationController4!.dispose();
    _animationController5!.dispose();

    //오른쪽 물방울
    _animationController6!.dispose();
    _animationController7!.dispose();
    _animationController8!.dispose();
    _animationController9!.dispose();
    _animationController10!.dispose();

    // 왼쪽 물고기
    _animationController_fish!.dispose();

    // 게 가족
    _animationController_crab1!.dispose();
    _animationController_crab2!.dispose();
    _animationController_crab3!.dispose();
    _animationController_crab4!.dispose();

    // 해파리
    _animationController_jellyfish!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Indexer(
      children: <Widget>[
        Indexed(
          index: 1001,
          child: Positioned(
            left: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                color: Colors.transparent,
                child: Image.asset(AppIcons.seaweedLeft,
                    width: MediaQuery.of(context).size.width * 0.225),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1001,
          child: Positioned(
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                color: Colors.transparent,
                child: Image.asset(AppIcons.seaweedRight2,
                    width: MediaQuery.of(context).size.width * 0.18),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1002,
          child: Positioned(
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                color: Colors.transparent,
                child: Image.asset(AppIcons.seaweedRight1,
                    width: MediaQuery.of(context).size.width * 0.18),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1003,
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
          index: 1003,
          child: Positioned(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _rotateAnimation_fish!,
                builder: (context, widget) {
                  if (_transAnimation_fish != null) {
                    return Transform.translate(
                      offset: _transAnimation_fish!.value,
                      child: Transform.rotate(
                        angle: _rotateAnimation_fish!.value,
                        child: widget,
                      ),
                    );
                  } else {
                    return Container();
                  }
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
          index: 1004,
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
          index: 1005,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _rotateAnimation_crab1!,
              builder: (context, widget) {
                if (_transAnimation_crab1 != null) {
                  return Transform.translate(
                    offset: _transAnimation_crab1!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_crab1!.value,
                      child: widget,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.crab,
                      width: MediaQuery.of(context).size.width * 0.08),
                ),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1005,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _rotateAnimation_crab2!,
              builder: (context, widget) {
                if (_transAnimation_crab2 != null) {
                  return Transform.translate(
                    offset: _transAnimation_crab2!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_crab2!.value,
                      child: widget,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.crab,
                      width: MediaQuery.of(context).size.width * 0.06),
                ),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1005,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _rotateAnimation_crab3!,
              builder: (context, widget) {
                if (_transAnimation_crab3 != null) {
                  return Transform.translate(
                    offset: _transAnimation_crab3!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_crab3!.value,
                      child: widget,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.crab,
                      width: MediaQuery.of(context).size.width * 0.06),
                ),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1005,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _rotateAnimation_crab4!,
              builder: (context, widget) {
                if (_transAnimation_crab4 != null) {
                  return Transform.translate(
                    offset: _transAnimation_crab4!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_crab4!.value,
                      child: widget,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.crab,
                      width: MediaQuery.of(context).size.width * 0.06),
                ),
              ),
            ),
          ),
        ),
        Indexed(
          index: 1000,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _rotateAnimation_jellyfish!,
              builder: (context, widget) {
                if (_transAnimation_jellyfish != null) {
                  return Transform.translate(
                    offset: _transAnimation_jellyfish!.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation_jellyfish!.value,
                      child: widget,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(AppIcons.jellyfish,
                      width: MediaQuery.of(context).size.width * 0.15),
                ),
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
        // Indexed(
        //   index: 1005,
        //   child: Positioned(
        //     bottom: MediaQuery.of(context).size.height * 0.1,
        //     right: 0,
        //     child: const donggleTalk(),
        //   ),
        // ),
        // Indexed(
        //   index: 1005,
        //   child: Positioned(
        //     bottom: MediaQuery.of(context).size.height * 0.04,
        //     right: 0,
        //     child: Container(
        //       color: Colors.transparent,
        //       child: Center(
        //         child: GestureDetector(
        //           onTap: () {
        //             setTouchedDonggle();
        //             donggleTalkModel.getDonggleTalk();
        //           },
        //           child: Image.asset(AppIcons.donggle,
        //               width: MediaQuery.of(context).size.width * 0.22),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation1!,
            builder: (context, widget) {
              if (_transAnimation1 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation2!,
            builder: (context, widget) {
              if (_transAnimation2 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation3!,
            builder: (context, widget) {
              if (_transAnimation3 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation4!,
            builder: (context, widget) {
              if (_transAnimation4 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation5!,
            builder: (context, widget) {
              if (_transAnimation5 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation6!,
            builder: (context, widget) {
              if (_transAnimation6 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation7!,
            builder: (context, widget) {
              if (_transAnimation7 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation8!,
            builder: (context, widget) {
              if (_transAnimation8 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation9!,
            builder: (context, widget) {
              if (_transAnimation9 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _rotateAnimation10!,
            builder: (context, widget) {
              if (_transAnimation10 != null) {
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
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.water_test,
                    width: MediaQuery.of(context).size.width * 0.14),
              ),
            ),
          ),
        ),
        // Indexed(
        //   index: 1006,
        //   child: Positioned(
        //     top: MediaQuery.of(context).size.height * 0.1,
        //     left: MediaQuery.of(context).size.width * 0.01,
        //     child: Container(
        //       color: Colors.transparent,
        //       child: Center(
        //         child: Image.asset(AppIcons.water_left,
        //             width: MediaQuery.of(context).size.width * 0.12),
        //       ),
        //     ),
        //   ),
        // ),
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
    );
  }
}
