import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:frontend/presentation/routes/routes.dart';

class BookFinishModal extends StatefulWidget {
  final int bookId;
  final VoidCallback? onModalClose;

  const BookFinishModal(this.bookId, {this.onModalClose, super.key});

  @override
  State<BookFinishModal> createState() => _BookFinishModalState();
}

class _BookFinishModalState extends State<BookFinishModal> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.95,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("동화가 끝났어요!", style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GreenButton("처음부터 다시보기", onPressed: () {
                          Navigator.of(context).pop();
                          globalRouter.pushReplacement('/bookProgress/${widget.bookId}/1/0');
                        }),
                        GreenButton("홈으로 돌아가기", onPressed: () {
                          Navigator.of(context).pop();
                          globalRouter.pushReplacement(RoutePath.main0);
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
