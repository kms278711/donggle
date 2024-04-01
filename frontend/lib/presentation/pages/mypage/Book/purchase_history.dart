import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/domain/model/model_approvals.dart';
import 'package:frontend/presentation/pages/mypage/approval/approval_card.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  late ApprovalsModel approvalsModel;
  late UserProvider userProvider;
  List<dynamic> approvals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      approvalsModel = Provider.of<ApprovalsModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.getAccessToken();

      await approvalsModel.getApprovals(accessToken);

      if (mounted) {
        setState(() {
          approvals = approvalsModel.myApprovals;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return approvals.length == 0
        ? Center(
          child: Text(
              "구매내역이 없습니다.",
              // Use the data from the snapshot
              textAlign: TextAlign.center,
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.unSelectedLarge),
            ),
        )
        : Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.725,
                child: Column(
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ListView.builder(
                          itemCount: approvals.length,
                          itemBuilder: (BuildContext context, int index) {
                            Approval approval =
                                Approval.fromJson(approvals[index]);
                            return ApprovalCard(approval);
                          },
                          shrinkWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  right: MediaQuery.of(context).size.width * 0.015,
                  child: GreenButton(
                    "돌아가기",
                    onPressed: () {
                      context.read<MainProvider>().resetPurchaseHistory();
                    },
                  ))
            ],
          );
  }
}
