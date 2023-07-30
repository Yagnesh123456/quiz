import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/presentation/controllers/controllers.dart';
import 'package:quiz/presentation/pages/auth_and_profile/profile_screen.dart';
import 'package:quiz/presentation/widgets/common/content_area.dart';
import 'package:quiz/presentation/widgets/common/sizebox_space.dart';
import 'package:quiz/presentation/widgets/home/quiz_paper_card.dart';
import 'package:quiz/app/utils/language_constant.dart';



class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';
  

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => Container(
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  horizontalSpace(width: 18),
                  Obx(() => controller.user.value == null
                      ? TextButton.icon(
                      icon: const Icon(Icons.login_rounded),
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          elevation: 0,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          primary: Colors.white),
                      onPressed: () {
                        controller.signIn();
                      },
                      label: Text(LANG_CONST.SIGN_IN.toString().tr))
                      : GestureDetector(
                    onTap: () {
                      Get.toNamed(ProfileScreen.routeName);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 12, bottom: 10),
                        child: CircleAvatar(
                          foregroundImage:
                          controller.user.value!.photoURL == null
                              ? null
                              : NetworkImage(
                              controller.user.value!.photoURL!),
                          backgroundColor: Colors.white,
                          radius: 32,
                        ),
                      ),
                    ),
                  )),
                  horizontalSpace(width: 4),
                  Builder(
                    builder: (_) {
                      final AuthController _auth = Get.find();
                      final user = _auth.getUser();
                      String _label = LANG_CONST.HELLO.toString().tr + " "+
                          LANG_CONST.MATE.toString().tr;
                      if (user != null) {
                        _label = '${LANG_CONST.HELLO.toString().tr} ${user.displayName}';
                      }
                      return Text(_label,
                          style: kDetailsTS.copyWith(
                              color: kOnSurfaceTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,

                          ));
                    },
                  ),

                  const Spacer(flex: 4),

                  Obx(() => controller.user.value == null
                      ? const SizedBox()
                      : InkWell(
                    onTap:() => controller.signOut(),
                        child: const Icon(
                    AppIcons.logout,
                    size: 18,
                  ),
                      )
                  ),
                  horizontalSpace(width: 8),

                ],
              ),

               Padding(
                padding: const EdgeInsets.all(kMobileScreenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LANG_CONST.WHAT_DO_YOU_WANT.toString().tr,
                        style: kHeaderTS),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ContentArea(
                    addPadding: false,
                    child: Obx(
                          () => LiquidPullToRefresh(
                        height: 150,
                        springAnimationDurationInMilliseconds: 500,
                        color:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                        onRefresh: () async {
                          _quizePprContoller.getAllPapers();
                        },
                        child: ListView.separated(
                          padding: UIParameters.screenPadding,
                          shrinkWrap: true,
                          itemCount: _quizePprContoller.allPapers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return QuizPaperCard(
                              model: _quizePprContoller.allPapers[index],
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ));
  }
}
