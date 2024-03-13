import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class nickNameUpdateModal extends StatelessWidget {
  final String title;
  final Widget input;

  const nickNameUpdateModal({
    super.key,
    required this.title,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    late NickNameUpdateModel nickName =
        Provider.of<NickNameUpdateModel>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: CustomFontStyle.getTextStyle(
            context, CustomFontStyle.textMediumLarge2),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: const NickNameInput(),
      ),
      actions: <Widget>[
        GreenButton(
          "확인",
          onPressed: () {
            nickName.nickNameUpdate(nickName.nickName);
            Navigator.of(context).pop(); // 모달 닫기
          }, // 모달 닫기
        ),
        TextButton(
          child: Text(
            "취소",
            style: CustomFontStyle.getTextStyle(
                (context), CustomFontStyle.textMedium),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // 모달 닫기
          },
        ),
      ],
    );
  }
}

class NickNameInput extends StatelessWidget {
  const NickNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final nickName =
        Provider.of<NickNameUpdateModel>(context, listen: true);

    return Container(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.01,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nickName.nickNameController,
            onChanged: (nickname) {
              nickName.setNickName(nickname);
            },
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.textSmall),
            decoration: const InputDecoration(
              hintText: '큰눈',
              // 현재 닉네임으로
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
