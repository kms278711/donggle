import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class FinishQuizPage extends StatefulWidget {
  List selectedAnswer;

  FinishQuizPage(this.selectedAnswer, {super.key});

  @override
  State<FinishQuizPage> createState() => _FinishQuizPageState();
}

class _FinishQuizPageState extends State<FinishQuizPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.textMedium,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(217, 217, 217, 0.9),
        ),
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.5,
              ),
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemCount: widget.selectedAnswer.length,
              itemBuilder: (context, index) {
                bool check = widget.selectedAnswer[index]["answer"];
                String url = widget.selectedAnswer[index]["choiceImagePath"];
                String name = widget.selectedAnswer[index]["choice"];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: Constant.s3BaseUrl + url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Text('$name'),
                  ],
                );
              },
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.2,
              bottom: MediaQuery.of(context).size.width * 0.03,
              child: GreenButton(
                '참 잘했어요~!',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            // Positioned(
            //   bottom: MediaQuery.of(context).size.height * 0.06,
            //   right: -2,
            //   child: Container(
            //     color: Colors.transparent,
            //     child: Center(
            //       child: Image.asset(AppIcons.donggle_quiz,
            //           width: MediaQuery.of(context).size.width * 0.25),
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: const donggleTalk(situation: "QUIZRESULT"),
            ),
          ],
        ),
      ),
    );
  }
}
