import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/domain/model/model_donggle_talk.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class donggleTalk extends StatefulWidget {
  const donggleTalk({super.key});

  @override
  State<donggleTalk> createState() => _donggleTalkState();
}

class _donggleTalkState extends State<donggleTalk> {
  late DonggleTalkModel donggleTalkModel;
  bool touched_donggle = false;

  void setTouchedDonggle() {
    setState(() {
      touched_donggle = !touched_donggle;
    });
  }

  @override
  void initState() {
    super.initState();
    donggleTalkModel = Provider.of<DonggleTalkModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: true, // 상위 Container의 터치를 무시
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.transparent,
            child: Stack(
              children: [
                // 이곳에 터치 이벤트를 무시하고 싶은 다른 위젯들을 배치
                touched_donggle
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.width * 0.01,
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            AppIcons.donggle_talk_balloon,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                      )
                    : Container(),
                Text('안녕'),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: false, // 이 Container만 터치 가능하도록 설정
            child: GestureDetector(
              onTap: () {
                setTouchedDonggle();
                donggleTalkModel.getDonggleTalk();
              },
              child: Image.asset(
                AppIcons.donggle,
                width: MediaQuery.of(context).size.width * 0.22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
