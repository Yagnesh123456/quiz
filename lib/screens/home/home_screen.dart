
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quiz/configs/configs.dart';
import 'package:quiz/controllers/controllers.dart';
import 'package:quiz/screens/auth_and_profile/profile_screen.dart';
import 'package:quiz/widgets/common/sizebox_space.dart';
import 'package:quiz/widgets/widgets.dart';


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
                      label: const Text("Sign in"))
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
                      String _label = '  Hello mate';
                      if (user != null) {
                        _label = '  Hello ${user.displayName}';
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
                  children: const [
                    Text('What Do You Want To Improve Today ?',
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
