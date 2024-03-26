import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/add_post_position_text.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/book/modal/expression_camera.dart';
import 'package:provider/provider.dart';

class ExpressionQuiz extends StatefulWidget {
  final VoidCallback? onModalClose;

  const ExpressionQuiz({this.onModalClose, super.key});

  @override
  State<ExpressionQuiz> createState() => _ExpressionQuizState();
}

class _ExpressionQuizState extends State<ExpressionQuiz> {
  late BookModel bookModel;

  bool _isLoading = true;
  String url = "";
  String educationWord = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bookModel = Provider.of<BookModel>(context, listen: false);

      if (mounted) {
        setState(() {
          String path = bookModel.nowEducation.imagePath;
          url = Constant.s3BaseUrl + path;
          educationWord = bookModel.nowEducation.wordName;

          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build method now only contains UI code
    return DefaultTextStyle(
      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMedium),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(217, 217, 217, 0.9),
        ),
        child: _isLoading
            ? Container()
            : Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.65,
                      left: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        "${postPositionText(educationWord)} 따라해보세요.",
                        textAlign: TextAlign.center,
                      )),
                  Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: const FittedBox(
                                  fit: BoxFit.cover,
                                  child: ExpressionCamera(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                    child: IconButton(
                      icon: const CloseCircle(),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onModalClose?.call();
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
