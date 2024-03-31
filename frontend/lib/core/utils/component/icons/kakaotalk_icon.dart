import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:provider/provider.dart';

class KakaotalkIcon extends StatelessWidget {
  const KakaotalkIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context, listen: false);
    return InkWell(
      onTap: () {
        // auth.signInWithKakao();
        },
      child: Image.asset(AppIcons.kakaotalk_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
