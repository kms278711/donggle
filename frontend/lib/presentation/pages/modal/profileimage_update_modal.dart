import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/domain/model/model_profileupdate.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class profileImageUpdateModal extends StatefulWidget {
  final String title;

  const profileImageUpdateModal({
    super.key,
    required this.title,
  });

  @override
  State<profileImageUpdateModal> createState() =>
      _profileImageUpdateModalState();
}

class _profileImageUpdateModalState extends State<profileImageUpdateModal> {
  late UserProvider userProvider;
  String profileImage = "";
  String userId = "";
  String profileName = "";

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    profileImage = userProvider.getProfileImage();
    userId = userProvider.getUserId();
  }

  final List<PlatformFile> _files = [];

  void _pickFiles() async {
    List<PlatformFile>? uploadedFiles = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
      // allowMultiple: true,
    ))
        ?.files;
    setState(() {
      for (PlatformFile file in uploadedFiles!) {
        _files.add(file);
        profileName = _files[0].name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    late ProfileUpdateModel profile =
        Provider.of<ProfileUpdateModel>(context, listen: false);

    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        widget.title,
        style: CustomFontStyle.getTextStyle(
            context, CustomFontStyle.textMediumLarge2),
      ),
      content: InkWell(
        onTap: () {
          _pickFiles();
          _files.clear();
        },
        child: _files.isEmpty
            ? CachedNetworkImage(
              imageUrl: Constant.s3BaseUrl + profileImage,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              // fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
            )
            : Image.file(File(_files[0].path!)),
      ),
      actions: <Widget>[
        GreenButton(
          "변경",
          onPressed: () {
            profile.profileUpdate(_files[0].path!);
            _files.clear();
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
            // nickName.resetFields();
            _files.clear();
            Navigator.of(context).pop(); // 모달 닫기
          },
        ),
      ],
    );
  }
}
