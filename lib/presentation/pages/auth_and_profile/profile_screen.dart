import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/presentation/controllers/controllers.dart';
import 'package:quiz/presentation/widgets/common/content_area.dart';
import 'package:quiz/presentation/widgets/common/custom_app_bar.dart';
import 'package:quiz/presentation/widgets/common/screen_background_decoration.dart';
import 'package:quiz/presentation/widgets/profile/recent_quiz_card.dart';
import 'package:quiz/app/utils/language_constant.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UIParameters.screenPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        foregroundImage:
                            NetworkImage(_auth.getUser()!.photoURL!),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        _auth.getUser()!.displayName ?? '',
                        style: kHeaderTS,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      LANG_CONST.MY_RECENT_TESTS.toString().tr,
                      style: const TextStyle(
                          color: kOnSurfaceTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ContentArea(
                  addPadding: false,
                  child: controller.allRecentTest.isNotEmpty
                      ? ListView.separated(
                          padding: UIParameters.screenPadding,
                          itemCount: controller.allRecentTest.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return RecentQuizCard(
                                recentTest: controller.allRecentTest[index]);
                          },
                        )
                      : Center(
                          child: Text(
                            LANG_CONST.NO_RECORD_FOUND.toString().tr,
                            style: kQuizeTS,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
